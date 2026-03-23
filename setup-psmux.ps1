$dotfilesRoot = $PSScriptRoot
$target = "$dotfilesRoot\user_home\.psmux.conf"
$link = "$HOME\.psmux.conf"

if (Test-Path $link) {
    $existing = Get-Item $link
    if ($existing.LinkType -eq 'SymbolicLink' -and $existing.Target -eq $target) {
        Write-Host "psmux config symlink already configured"
    } else {
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $backup = "$link.$timestamp.bak"
        Write-Host "Backing up existing $link to $backup"
        Copy-Item $link $backup -Force
        Remove-Item $link
        Write-Host "NOTE: Consider reviewing $backup and applying any local changes to the dotfiles version."
        cmd /c mklink "$link" "$target" | Out-Null
        Write-Host "Linked psmux config to $link"
    }
} else {
    # PS5.1 requires cmd mklink to create symlinks without elevation (even with Developer Mode)
    cmd /c mklink "$link" "$target" | Out-Null
    Write-Host "Linked psmux config to $link"
}

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
