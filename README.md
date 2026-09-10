# Coniugatio — Trainer für die lateinischen Konjugationen

Formbestimmungs-Trainer auf Grundlage des Übersichtsblatts „Übersicht über die
Konjugationen" (Präsensstamm Aktiv/Passiv, Perfektstamm Aktiv/Passiv, esse).

Die App zeigt eine Form, du bestimmst **Person, Numerus, Tempus, Modus** und
**Genus verbi**. Danach wird gegen die Tabelle abgeglichen, das Ergebnis
gespeichert und die Wiederholung danach gesteuert.

## Öffnen

`index.html` im Browser öffnen — kein Server, kein Build, keine Installation.
Der Fortschritt liegt im `localStorage` des jeweiligen Browsers.

## Was drin ist

**624 Formen / 660 Bestimmungen** aus fünf Musterverben und *esse*:

| Verb | Konjugation | Perfektstamm | PPP |
|---|---|---|---|
| laudāre – loben | ā | laudāv- | laudāt- |
| dēlēre – zerstören | ē | dēlēv- | dēlēt- |
| audīre – hören | ī | audīv- | audīt- |
| capere – nehmen | ĭ (kurzvokalisch) | cēp- | capt- |
| regere – leiten | konsonantisch | rēx- | rēct- |
| esse – sein | unregelmäßig | fu- | – |

Sechs Tempora (Präsens, Imperfekt, Futur I, Perfekt, Plusquamperfekt, Futur II)
× Indikativ/Konjunktiv × Aktiv/Passiv × sechs Personen. Futur I und Futur II
haben keinen Konjunktiv, *esse* kein Passiv.

## Mehrdeutige Formen

36 Formen lassen sich ohne Kontext auf zwei Arten bestimmen – z. B. `audiam`
(Futur I Indikativ *und* Präsens Konjunktiv) oder `laudāverit` (Futur II
Indikativ *und* Perfekt Konjunktiv). Solche Formen sind zu **einer** Karte
zusammengefasst; **beide** Bestimmungen zählen als richtig, und die Rückmeldung
nennt die jeweils andere.

## Paradigma in der Auflösung

Unter jeder Auflösung steht klein die Tabelle, in der die Form sitzt — Zeilen die
sechs Personen, Spalten die fünf Konjugationen (bei *esse* die Tempora). Die
abgefragte Zelle ist rot umrandet, Zeilen- und Spaltenkopf mit hervorgehoben, so
dass die Form sofort im Zusammenhang steht. Bei mehrdeutigen Formen erscheint je
eine Tabelle pro Lesart. Über *ausblenden* lässt sich das abschalten; die
Einstellung bleibt gespeichert.

## Lernmechanik

- Falsches wandert in derselben Runde nach vier Karten wieder in die Warteschlange
  und kommt so lange wieder, **bis es einmal richtig war**.
- Gezählt wird, beim **wievielten Versuch** eine Form saß. Daraus ergibt sich eine
  Stufe von 0 bis 5 (*neu · schwach · wackelig · solide · sicher · sitzt*):
  beim 1. Versuch richtig → eine Stufe hoch, beim 2. → gehalten, ab dem 3. →
  zurück auf *schwach*.
- Die Auswahl **Klug** stellt die Runde nach diesen Stufen zusammen: erst die
  schwachen, dann die ungesehenen, zuletzt die sitzenden. Daneben gibt es
  *Schwächste*, *Letzte Fehler*, *Nur neue* und *Zufall*.
- Nach jeder Runde: Trefferquote, Versuchsverteilung und ein Direktstart nur mit
  den Formen, die noch nicht saßen.

## Aufbau

| Datei | Zweck |
|---|---|
| `app.html` | der eigentliche Inhalt: Paradigmen, Logik, Stil |
| `build.sh` | erzeugt daraus die eigenständige `index.html` |
| `index.html` | die fertige Seite (generiert — nicht direkt bearbeiten) |

Änderungen also in `app.html` machen und danach `./build.sh` laufen lassen.

Die Paradigmen stehen als Endungstabellen in `app.html` (Abschnitt 1); alle
Formen werden daraus zur Laufzeit erzeugt, statt einzeln aufgelistet zu werden.
Wer weitere Verben ergänzen will, trägt in `VERBS` Stamm, Perfektstamm, PPP und
die deutschen Formen ein — mehr braucht es nicht.
