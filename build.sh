#!/usr/bin/env bash
# Baut aus app.html (dem eigentlichen Inhalt) die eigenstaendige index.html.
set -euo pipefail
cd "$(dirname "$0")"
{
  printf '%s\n' '<!doctype html>' '<html lang="de">' '<head>' \
    '<meta charset="utf-8">' \
    '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">' \
    '<meta name="color-scheme" content="light dark">' \
    '<meta name="description" content="Trainer fuer die lateinischen Konjugationen: Person, Numerus, Tempus, Modus, Genus verbi bestimmen.">'
  awk '/<!--BODY-->/{print "</head>"; print "<body>"; next} {print}' app.html
  printf '%s\n' '</body>' '</html>'
} > index.html
echo "index.html geschrieben ($(wc -l < index.html) Zeilen)"
