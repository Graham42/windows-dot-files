$dotfilesRoot = $PSScriptRoot
$target = "$dotfilesRoot\user_home\.config\starship.toml"
$link = "$HOME\.config\starship.toml"

if (-not (Test-Path "$HOME\.config")) {
    New-Item -ItemType Directory -Path "$HOME\.config" -Force | Out-Null
}

if (Test-Path $link) {
    $item = Get-Item $link -Force
    if ($item.LinkType -eq "SymbolicLink" -and $item.Target -eq $target) {
        Write-Host "starship config symlink already configured"
    } else {
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $backup = "$link.$timestamp.bak"
        Write-Host "Backing up existing $link to $backup"
        Copy-Item $link $backup -Force
        Remove-Item $link -Force
        Write-Host "NOTE: Consider reviewing $backup and applying any local changes to the dotfiles version."
        cmd /c mklink "$link" "$target" | Out-Null
        Write-Host "Linked starship config to $link"
    }
} else {
    cmd /c mklink "$link" "$target" | Out-Null
    Write-Host "Linked starship config to $link"
}
