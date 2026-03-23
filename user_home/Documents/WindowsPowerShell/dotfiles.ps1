# Ctrl+d deletes the character under the cursor, or exits if the line is empty
# (mirrors the standard Unix shell behaviour)
Set-PSReadlineKeyHandler -Key "Ctrl+d" -Function DeleteCharOrExit

# Starship prompt
Invoke-Expression (&starship init powershell)
