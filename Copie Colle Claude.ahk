#Requires AutoHotkey v2.0
#SingleInstance Force

#Include %A_ScriptDir%\Gdip_All.ahk

; --- Lecture config INI ---
cheminINI := A_ScriptDir "\CopieColleClaude.ini"

; Lire les parametres (ou valeurs par defaut)
dossierImages := IniRead(cheminINI, "Settings", "DossierImages", A_MyDocuments "\ClaudeImages\")
raccourci := IniRead(cheminINI, "Settings", "Hotkey", "^!i")

; Ecrire les valeurs par defaut si le fichier n'existe pas encore
if !FileExist(cheminINI) {
    IniWrite(dossierImages, cheminINI, "Settings", "DossierImages")
    IniWrite(raccourci, cheminINI, "Settings", "Hotkey")
}

; --- Setup TrayMenu ---
A_IconTip := "Copie Colle Claude"

trayMenu := A_TrayMenu
trayMenu.Delete()
trayMenu.Add("Parametres", (*) => OuvrirParametres())
trayMenu.Add("Ouvrir dossier images", (*) => Run(dossierImages))
trayMenu.Add()
trayMenu.Add("Recharger", (*) => Reload())
trayMenu.Add("Quitter", (*) => ExitApp())
trayMenu.Default := "Parametres"

; --- Enregistrement Hotkey dynamique ---
Hotkey(raccourci, CaptureImage)

; --- Fonction CaptureImage ---
CaptureImage(*) {
    global dossierImages

    pToken := Gdip_Startup()

    pBitmap := Gdip_CreateBitmapFromClipboard()
    if (pBitmap < 0) || !pBitmap {
        MsgBox("Pas d'image dans le presse-papiers! (erreur: " . pBitmap . ")")
        Gdip_Shutdown(pToken)
        return
    }

    nomFichier := FormatTime(, "yyyy-MM-dd_HH-mm-ss") . ".png"
    cheminComplet := dossierImages . nomFichier

    DirCreate(dossierImages)

    result := Gdip_SaveBitmapToFile(pBitmap, cheminComplet)

    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)

    if (result != 0) {
        MsgBox("Erreur sauvegarde image! (code: " . result . ")")
        return
    }

    A_Clipboard := cheminComplet
    ClipWait(1)

    Sleep(100)
    Send("^v")

    TrayTip("Image sauvee", "Chemin copie:`n" . cheminComplet, 1)
}

; --- Fonction OuvrirParametres (GUI) ---
OuvrirParametres() {
    global dossierImages, raccourci

    g := Gui(, "Copie Colle Claude - Parametres")
    g.MarginX := 15
    g.MarginY := 15

    g.AddText(, "Dossier de sauvegarde :")
    editDossier := g.AddEdit("w350 vDossier", dossierImages)
    btnParcourir := g.AddButton("x+5 yp w80", "Parcourir")
    btnParcourir.OnEvent("Click", (*) => ChoisirDossier(editDossier))

    g.AddText("xm", "Raccourci clavier :")
    editHotkey := g.AddHotkey("w200 vHotkey", raccourci)

    g.AddButton("xm w100 Default", "Sauvegarder").OnEvent("Click", (*) => SauvegarderParametres(g))
    g.AddButton("x+10 w100", "Annuler").OnEvent("Click", (*) => g.Destroy())

    g.Show()
}

ChoisirDossier(editCtrl) {
    dossier := DirSelect(, 0, "Choisir le dossier de sauvegarde")
    if dossier
        editCtrl.Value := dossier "\"
}

; --- Fonction SauvegarderParametres ---
SauvegarderParametres(g) {
    global dossierImages, raccourci, cheminINI

    donnees := g.Submit()
    nouveauDossier := donnees.Dossier
    nouveauHotkey := donnees.Hotkey

    if !nouveauHotkey {
        MsgBox("Le raccourci clavier ne peut pas etre vide.")
        return
    }

    ; Mettre a jour le hotkey dynamiquement
    if (nouveauHotkey != raccourci) {
        Hotkey(raccourci, "Off")
        Hotkey(nouveauHotkey, CaptureImage)
    }

    ; Appliquer les nouvelles valeurs
    dossierImages := nouveauDossier
    raccourci := nouveauHotkey

    ; Persister dans le INI
    IniWrite(dossierImages, cheminINI, "Settings", "DossierImages")
    IniWrite(raccourci, cheminINI, "Settings", "Hotkey")

    TrayTip("Parametres sauvegardes", "Dossier: " dossierImages "`nRaccourci: " raccourci, 1)
}
