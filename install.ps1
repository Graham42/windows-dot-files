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

# Ensure the profile file exists
if (-not (Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

$content = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue

if ($content -match [regex]::Escape($marker_begin)) {
    # Update existing block
    $content = $content -replace "(?s)$([regex]::Escape($marker_begin)).*?$([regex]::Escape($marker_end))", $block
    Set-Content $PROFILE $content -NoNewline
    Write-Host "Updated existing windows-dot-files block in $PROFILE"
} else {
    # Append block
    Add-Content $PROFILE "`n$block"
    Write-Host "Added windows-dot-files block to $PROFILE"
}
