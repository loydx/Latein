#!/usr/bin/env bash
# Baut aus app.html (dem eigentlichen Inhalt) die eigenstaendige, installierbare index.html.
# app.html bleibt frei von PWA-Zeug, damit es unveraendert als Artifact veroeffentlicht werden kann.
set -euo pipefail
cd "$(dirname "$0")"
{
  printf '%s\n' '<!doctype html>' '<html lang="de">' '<head>' \
    '<meta charset="utf-8">' \
    '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">' \
    '<meta name="color-scheme" content="light dark">' \
    '<meta name="description" content="Trainer fuer die lateinischen Konjugationen: Person, Numerus, Tempus, Modus, Genus verbi bestimmen.">' \
    '<meta name="theme-color" content="#EDEEEA" media="(prefers-color-scheme: light)">' \
    '<meta name="theme-color" content="#131614" media="(prefers-color-scheme: dark)">' \
    '<link rel="manifest" href="manifest.webmanifest">' \
    '<link rel="icon" href="icon.svg" type="image/svg+xml">' \
    '<link rel="apple-touch-icon" href="apple-touch-icon.png">' \
    '<meta name="mobile-web-app-capable" content="yes">' \
    '<meta name="apple-mobile-web-app-capable" content="yes">' \
    '<meta name="apple-mobile-web-app-status-bar-style" content="default">' \
    '<meta name="apple-mobile-web-app-title" content="Coniugatio">'
  awk '/<!--BODY-->/{print "</head>"; print "<body>"; next} {print}' app.html
  cat <<'SW'
<script>
/* Offline-Betrieb: nur ueber http(s) moeglich, lokal geoeffnet einfach uebersprungen. */
if ("serviceWorker" in navigator && location.protocol.indexOf("http") === 0){
  window.addEventListener("load", () => {
    navigator.serviceWorker.register("sw.js").catch(() => {});
  });
}
</script>
SW
  printf '%s\n' '</body>' '</html>'
} > index.html
echo "index.html geschrieben ($(wc -l < index.html) Zeilen)"
