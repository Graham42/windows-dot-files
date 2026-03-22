$dotfilesRoot = $PSScriptRoot
$gitconfigPath = "$dotfilesRoot\user_home\.gitconfig"

# Git expects forward slashes in include.path
$gitconfigPathForGit = $gitconfigPath -replace '\\', '/'

# Check if already included (include.path is a multi-value key)
$existing = git config --global --get-all include.path 2>$null
if ($existing -contains $gitconfigPathForGit) {
    Write-Host "gitconfig include already configured"
} else {
    git config --global --add include.path $gitconfigPathForGit
    Write-Host "Added dotfiles gitconfig include to global git config"
}
