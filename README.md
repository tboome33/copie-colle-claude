# Copie Colle Claude

Un petit utilitaire **AutoHotkey v2** pour Windows qui transforme une image présente dans le presse-papiers en **fichier `.png` sur le disque**, puis colle automatiquement **le chemin du fichier** dans l'application active.

Pensé pour les agents IA en ligne de commande (Claude Code, etc.) qui ne savent pas lire une image collée directement, mais qui peuvent lire un fichier image à partir de son chemin.

---

## Le problème qu'il résout

Quand on travaille avec un agent IA dans un terminal, on ne peut pas « coller » une capture d'écran : le terminal n'accepte que du texte. `Copie Colle Claude` fait le pont :

1. Vous faites une capture d'écran (ex. `Win + Maj + S`) → l'image est dans le presse-papiers.
2. Vous appuyez sur le raccourci (par défaut `Ctrl + Alt + V`).
3. L'utilitaire enregistre l'image en `.png` dans un dossier de votre choix.
4. Il copie le **chemin complet** du fichier dans le presse-papiers et le **colle** dans la fenêtre active.

L'agent IA reçoit alors un chemin du type `C:\temp\2026-06-28_14-30-05.png` qu'il peut lire directement.

---

## Installation

### Option A — Exécutable (le plus simple)

Aucune installation requise. Téléchargez et lancez :

- `CopyAndPastPathImageForIAAgent.exe`

> L'exécutable est autonome : il embarque AutoHotkey, aucune dépendance n'est nécessaire.

### Option B — Script source (nécessite AutoHotkey)

1. Installez [AutoHotkey v2](https://www.autohotkey.com/).
2. Gardez `Copie Colle Claude.ahk` et `Gdip_All.ahk` **dans le même dossier**.
3. Double-cliquez sur `Copie Colle Claude.ahk`.

---

## Utilisation

1. Lancez l'utilitaire — une icône apparaît dans la **zone de notification** (system tray).
2. Copiez une image dans le presse-papiers (capture d'écran, copie depuis un navigateur, etc.).
3. Appuyez sur le raccourci (par défaut **`Ctrl + Alt + V`**).
4. Le chemin du fichier `.png` est collé dans la fenêtre active, et une notification confirme la sauvegarde.

### Menu de la zone de notification

Clic droit sur l'icône :

| Entrée | Action |
| --- | --- |
| **Parametres** | Ouvre la fenêtre de configuration (dossier + raccourci) |
| **Ouvrir dossier images** | Ouvre le dossier où sont sauvées les images |
| **Recharger** | Recharge le script |
| **Quitter** | Ferme l'utilitaire |

---

## Configuration

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

---

## Contenu du dépôt

| Fichier | Rôle |
| --- | --- |
| `Copie Colle Claude.ahk` | Script source principal (AutoHotkey v2) |
| `Gdip_All.ahk` | Bibliothèque GDI+ (traitement d'image), dépendance du script |
| `CopyAndPastPathImageForIAAgent.exe` | Version compilée autonome |
| `CopieColleClaude.ini` | Config utilisateur — *généré au runtime, non versionné* |

---

## Fonctionnement technique

Le script utilise [GDI+](https://learn.microsoft.com/en-us/windows/win32/gdiplus/-gdiplus-gdi-start) via `Gdip_All.ahk` pour :

1. Lire le bitmap depuis le presse-papiers (`Gdip_CreateBitmapFromClipboard`).
2. L'enregistrer en PNG sur le disque (`Gdip_SaveBitmapToFile`).
3. Remplacer le contenu du presse-papiers par le chemin du fichier, puis simuler `Ctrl + V`.

---

## Prérequis

- **Windows**
- **AutoHotkey v2** — *uniquement* si vous utilisez le script source (l'`.exe` est autonome).

---

## Licence

À définir par l'auteur du dépôt.
