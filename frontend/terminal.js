'use strict';
(() => {
  // Fail loudly if the vendored libraries didn't load (e.g. vendor/ folder missing).
  if (typeof Terminal === 'undefined' || typeof FitAddon === 'undefined') {
    const el = document.getElementById('terminal');
    el.style.color = '#e06c75';
    el.style.whiteSpace = 'pre-wrap';
    el.textContent = 'Could not load xterm.js.\n' +
      'Make sure the vendor/ folder (xterm.js, xterm.css, addon-fit.js) sits next to index.html,\n' +
      'then check the browser console (F12) for 404 errors.';
    return;
  }
  const NOT_READY = 0, READY = 1;
  const HEADER_INTS = 2;
  const DATA_MAX = 65536;

  const ESC = '\x1b';
  const dim = (s) => `${ESC}[2m${s}${ESC}[0m`;
  const red = (s) => `${ESC}[31m${s}${ESC}[0m`;
  const left = (n) => (n > 0 ? `${ESC}[${n}D` : '');
  const right = (n) => (n > 0 ? `${ESC}[${n}C` : '');

  const term = new Terminal({
    cursorBlink: true,
    fontSize: 15,
    fontFamily: 'ui-monospace, "JetBrains Mono", "Cascadia Code", Menlo, Consolas, monospace',
    scrollback: 5000,
    theme: {
      background: '#12141a',
      foreground: '#d6dae4',
      cursor: '#e0b25c',
      selectionBackground: '#3a4052',
    },
  });
  const fit = new FitAddon.FitAddon();
  term.loadAddon(fit);
  term.open(document.getElementById('terminal'));
  const refit = () => { try { fit.fit(); } catch (_) {} };
  refit();
  window.addEventListener('resize', refit);
  term.focus();
  document.getElementById('terminal').addEventListener('click', () => term.focus());

  // ---------- session state ----------
  let worker = null;
  let control = null, dataBytes = null;
  let chunks = [];            // pending input chunks (Uint8Array)
  let state = 'idle';         // idle | loading | running | exited
  let atLineStart = true;
  const decoders = {};
  const encoder = new TextEncoder();

  // ---------- line editor ----------
  let line = '';
  let cur = 0;
  const history = [];
  let histIdx = 0;

  function write(text) {
    if (!text) return;
    term.write(text);
    atLineStart = text.endsWith('\n');
  }

  function setLine(next) {
    term.write(left(cur) + `${ESC}[K` + next);
    line = next;
    cur = next.length;
  }

  function insert(text) {
    const tail = line.slice(cur);
    line = line.slice(0, cur) + text + tail;
    cur += text.length;
    term.write(text + tail + left(tail.length));
    atLineStart = false;
  }

  function backspace() {
    if (cur === 0) return;
    const tail = line.slice(cur);
    line = line.slice(0, cur - 1) + tail;
    cur--;
    term.write(left(1) + tail + ' ' + left(tail.length + 1));
  }

  function del() {
    if (cur >= line.length) return;
    const tail = line.slice(cur + 1);
    line = line.slice(0, cur) + tail;
    term.write(tail + ' ' + left(tail.length + 1));
  }

  function submit() {
    term.write('\r\n');
    atLineStart = true;
    const text = line;
    if (text.trim() && history[history.length - 1] !== text) history.push(text);
    histIdx = history.length;
    line = '';
    cur = 0;
    const bytes = encoder.encode(text + '\n');
    for (let i = 0; i < bytes.length; i += DATA_MAX) chunks.push(bytes.subarray(i, i + DATA_MAX));
    flushInput();
  }

  function endSession() {
    if (worker) worker.terminate();
    worker = null;
    state = 'exited';
    term.write((atLineStart ? '' : '\r\n') + '^D\r\n' +
      dim('[session ended] press any key to restart') + '\r\n');
    atLineStart = true;
  }

  function flushInput() {
    if (!control || !chunks.length) return;
    if (Atomics.load(control, 0) !== NOT_READY) return; // worker hasn't taken the last one yet
    const next = chunks.shift();
    dataBytes.set(next);
    Atomics.store(control, 1, next.length);
    Atomics.store(control, 0, READY);
    Atomics.notify(control, 0);
  }

  const KEYS = [
    [`${ESC}[A`, 'up'], [`${ESC}[B`, 'down'], [`${ESC}[C`, 'right'], [`${ESC}[D`, 'left'],
    [`${ESC}[H`, 'home'], [`${ESC}[F`, 'end'], [`${ESC}OH`, 'home'], [`${ESC}OF`, 'end'],
    [`${ESC}[1~`, 'home'], [`${ESC}[4~`, 'end'], [`${ESC}[3~`, 'delete'],
  ];

  function handleKey(name) {
    switch (name) {
      case 'up':
        if (histIdx > 0) setLine(history[--histIdx]);
        break;
      case 'down':
        if (histIdx < history.length - 1) setLine(history[++histIdx]);
        else if (histIdx === history.length - 1) { histIdx = history.length; setLine(''); }
        break;
      case 'left': if (cur > 0) { cur--; term.write(left(1)); } break;
      case 'right': if (cur < line.length) { cur++; term.write(right(1)); } break;
      case 'home': term.write(left(cur)); cur = 0; break;
      case 'end': term.write(right(line.length - cur)); cur = line.length; break;
      case 'delete': del(); break;
    }
  }

  term.onData((data) => {
    if (state === 'exited') { start(); return; }
    if (state !== 'running') return;

    let i = 0;
    while (i < data.length) {
      const ch = data[i];

      if (ch === ESC) {
        const hit = KEYS.find(([seq]) => data.startsWith(seq, i));
        if (hit) { handleKey(hit[1]); i += hit[0].length; }
        else i++; // drop unknown escape sequences
        continue;
      }

      if (ch === '\r' || ch === '\n') {
        submit();
        if (ch === '\r' && data[i + 1] === '\n') i++; // CRLF from paste
      } else if (ch === '\x7f' || ch === '\b') {
        backspace();
      } else if (ch === '\x03') {            // Ctrl+C: discard the current line
        setLine('');
      } else if (ch === '\x04') {            // Ctrl+D on an empty line: end the session
        if (!line) endSession(); else del();
      } else if (ch === '\x01') { handleKey('home'); }
      else if (ch === '\x05') { handleKey('end'); }
      else if (ch === '\x15') { setLine(''); }  // Ctrl+U
      else if (ch === '\x0c') { term.clear(); }  // Ctrl+L
      else if (ch >= ' ') {
        // gather a run of printable characters (handles paste efficiently)
        let j = i;
        while (j < data.length && data[j] >= ' ' && data[j] !== '\x7f') j++;
        insert(data.slice(i, j));
        i = j;
        continue;
      }
      i++;
    }
  });

  // ---------- worker lifecycle ----------
  function onOutput(fd, bytes) {
    const dec = decoders[fd] || (decoders[fd] = new TextDecoder('utf-8'));
    const text = dec.decode(bytes, { stream: true }).replace(/\r?\n/g, '\r\n');
    if (!text) return;
    if (fd === 2) {
      term.write(red(text));
      atLineStart = text.endsWith('\n');
    } else {
      write(text);
    }
  }

  function showProblem(lines) {
    term.write(lines.map((l) => red(l)).join('\r\n') + '\r\n');
    state = 'idle';
  }

  function start() {
    if (worker) worker.terminate();
    term.reset();
    refit();
    line = ''; cur = 0; chunks = [];
    decoders[1] = decoders[2] = null;
    atLineStart = true;

    const sab = new SharedArrayBuffer(HEADER_INTS * 4 + DATA_MAX);
    control = new Int32Array(sab, 0, HEADER_INTS);
    dataBytes = new Uint8Array(sab, HEADER_INTS * 4, DATA_MAX);

    const w = new Worker('lisp-worker.js');
    worker = w;
    state = 'loading';
    term.write(dim('Loading sonchaLISP…'));

    w.onmessage = (e) => {
      if (w !== worker) return;
      const msg = e.data;
      switch (msg.type) {
        case 'ready':
          term.write(`\r${ESC}[2K`);
          state = 'running';
          break;
        case 'out':
          if (state === 'loading') { term.write(`\r${ESC}[2K`); state = 'running'; }
          onOutput(msg.fd, msg.bytes);
          break;
        case 'consumed':
          flushInput();
          break;
        case 'fatal':
          term.write(red(msg.text) + '\r\n');
          break;
        case 'exit':
          state = 'exited';
          term.write((atLineStart ? '' : '\r\n') +
            dim(`[process exited with code ${msg.code}] press any key to restart`) + '\r\n');
          break;
      }
    };
    w.onerror = (e) => {
      if (w !== worker) return;
      state = 'exited';
      term.write((atLineStart ? '' : '\r\n') +
        red(`[error] ${e.message || 'worker failed'}`) + '\r\n' +
        dim('press any key to restart') + '\r\n');
    };
    w.postMessage({ type: 'init', sab });
    term.focus();
  }

  document.getElementById('restart').addEventListener('click', () => {
    if (window.crossOriginIsolated) start();
    term.focus();
  });

  // ---------- boot: make sure SharedArrayBuffer is available ----------
  async function boot() {
    if (window.crossOriginIsolated && typeof SharedArrayBuffer !== 'undefined') {
      sessionStorage.removeItem('coi-reloaded');
      start();
      return;
    }
    if ('serviceWorker' in navigator && window.isSecureContext) {
      try {
        await navigator.serviceWorker.register('coi-serviceworker.js');
        if (!sessionStorage.getItem('coi-reloaded')) {
          sessionStorage.setItem('coi-reloaded', '1');
          location.reload();
          return;
        }
      } catch (err) {
        console.error(err);
      }
    }
    showProblem([
      'This page needs cross-origin isolation to read keyboard input.',
      'Serve this folder over http://localhost (not file://), for example:',
      '    python3 -m http.server 8000',
      'then open http://localhost:8000/ . If it still fails, hard-refresh once.',
    ]);
  }

  boot();
})();
