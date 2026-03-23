$dotfilesRoot = $PSScriptRoot

# Helper to create a symlink (handles existing symlinks, backs up other files)
function Set-DotfileLink {
    param([string]$Target, [string]$Link)
    if (Test-Path $Link) {
        $existing = Get-Item $Link
        if ($existing.LinkType -eq 'SymbolicLink' -and $existing.Target -eq $Target) {
            Write-Host "symlink already configured: $Link"
            return
        }
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $backup = "$Link.$timestamp.bak"
        Write-Host "Backing up existing $Link to $backup"
        Copy-Item $Link $backup -Force
        Remove-Item $Link
        Write-Host "NOTE: Consider reviewing $backup and applying any local changes to the dotfiles version."
    }
    cmd /c mklink "$Link" "$Target" | Out-Null
    Write-Host "Linked $Link"
}

$target = "$dotfilesRoot\user_home\.psmux.conf"
$link = "$HOME\.psmux.conf"

Set-DotfileLink -Target $target -Link $link

# Custom 1g theme script
Set-DotfileLink `
    -Target "$dotfilesRoot\user_home\.psmux-theme-1g.ps1" `
    -Link "$HOME\.psmux-theme-1g.ps1"

# Bootstrap ppm (psmux plugin manager)
$ppmPath = "$HOME\.psmux\plugins\ppm"
if (-not (Test-Path $ppmPath)) {
    Write-Host "Installing psmux ppm..."
    $tmp = "$env:TEMP\psmux-plugins"
    git clone https://github.com/marlocarlo/psmux-plugins.git $tmp
    Copy-Item "$tmp\ppm" $ppmPath -Recurse
    Remove-Item $tmp -Recurse -Force
    Write-Host "psmux ppm installed"
}

# Install psmux plugins
Write-Host "Installing psmux plugins..."
pwsh -NoProfile -File "$ppmPath\scripts\install_plugins.ps1"
