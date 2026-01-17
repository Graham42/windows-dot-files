Steps taken to set up a Windows machine

## Install Claude Code

https://code.claude.com/docs/en/overview

## Instal VIM

Install [vim](https://www.vim.org/download.php) for Windows 64 bit

`~\_vimrc`:

```vim
" block cursor in normal mode  
let \&t\_SI \= "\\e\[6 q"  
let \&t\_EI \= "\\e\[2 q"

" share yank/put buffer with windows copy paste  
if has('clipboard')  
  set clipboard=unnamed  
endif  
```

## Install Git

```ps1
winget install Git.Git
```

Restart Powershell