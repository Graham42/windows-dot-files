$dotfilesRoot = $PSScriptRoot
$target = "$dotfilesRoot\user_home\.psmux.conf"
$link = "$HOME\.psmux.conf"

if (Test-Path $link) {
    $existing = Get-Item $link
    if ($existing.LinkType -eq 'SymbolicLink' -and $existing.Target -eq $target) {
        Write-Host "psmux config symlink already configured"
    } else {
        Write-Host "Removing existing $link"
        Remove-Item $link
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
if (Test-Path $ppmPath) {
    Write-Host "psmux ppm already installed"
} else {
    Write-Host "Installing psmux ppm..."
    $tmp = "$env:TEMP\psmux-plugins"
    git clone https://github.com/marlocarlo/psmux-plugins.git $tmp
    Copy-Item "$tmp\ppm" $ppmPath -Recurse
    Remove-Item $tmp -Recurse -Force
    Write-Host "psmux ppm installed"
}
