# N8DMR – Schritt-für-Schritt-Anleitung

N8DMR ist ein PC-Sprechfunkclient. Er verbindet sich über das Internet mit einem DMR-Master. Mikrofon und Lautsprecher des PCs übernehmen Spracheingabe und Wiedergabe; ein DMR-Funkgerät oder Hotspot ist für diesen Internet-Client-Modus nicht erforderlich.

## Voraussetzungen

- Linux oder Windows 11
- gültiges Amateurfunkrufzeichen und registrierte DMR-ID
- für den FreeDMR-Server der N8schicht: eingerichteter FreeRadioID-Zugang und dessen Passwort
- Internetverbindung, Mikrofon und Lautsprecher/Kopfhörer

## Installation aus dem Quellcode

N8DMR benötigt Qt 6.5+ mit Qt Quick, Quick Controls, Multimedia, Network und SerialPort, CMake und einen C++-Compiler.

### Linux mit GNOME

Auf Debian/Ubuntu installiere zunächst die Build-Abhängigkeiten:

```sh
sudo apt install build-essential cmake ninja-build qt6-base-dev qt6-base-private-dev qt6-declarative-dev qt6-multimedia-dev qt6-serialport-dev qt6-tools-dev
```

Falls deine Distribution kein Qt 6.5 oder neuer enthält, installiere Qt 6.5+ mit dem offiziellen Qt-Installer. Baue, starte und integriere den Client als GNOME-App:

```sh
cmake -S . -B build -G Ninja
cmake --build build
./build/N8DMR
sudo cmake --install build
```

### Windows 11

1. Installiere Qt 6.5+ mit **MSVC 2022 64-bit**, Qt Quick Controls, Qt Multimedia, Qt Network und Qt Serial Port.
2. Installiere Visual Studio 2022 C++ Build Tools und Ninja.
3. Öffne eine Qt Developer PowerShell und navigiere zum N8DMR-Ordner.
4. Baue und starte:

```powershell
cmake -S . -B build -G Ninja
cmake --build build
.\build\N8DMR.exe
```

Für einen verteilbaren Windows-Ordner müssen die Qt-Bibliotheken und QML-Module mit `windeployqt` mitgeliefert werden.

## Erster Start und N8schicht-Verbindung

1. Öffne **Einstellungen**.
2. Trage Rufzeichen und DMR-ID ein. Verwende die ID, die zu deinem Rufzeichen gehört.
3. Trage im Feld **FreeDMR Pass** das Passwort ein, das du für die sichere FreeRadioID-Anmeldung eingerichtet hast. Es ist nicht das allgemeine Gastpasswort des Servers.
4. Wähle unter **Audio** dein Mikrofon und deine Audio-Ausgabe. Der Software-Vocoder ist der Standard; ein AMBE-Hardware-Vocoder kann bei Bedarf unter Einstellungen ausgewählt werden.
5. Öffne **Funkbetrieb**. Der N8schicht-Server ist als `FreeDMR_N8schicht` voreingestellt.
6. Prüfe Talkgroup **265**, **TS2** und **CC1**. Passe sie an, falls dein Betrieb eine andere Konfiguration erfordert.
7. Verbinde dich. Der Status oben zeigt den Verbindungszustand; weitere Verbindungsdetails stehen im Funkprotokoll.
8. Höre zunächst zu. Wenn du sendeberechtigt bist, halte **ZUM SENDEN HALTEN** gedrückt und lass die Taste zum Beenden wieder los.

Nach `cmake --install build` erscheint N8DMR im GNOME-Anwendungsmenü.

Die App speichert Profil- und Servereinstellungen lokal über Qt Settings. Passwörter sind im aktuellen Entwicklungsstand dabei nicht durch einen separaten Schlüsselbund verschlüsselt. Verwende deshalb nur ein persönliches, nicht anderweitig verwendetes Passwort und sichere die Einstellungsdatei entsprechend.

## Andere DMR-Master

N8DMR verwendet das Homebrew/MMDVM-Protokoll. Öffne **DMR-Server** und ergänze einen Eintrag im Format:

```text
DMR <Name> <Host> <Port> <Serverpasswort>
```

Beispiel für einen Master ohne eigenes Passwort:

```text
DMR MeinMaster master.example.net 62031 passw0rd
```

Das Wort `passw0rd` ist nur das Protokoll-Standardpasswort für entsprechende Server. Verwende es nicht, wenn ein Netz eigene Zugangsdaten verlangt. Für BrandMeister, TGIF und FreeDMR gibt es getrennte Passwortfelder in **Einstellungen**.

## Bedienung

- **Connect / Verbindung trennen**: DMR-Master-Verbindung aufbauen oder schließen.
- **Talkgroup**: numerische Ziel-ID; der Master kann die Gruppe erst nach dem Verbindungsaufbau aktivieren.
- **TS1 / TS2**: Zeitschlitz für die nächste Aussendung.
- **Color Code**: DMR-Farbcode passend zum jeweiligen Netz.
- **Privater Ruf**: Ziel-ID als Einzelruf statt Talkgroup behandeln.
- **PTT**: gedrückt halten zum Senden, loslassen zum Beenden.
- **Eingangspegel**: Mikrofonverstärkung in der App.
- **Funkprotokoll**: Verbindungs- und Laufzeitmeldungen.

## Fehlerbehebung

**Der N8schicht-Server wird nicht angezeigt**  
Beim ersten Start lädt das DMR-Backend die Serverliste. Prüfe die Internetverbindung und öffne die Server-Auswahl erneut. Der lokale N8schicht-Eintrag bleibt in **DMR-Server** gespeichert.

**Login schlägt fehl**  
Prüfe Rufzeichen, DMR-ID und FreeRadioID-Passwort. Die FreeRadioID-Anmeldung muss für deine DMR-ID aktiviert sein.

**Mikrofon bleibt stumm**  
Prüfe unter Einstellungen das gewählte Eingabegerät und den Eingangspegel. Kontrolliere auch die Mikrofonberechtigung und Audiogeräte-Einstellungen des Betriebssystems.

**Kein Empfangston**  
Prüfe Ausgabe-Gerät, Talkgroup und Zeitschlitz. Das Netz muss deine DMR-ID akzeptiert haben; eine leere Talkgroup liefert keinen Gruppenverkehr.

**Der PTT-Knopf bleibt deaktiviert**  
Er wird nach erfolgreicher Netzverbindung freigeschaltet. Öffne das Funkprotokoll für die Fehlermeldung.

## Unterstütztes Protokoll

Diese Version implementiert Homebrew/MMDVM. Open DMR Terminal (ODTP) ist hier noch nicht implementiert. Die [UI-Vorschau](screenshots/n8dmr-funkplatz-entwurf.svg) ist ein Designentwurf, keine Bildschirmaufnahme einer laufenden Funkverbindung.
