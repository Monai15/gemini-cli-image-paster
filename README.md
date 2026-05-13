# Gemini CLI Image Paster

A seamless workflow enhancement for the Gemini CLI that allows you to paste images directly from your clipboard into the terminal.

## 🚀 The Problem
The Gemini CLI requires a specific syntax (`@path/to/image.png`) to analyze images. Since terminals don't support raw image pasting, users normally have to save the image manually, find the path, and type it out.

## ✨ The Solution
This AutoHotkey script automates the entire process. When you press `Ctrl+Shift+V` in a terminal window:
1. It silently saves your clipboard image to a temporary folder.
2. It automatically pastes the `@C:\path\to\temp_image.png` reference into your terminal.
3. It restores your original clipboard content immediately after.

## 🛠️ Features
- **Context Aware:** Only triggers in terminal windows (Windows Terminal, PowerShell, CMD, VS Code).
- **Silent Execution:** No flashing windows or popups.
- **Robust:** Handles both screenshot data and copied image files.
- **Auto-Cleanup:** Automatically deletes temporary image files older than 24 hours to save disk space.

## 📦 Installation
1. Install [AutoHotkey v2](https://www.autohotkey.com/).
2. Download `gemini_paste.ahk` from this repo.
3. Double-click the script to run it (it will appear in your system tray).

## ⌨️ Usage
1. Copy an image (e.g., `Win+Shift+S`).
2. Focus your terminal.
3. Press `Ctrl+Shift+V`.

---
*Created as a project in workflow automation and terminal-AI interaction.*
