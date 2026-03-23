## Environment

This is a Windows 11 environment with both PowerShell 5.1 and PowerShell 7 (pwsh) installed.
The default shell for terminals and psmux is pwsh (PS7).



## Code Style / Conventions

Do NOT add -ErrorAction SilentlyContinue, try/catch blocks, or other error suppression unless explicitly requested.

## PowerShell

When editing PowerShell scripts, be aware of encoding issues - em dash and special characters can corrupt PS files. Always use ASCII-safe characters in PowerShell code.

## Search Tools

Prefer built-in tools over shell commands for searching:
1. Use the Glob tool (not `find`/`ls`) for finding files by pattern
2. Use the Grep tool (not `grep` or `rg`) for searching file contents -- it's built on ripgrep
3. Only fall back to Bash with `rg` (ripgrep) if the built-in Grep tool is insufficient; prefer `rg` over `grep` when using Bash
