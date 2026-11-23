# N8DMR

**N8DMR** ist ein plattformübergreifender DMR-Sprechfunkclient für Linux und Windows. Die Bedienoberfläche orientiert sich an Die N8schicht; die App kommuniziert direkt mit DMR-Mastern über das Homebrew/MMDVM-Protokoll und überträgt Sprache zwischen Mikrofon und Lautsprecher.

## Entwicklungsstand

Der erste Entwicklungsstand basiert auf dem Open-Source-DMR-Client DroidStar von Doug McLain (AD8DP). Das bewährte Qt/C++-Backend übernimmt DMR-Netzwerk, Sprachcodec, Audio, PTT und Geräteschnittstellen. N8DMR ergänzt ein Desktop-Layout, die N8schicht-Marke und eine vorkonfigurierte Verbindung zum FreeDMR-Server der N8schicht. Qt wählt die Windows-Steuerelemente unter Windows und Fusion auf Linux automatisch; GNOME erhält zusätzlich einen Desktop-Eintrag und ein Hicolor-App-Icon.

Z3DMR selbst ist eine Android-App. N8DMR verwendet dessen Bedienidee als Referenz und setzt für den PC auf ein quelloffenes Qt-Backend, das unter Linux und Windows läuft.

> **Funkbetrieb:** Für die Verbindung mit einem echten Netz sind ein gültiges Rufzeichen, eine registrierte DMR-ID und das für den jeweiligen Server erforderliche Passwort nötig. Aussenden ist nur mit gültiger Amateurfunkberechtigung zulässig. Prüfe vor dem Senden die Talkgroup, den Zeitschlitz und die Regeln des Netzes.

## Funktionen

- Direkte DMR-Verbindung über Homebrew/MMDVM zu DMR-Mastern, darunter FreeDMR
- Empfang und Aussendung über Mikrofon und Lautsprecher am PC
- Push-to-talk per Maustaste
- Wahl von Server, Talkgroup, Zeitschlitz, Color Code und Private Call
- Eingabe- und Ausgabegeräte, Mikrofonpegel und Audio-Optionen
- DMR-Verbindungsstatus, Stationsdaten und Funkprotokoll
- Linux und Windows aus gemeinsamer Qt-6-Codebasis

Open DMR Terminal (ODTP) ist in diesem Entwicklungsstand nicht enthalten.

## Bauen

Erforderlich sind Qt 6.5 oder neuer mit Qt Quick, Quick Controls, Multimedia, Network und SerialPort sowie ein C++-Compiler und CMake.

### Linux (GNOME)

```sh
sudo apt install cmake ninja-build build-essential qt6-base-dev qt6-declarative-dev qt6-multimedia-dev qt6-serialport-dev qt6-tools-dev
cmake -S . -B build -G Ninja
cmake --build build
./build/N8DMR
```

Qt 6.5+ kann je nach Distribution über den Qt-Installer statt über deren Paketquellen installiert werden.

### Windows 11

Installiere Qt 6.5+ mit den Komponenten **MSVC 2022 64-bit**, **Qt Quick Controls**, **Multimedia**, **Network** und **Serial Port**, dazu Visual Studio 2022 C++ Build Tools und CMake. In der Qt Developer PowerShell:

```powershell
cmake -S . -B build -G Ninja
cmake --build build
.\build\N8DMR.exe
```

Für distributierbare Builds müssen die Qt-Runtime-Bibliotheken und QML-Module mit `windeployqt` gebündelt werden.

## Projektstruktur

- `Main.qml`, `MainTab.qml`, `SettingsTab.qml` – Desktop-Oberfläche und Funksteuerung
- `droidstar.cpp`, `dmr.cpp`, `audioengine.cpp` – DMR-Protokoll, Verbindung und Audio
- `docs/ANLEITUNG.md` – deutsche Schritt-für-Schritt-Anleitung
- `packaging/n8dmr.desktop` – App-Integration für GNOME
- `docs/screenshots/` – UI-Entwurf; spätere Aufnahmen aus dem laufenden Client
- `assets/`, `images/n8dmr*` – Die-N8schicht-App-Icons

## Herkunft und Lizenz

N8DMR enthält modifizierten Quellcode aus [DroidStar](https://github.com/nostar/DroidStar), Copyright Doug McLain (AD8DP), und wird entsprechend der GNU GPL Version 3 oder neuer weitergegeben. Die vollständige Lizenz steht in [`LICENSE`](LICENSE). Der DMR-Engine-Stand beim Anlegen dieses Projekts: `fc8e340a61d65f9719d1c4a0c28fdf5cc5d2b444` (2026-11-22).

Das N8schicht-Logo stammt aus dem DMR-Webauftritt unter [dmr.die-n8schicht.de](https://dmr.die-n8schicht.de/). Das Marken-Asset ist getrennt vom GPL-lizenzierten Programmcode zu behandeln.
