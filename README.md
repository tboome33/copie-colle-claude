# Copie Colle Claude

> 🇬🇧 English version below · [Jump to English](#english) — 🇫🇷 Version française d'abord.

---

## 🇫🇷 Français

Un petit utilitaire **AutoHotkey v2** pour Windows qui transforme une image présente dans le presse-papiers en **fichier `.png` sur le disque**, puis colle automatiquement **le chemin du fichier** dans l'application active.

Pensé pour les agents IA en ligne de commande (Claude Code, etc.) qui ne savent pas lire une image collée directement, mais qui peuvent lire un fichier image à partir de son chemin.

### Le problème qu'il résout

Quand on travaille avec un agent IA dans un terminal, on ne peut pas « coller » une capture d'écran : le terminal n'accepte que du texte. `Copie Colle Claude` fait le pont :

1. Vous faites une capture d'écran (ex. `Win + Maj + S`) → l'image est dans le presse-papiers.
2. Vous appuyez sur le raccourci (par défaut `Ctrl + Alt + V`).
3. L'utilitaire enregistre l'image en `.png` dans un dossier de votre choix.
4. Il copie le **chemin complet** du fichier dans le presse-papiers et le **colle** dans la fenêtre active.

L'agent IA reçoit alors un chemin du type `C:\temp\2026-06-28_14-30-05.png` qu'il peut lire directement.

### Installation

#### Option A — Exécutable (le plus simple)

Aucune installation requise. Téléchargez et lancez :

- `CopyAndPastPathImageForIAAgent.exe`

> L'exécutable est autonome : il embarque AutoHotkey, aucune dépendance n'est nécessaire.

#### Option B — Script source (nécessite AutoHotkey)

1. Installez [AutoHotkey v2](https://www.autohotkey.com/).
2. Gardez `Copie Colle Claude.ahk` et `Gdip_All.ahk` **dans le même dossier**.
3. Double-cliquez sur `Copie Colle Claude.ahk`.

### Utilisation

1. Lancez l'utilitaire — une icône apparaît dans la **zone de notification** (system tray).
2. Copiez une image dans le presse-papiers (capture d'écran, copie depuis un navigateur, etc.).
3. Appuyez sur le raccourci (par défaut **`Ctrl + Alt + V`**).
4. Le chemin du fichier `.png` est collé dans la fenêtre active, et une notification confirme la sauvegarde.

#### Menu de la zone de notification

Clic droit sur l'icône :

| Entrée | Action |
| --- | --- |
| **Parametres** | Ouvre la fenêtre de configuration (dossier + raccourci) |
| **Ouvrir dossier images** | Ouvre le dossier où sont sauvées les images |
| **Recharger** | Recharge le script |
| **Quitter** | Ferme l'utilitaire |

### Configuration

Les réglages sont accessibles via **clic droit sur l'icône → Parametres** :

- **Dossier de sauvegarde** : où sont écrits les fichiers `.png` (le dossier est créé s'il n'existe pas).
- **Raccourci clavier** : la combinaison qui déclenche la capture.

Les valeurs sont persistées dans `CopieColleClaude.ini` (créé automatiquement au premier lancement) :

```ini
[Settings]
DossierImages=C:\temp\
Hotkey=^!v
```

> Notation des raccourcis AutoHotkey : `^` = Ctrl, `!` = Alt, `+` = Maj, `#` = Win.
> Exemple : `^!v` = `Ctrl + Alt + V`.

Les fichiers sont nommés à l'horodatage : `yyyy-MM-dd_HH-mm-ss.png` (ex. `2026-06-28_14-30-05.png`).

### Contenu du dépôt

| Fichier | Rôle |
| --- | --- |
| `Copie Colle Claude.ahk` | Script source principal (AutoHotkey v2) |
| `Gdip_All.ahk` | Bibliothèque GDI+ (traitement d'image), dépendance du script |
| `CopyAndPastPathImageForIAAgent.exe` | Version compilée autonome |
| `CopieColleClaude.ini` | Config utilisateur — *généré au runtime, non versionné* |

### Fonctionnement technique

Le script utilise [GDI+](https://learn.microsoft.com/en-us/windows/win32/gdiplus/-gdiplus-gdi-start) via `Gdip_All.ahk` pour :

1. Lire le bitmap depuis le presse-papiers (`Gdip_CreateBitmapFromClipboard`).
2. L'enregistrer en PNG sur le disque (`Gdip_SaveBitmapToFile`).
3. Remplacer le contenu du presse-papiers par le chemin du fichier, puis simuler `Ctrl + V`.

### Prérequis

- **Windows**
- **AutoHotkey v2** — *uniquement* si vous utilisez le script source (l'`.exe` est autonome).

### Licence

Sous licence **MIT** — © 2026 tboome33. Réutilisation libre, avec simple attribution de l'auteur.
Voir [`LICENSE`](LICENSE), qui crédite aussi les composants tiers (`Gdip_All.ahk`, runtime AutoHotkey).

---

## English

A small **AutoHotkey v2** utility for Windows that turns an image sitting in the clipboard into a **`.png` file on disk**, then automatically pastes **the file path** into the active application.

Designed for command-line AI agents (Claude Code, etc.) that can't read a pasted image directly, but can read an image file from its path.

### The problem it solves

When working with an AI agent in a terminal, you can't "paste" a screenshot: the terminal only accepts text. `Copie Colle Claude` bridges the gap:

1. Take a screenshot (e.g. `Win + Shift + S`) → the image lands in the clipboard.
2. Press the hotkey (default `Ctrl + Alt + V`).
3. The utility saves the image as `.png` in a folder of your choice.
4. It copies the **full file path** to the clipboard and **pastes** it into the active window.

The AI agent then receives a path like `C:\temp\2026-06-28_14-30-05.png` that it can read directly.

### Installation

#### Option A — Executable (easiest)

No installation required. Download and run:

- `CopyAndPastPathImageForIAAgent.exe`

> The executable is self-contained: it embeds AutoHotkey, no dependency needed.

#### Option B — Source script (requires AutoHotkey)

1. Install [AutoHotkey v2](https://www.autohotkey.com/).
2. Keep `Copie Colle Claude.ahk` and `Gdip_All.ahk` **in the same folder**.
3. Double-click `Copie Colle Claude.ahk`.

### Usage

1. Launch the utility — an icon appears in the **system tray**.
2. Copy an image to the clipboard (screenshot, copy from a browser, etc.).
3. Press the hotkey (default **`Ctrl + Alt + V`**).
4. The `.png` file path is pasted into the active window, and a notification confirms the save.

#### System tray menu

Right-click the icon:

| Entry | Action |
| --- | --- |
| **Parametres** | Opens the settings window (folder + hotkey) |
| **Ouvrir dossier images** | Opens the folder where images are saved |
| **Recharger** | Reloads the script |
| **Quitter** | Quits the utility |

### Configuration

Settings are reachable via **right-click the icon → Parametres**:

- **Save folder**: where `.png` files are written (created if it doesn't exist).
- **Hotkey**: the combination that triggers the capture.

Values are persisted in `CopieColleClaude.ini` (created automatically on first launch):

```ini
[Settings]
DossierImages=C:\temp\
Hotkey=^!v
```

> AutoHotkey hotkey notation: `^` = Ctrl, `!` = Alt, `+` = Shift, `#` = Win.
> Example: `^!v` = `Ctrl + Alt + V`.

Files are named with a timestamp: `yyyy-MM-dd_HH-mm-ss.png` (e.g. `2026-06-28_14-30-05.png`).

### Repository contents

| File | Role |
| --- | --- |
| `Copie Colle Claude.ahk` | Main source script (AutoHotkey v2) |
| `Gdip_All.ahk` | GDI+ library (image processing), script dependency |
| `CopyAndPastPathImageForIAAgent.exe` | Self-contained compiled build |
| `CopieColleClaude.ini` | User config — *generated at runtime, not versioned* |

### How it works

The script uses [GDI+](https://learn.microsoft.com/en-us/windows/win32/gdiplus/-gdiplus-gdi-start) via `Gdip_All.ahk` to:

1. Read the bitmap from the clipboard (`Gdip_CreateBitmapFromClipboard`).
2. Save it as PNG to disk (`Gdip_SaveBitmapToFile`).
3. Replace the clipboard content with the file path, then simulate `Ctrl + V`.

### Requirements

- **Windows**
- **AutoHotkey v2** — *only* if you use the source script (the `.exe` is self-contained).

### License

Licensed under the **MIT License** — © 2026 tboome33. Free to reuse, with simple author attribution.
See [`LICENSE`](LICENSE), which also credits third-party components (`Gdip_All.ahk`, AutoHotkey runtime).
