$dotfilesRoot = $PSScriptRoot
$claudeHome = "$HOME\.claude"
$sourceDir = "$dotfilesRoot\user_home\.claude"

if (-not (Test-Path $claudeHome)) {
    New-Item -ItemType Directory -Path $claudeHome -Force | Out-Null
}

function Set-DotfileLink {
    param([string]$Target, [string]$Link)

    if (Test-Path $Link) {
        $item = Get-Item $Link -Force
        if ($item.LinkType -eq "SymbolicLink" -and $item.Target -eq $Target) {
            Write-Host "Already linked: $Link"
            return
        }
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $backup = "$Link.$timestamp.bak"
        Write-Host "Backing up existing $Link to $backup"
        Copy-Item $Link $backup -Force
        Remove-Item $Link -Force
        Write-Host "NOTE: Consider reviewing $backup and applying any local changes to the dotfiles version."
    }

    cmd /c mklink "$Link" "$Target" | Out-Null
    Write-Host "Linked: $Link -> $Target"
}

Set-DotfileLink "$sourceDir\CLAUDE.md" "$claudeHome\CLAUDE.md"
Set-DotfileLink "$sourceDir\settings.json" "$claudeHome\settings.json"
