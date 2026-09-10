/* Service Worker: macht die App offline lauffähig. */
const CACHE = "coniugatio-v2";
const ASSETS = ["./", "./index.html", "./manifest.webmanifest",
                "./icon.svg", "./icon-192.png", "./icon-512.png", "./apple-touch-icon.png"];
const FONT_HOSTS = ["https://fonts.googleapis.com", "https://fonts.gstatic.com"];

self.addEventListener("install", e => {
  e.waitUntil(caches.open(CACHE)
    .then(c => Promise.allSettled(ASSETS.map(a => c.add(a))))
    .then(() => self.skipWaiting()));
});

self.addEventListener("activate", e => {
  e.waitUntil(caches.keys()
    .then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
    .then(() => self.clients.claim()));
});

self.addEventListener("fetch", e => {
  const req = e.request;
  if (req.method !== "GET") return;
  const url = new URL(req.url);

  // Schriften von Google: einmal geladen, danach aus dem Cache
  if (FONT_HOSTS.indexOf(url.origin) > -1){
    e.respondWith(caches.open(CACHE).then(async c => {
      const hit = await c.match(req);
      if (hit) return hit;
      try {
        const res = await fetch(req);
        if (res.ok || res.type === "opaque") c.put(req, res.clone());
        return res;
      } catch (err){
        return Response.error();
      }
    }));
    return;
  }
  if (url.origin !== location.origin) return;

  // Eigene Dateien: sofort aus dem Cache, im Hintergrund auffrischen
  e.respondWith(caches.open(CACHE).then(async c => {
    const hit = await c.match(req, { ignoreSearch:true });
    const net = fetch(req)
      .then(res => { if (res.ok) c.put(req, res.clone()); return res; })
      .catch(async () => hit || (await c.match("./index.html")) || Response.error());
    return hit || net;
  }));
});
