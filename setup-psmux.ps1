$dotfilesRoot = $PSScriptRoot
$target = "$dotfilesRoot\user_home\.psmux.conf"
$link = "$HOME\.psmux.conf"

if (Test-Path $link) {
    $existing = Get-Item $link
    if ($existing.LinkType -eq 'SymbolicLink' -and $existing.Target -eq $target) {
        Write-Host "psmux config symlink already configured"
        return
    }
    Write-Host "Removing existing $link"
    Remove-Item $link
}

# PS5.1 requires cmd mklink to create symlinks without elevation (even with Developer Mode)
cmd /c mklink "$link" "$target" | Out-Null
Write-Host "Linked psmux config to $link"
