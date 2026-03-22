Steps taken to set up a Windows machine

## Enable Developer Mode

Run in PowerShell as Administrator:

```powershell
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
```

This enables Developer Mode, which allows creating symlinks without admin rights on a per-command basis. The registry key name "AllowDevelopmentWithoutDevLicense" is a historical name - before Windows 10, sideloading and dev tools required a paid developer license from Microsoft. This key grants the same permissions without that license.

Developer Mode also unlocks Device Portal and Device Discovery (for remote app deployment via Visual Studio), but those are opt-in and not needed here.

## Install Claude Code

https://code.claude.com/docs/en/overview

## Install VIM

```powershell
winget install vim.vim
```

Add vim to your user PATH (restart terminal after):

```powershell
$newPath = "C:\Program Files\Vim\vim92"
$current = [Environment]::GetEnvironmentVariable("Path", "User")
[Environment]::SetEnvironmentVariable("Path", $current + ";$newPath", [EnvironmentVariableTarget]::User)
```

Create the directories vim needs for swap and undo persistence:

```powershell
New-Item -ItemType Directory -Force "$HOME\.vim\tmp"
New-Item -ItemType Directory -Force "$HOME\.vim\undo"
```

Symlink the config from this repo (requires Developer Mode, see above):

```powershell
New-Item -ItemType SymbolicLink -Path "$HOME\_vimrc" -Target "$HOME\github\graham42\windows-dot-files\user_home\_vimrc"
```

## Apply dotfiles

Run the install script to add the dotfiles PowerShell profile block to your `$PROFILE`:

```powershell
. "$HOME\github\graham42\windows-dot-files\install.ps1"
```

Re-run this any time after pulling updates - it will update the existing block in place.

## Install Git

```ps1
winget install Git.Git
```

Restart Powershell
