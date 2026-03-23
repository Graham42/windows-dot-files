$dotfilesRoot = $PSScriptRoot

. "$dotfilesRoot\setup-gitconfig.ps1"
. "$dotfilesRoot\setup-psmux.ps1"

$marker_begin = "# BEGIN windows-dot-files"
$marker_end = "# END windows-dot-files"
$block = @"
$marker_begin
. "$dotfilesRoot\user_home\Documents\WindowsPowerShell\dotfiles.ps1"
$marker_end
"@

function Set-ProfileBlock {
    param([string]$ProfilePath)

    if (-not (Test-Path $ProfilePath)) {
        New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
    }

    $content = Get-Content $ProfilePath -Raw -ErrorAction SilentlyContinue

    if ($content -match [regex]::Escape($marker_begin)) {
        # Update existing block
        $content = $content -replace "(?s)$([regex]::Escape($marker_begin)).*?$([regex]::Escape($marker_end))", $block
        Set-Content $ProfilePath $content -NoNewline
        Write-Host "Updated existing windows-dot-files block in $ProfilePath"
    } else {
        # Append block
        Add-Content $ProfilePath "`n$block"
        Write-Host "Added windows-dot-files block to $ProfilePath"
    }
}

# PS5.1 profile
Set-ProfileBlock "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# PS7 profile (if installed)
$ps7Profile = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
if ((Test-Path (Split-Path $ps7Profile)) -or (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Set-ProfileBlock $ps7Profile
}
