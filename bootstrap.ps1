# Bootstrap script - installs required programs via winget and applies dotfiles
# Run as your normal user (NOT as Administrator). A UAC prompt will appear for
# the one step that requires elevation (enabling Developer Mode).

$dotfilesRoot = $PSScriptRoot

Write-Host "=== System Bootstrap ===" -ForegroundColor Cyan

# --- Enable Developer Mode (requires elevation - triggers UAC prompt) ---
Write-Host "`n[1/5] Enabling Developer Mode (UAC prompt will appear)..." -ForegroundColor Yellow
$regCmd = 'reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"'
Start-Process cmd -ArgumentList "/c $regCmd" -Verb RunAs -Wait
Write-Host "Developer Mode enabled"

# --- Winget installs ---
Write-Host "`n[2/5] Installing programs via winget..." -ForegroundColor Yellow

$packages = @(
    @{ Id = "Git.Git";               Name = "Git" },
    @{ Id = "vim.vim";               Name = "Vim" },
    @{ Id = "Starship.Starship";     Name = "Starship" },
    @{ Id = "Microsoft.PowerShell";  Name = "PowerShell 7" },
    @{ Id = "marlocarlo.psmux";      Name = "psmux" }
)

foreach ($pkg in $packages) {
    Write-Host "  Installing $($pkg.Name)..."
    winget install --id $pkg.Id --silent --accept-package-agreements --accept-source-agreements
}

# --- Vim setup ---
Write-Host "`n[3/5] Configuring Vim..." -ForegroundColor Yellow

# Add Vim to user PATH
$vimPath = "C:\Program Files\Vim\vim92"
if (Test-Path $vimPath) {
    $current = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($current -notlike "*$vimPath*") {
        [Environment]::SetEnvironmentVariable("Path", $current + ";$vimPath", [EnvironmentVariableTarget]::User)
        Write-Host "Added Vim to user PATH"
    } else {
        Write-Host "Vim already in PATH"
    }
} else {
    Write-Host "WARNING: Vim not found at $vimPath - PATH not updated (may need to restart and re-run)"
}

New-Item -ItemType Directory -Force "$HOME\.vim\tmp" | Out-Null
New-Item -ItemType Directory -Force "$HOME\.vim\undo" | Out-Null
Write-Host "Created Vim swap/undo directories"

# Symlink _vimrc
$vimrcTarget = "$dotfilesRoot\user_home\_vimrc"
$vimrcLink = "$HOME\_vimrc"
if (-not (Test-Path $vimrcLink)) {
    cmd /c mklink "$vimrcLink" "$vimrcTarget" | Out-Null
    Write-Host "Linked _vimrc"
} else {
    Write-Host "_vimrc already exists, skipping symlink"
}

# --- Apply dotfiles ---
Write-Host "`n[4/5] Applying dotfiles..." -ForegroundColor Yellow
. "$dotfilesRoot\install.ps1"

# --- Done ---
Write-Host "`n[5/5] Bootstrap complete." -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  - Restart your terminal for PATH changes to take effect"
Write-Host "  - In Windows Terminal: Settings -> Startup -> Default profile -> PowerShell (PS7)"
Write-Host "  - Open psmux and press Ctrl+a I to install plugins"
