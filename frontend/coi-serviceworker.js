// Adds the COOP/COEP headers that make the page "cross-origin isolated".
// Browsers only allow SharedArrayBuffer / Atomics.wait (needed for blocking
// stdin) on isolated pages. If your server already sends these headers,
// this file is never registered.
self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', (event) => event.waitUntil(self.clients.claim()));

self.addEventListener('fetch', (event) => {
  const request = event.request;
  if (request.cache === 'only-if-cached' && request.mode !== 'same-origin') return;

  event.respondWith(
    fetch(request)
      .then((response) => {
        if (response.status === 0) return response; // opaque, leave alone
        const headers = new Headers(response.headers);
        headers.set('Cross-Origin-Embedder-Policy', 'require-corp');
        headers.set('Cross-Origin-Opener-Policy', 'same-origin');
        return new Response(response.body, {
          status: response.status,
          statusText: response.statusText,
          headers,
        });
      })
      .catch((err) => {
        console.error('coi-serviceworker fetch failed:', err);
        return new Response('Network error', { status: 502 });
      })
  );
});
