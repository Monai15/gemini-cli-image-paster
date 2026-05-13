#Requires AutoHotkey v2.0
#SingleInstance Force

; Group terminal windows together
GroupAdd("Terminals", "ahk_exe WindowsTerminal.exe")
GroupAdd("Terminals", "ahk_exe powershell.exe")
GroupAdd("Terminals", "ahk_exe cmd.exe")
GroupAdd("Terminals", "ahk_exe Code.exe") ; For VS Code integrated terminal

; This hotkey only works when a terminal is active
#HotIf WinActive("ahk_group Terminals")

^+v:: {
    ; Wait for you to release the keys so they don't interfere
    KeyWait("v")
    KeyWait("Shift")
    KeyWait("Ctrl")

    ToolTip("Saving image...")
    tempFile := A_Temp "\gemini_clip_" A_TickCount ".png"
    
    ; Run PowerShell COMPLETELY SILENTLY (using RunWait with 'Hide')
    psCommand := "Add-Type -AssemblyName System.Windows.Forms,System.Drawing; "
               . "$img = [Windows.Forms.Clipboard]::GetImage(); "
               . "if ($img) { $img.Save('" tempFile "', [System.Drawing.Imaging.ImageFormat]::Png) }"

    try {
        ; Use RunWait with 'Hide' to prevent any windows from popping up
        RunWait("powershell -NoProfile -ExecutionPolicy Bypass -Command `"" psCommand "`"", , "Hide")
        
        ; Wait a moment for file to be ready
        Loop 15 {
            if FileExist(tempFile)
                break
            Sleep(100)
        }

        if FileExist(tempFile) {
            ToolTip("Pasting @path...")
            
            oldClip := ClipboardAll()
            A_Clipboard := "@" . tempFile . " "
            
            ; Use Ctrl+V (Standard terminal paste in most modern Windows terminals)
            Send("^v")
            
            ; Wait for paste then restore clipboard
            Sleep(300)
            A_Clipboard := oldClip
            ToolTip("Success!")
        } else {
            ToolTip("No image found in clipboard")
        }
    } catch Error as err {
        ToolTip("Error: " err.Message)
    }

    SetTimer(ToolTip, -2000)
}

#HotIf ; End of terminal-only section
