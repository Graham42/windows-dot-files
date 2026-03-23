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

The install script sets up the gitconfig include automatically (see [Apply dotfiles](#apply-dotfiles) below).

## Install a Nerd Font

Starship uses icons that require a Nerd Font. Download CascadiaMono NF from:

https://www.nerdfonts.com/font-downloads

Extract the zip, select all `.ttf` files, right-click → **Install for all users**.

Then set the font in Windows Terminal: Settings → your profile → Appearance → Font face → **CascadiaMono Nerd Font Mono**.

## Install Starship

```powershell
winget install Starship.Starship
```

The dotfiles profile block initializes starship automatically (see [Apply dotfiles](#apply-dotfiles) above).

## Install PowerShell 7

Required for psmux's plugin manager (ppm).

```powershell
winget install Microsoft.PowerShell
```

Restart your terminal after installing.

Set PS7 as the default in Windows Terminal: Settings → Startup → Default profile → **PowerShell** (not "Windows PowerShell").

## Install psmux

```powershell
winget install marlocarlo.psmux
```

The install script bootstraps ppm and symlinks the config automatically (see [Apply dotfiles](#apply-dotfiles) above).

After running the install script, open psmux and press `Prefix + I` (`Ctrl+a I`) to install plugins.
