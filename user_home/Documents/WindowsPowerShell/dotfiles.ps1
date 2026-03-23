# Ctrl+d deletes the character under the cursor, or exits if the line is empty
# (mirrors the standard Unix shell behaviour)
Set-PSReadlineKeyHandler -Key "Ctrl+d" -Function DeleteCharOrExit

# Brighter directory color for readability (PSStyle available in PS7.2+)
if ($PSVersionTable.PSVersion.Major -ge 7) {
    $PSStyle.FileInfo.Directory = $PSStyle.Foreground.BrightBlue
}

# Starship prompt
Invoke-Expression (&starship init powershell)
