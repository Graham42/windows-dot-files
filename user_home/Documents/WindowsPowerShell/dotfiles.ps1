# Ctrl+d deletes the character under the cursor, or exits if the line is empty
# (mirrors the standard Unix shell behaviour)
Set-PSReadlineKeyHandler -Key "Ctrl+d" -Function DeleteCharOrExit

# Brighter directory color for readability (PSStyle available in PS7.2+)
if ($PSVersionTable.PSVersion.Major -ge 7) {
    $PSStyle.FileInfo.Directory = $PSStyle.Foreground.BrightBlue
}

# Git tab completion (PS7+ only - module installed to PS7 module path)
# To enable in PS5.1 too, run: powershell -Command "Install-Module git-completion -Scope CurrentUser -Force"
if ($PSVersionTable.PSVersion.Major -ge 7) {
    Import-Module git-completion
}

# Starship prompt
Invoke-Expression (&starship init powershell)
