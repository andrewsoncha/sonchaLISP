'use strict';
// Runs the unmodified Emscripten build (sonchaLISP.js + .wasm) off the main
// thread. When the program reads stdin, this thread sleeps with Atomics.wait
// until the page (terminal.js) writes a line into shared memory.
// Nothing in sonchaLISP.js/.wasm is modified; hooks are installed from preRun.

const NOT_READY = 0, READY = 1, EOF = 2;
const HEADER_INTS = 2; // [0] status, [1] byte length of pending chunk

let control, data;
let exitCode = 0;
let exited = false;

// ---- stdout / stderr: batch bytes, flush on newline or before blocking ----
let outBuf = [];
let outFd = 1;

function flushOut() {
  if (!outBuf.length) return;
  const bytes = Uint8Array.from(outBuf);
  outBuf = [];
  postMessage({ type: 'out', fd: outFd, bytes }, [bytes.buffer]);
}

function emit(fd, byte) {
  if (fd !== outFd) { flushOut(); outFd = fd; }
  outBuf.push(byte);
  if (byte === 10) flushOut();
}

// ---- stdin: block until the page supplies a chunk ----
let inChunk = new Uint8Array(0);
let inPos = 0;

// Sleeps until terminal.js hands over the next chunk. Returns false on EOF.
function waitForInput() {
  flushOut(); // make sure any prompt is visible before we sleep
  while (Atomics.load(control, 0) === NOT_READY) {
    Atomics.wait(control, 0, NOT_READY);
  }
  const status = Atomics.load(control, 0);
  if (status === READY) {
    inChunk = data.slice(0, Atomics.load(control, 1)); // copy out of shared memory
    inPos = 0;
  }
  Atomics.store(control, 0, NOT_READY);
  postMessage({ type: 'consumed' });
  return status === READY;
}

// Emscripten's default stdin read() keeps asking for bytes until its buffer is
// full or it sees EOF, so a line would never reach the program. This version
// behaves like a real terminal: block for the first byte, then return
// whatever is available.
function ttyRead(stream, buffer, offset, length) {
  let n = 0;
  while (n < length) {
    if (inPos >= inChunk.length) {
      if (n > 0) break;               // short read: hand back what we have
      if (!waitForInput()) break;     // EOF -> read returns 0
      continue;
    }
    buffer[offset + n++] = inChunk[inPos++];
  }
  if (n) stream.node.atime = Date.now();
  return n;
}

function reportExit() {
  if (exited) return;
  exited = true;
  flushOut();
  postMessage({ type: 'exit', code: exitCode });
}

self.onmessage = (event) => {
  if (event.data.type !== 'init') return;
  control = new Int32Array(event.data.sab, 0, HEADER_INTS);
  data = new Uint8Array(event.data.sab, HEADER_INTS * 4);

  self.Module = {
    // Fallbacks in case the TTY patch below can't be applied.
    print: (text) => { for (const b of new TextEncoder().encode(text + '\n')) emit(1, b); },
    printErr: (text) => { for (const b of new TextEncoder().encode(text + '\n')) emit(2, b); },
    preRun: [() => {
      // Stream raw bytes instead of line-buffered strings so prompts that
      // don't end in a newline still show up.
      if (typeof TTY === 'undefined') {
        postMessage({ type: 'fatal', text: 'TTY is not exposed by this build; cannot hook stdin.' });
        return;
      }
      TTY.stream_ops.read = ttyRead;
      TTY.default_tty_ops.put_char = (tty, val) => {
        if (val === null) flushOut(); else if (val !== 0) emit(1, val);
      };
      TTY.default_tty_ops.fsync = () => flushOut();
      TTY.default_tty1_ops.put_char = (tty, val) => {
        if (val === null) flushOut(); else if (val !== 0) emit(2, val);
      };
      TTY.default_tty1_ops.fsync = () => flushOut();
    }],
    onRuntimeInitialized: () => postMessage({ type: 'ready' }),
    onExit: (code) => { exitCode = code; },
    postRun: [reportExit],
  };

  importScripts('sonchaLISP.js');
};
