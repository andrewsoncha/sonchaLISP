# sonchaLISP terminal

Static site, no build step. Your original `sonchaLISP.js` / `sonchaLISP.wasm` are unchanged.

## Run

Serve this folder over http (not file://):

    python3 -m http.server 8000

Open http://localhost:8000/ . On the very first visit the page registers
`coi-serviceworker.js` and reloads itself once; that is expected.

## Files

- `index.html`, `style.css` – page shell and styling
- `terminal.js` – xterm.js terminal, line editing, history, talks to the worker
- `lisp-worker.js` – runs the wasm in a Web Worker and blocks on stdin with Atomics.wait
- `coi-serviceworker.js` – adds COOP/COEP headers so SharedArrayBuffer is allowed
  (not needed if your host already sends `Cross-Origin-Opener-Policy: same-origin`
  and `Cross-Origin-Embedder-Policy: require-corp`)
- `vendor/` – xterm.js 6.0.0 + fit addon, bundled locally
- `sonchaLISP.js`, `sonchaLISP.wasm` – your build

## Keys

Enter = send line, Up/Down = history, Left/Right/Home/End/Delete = edit,
Ctrl+C = clear line, Ctrl+U = clear to start, Ctrl+L = clear screen,
Ctrl+D (empty line) = end session. Any key restarts after the program exits.
