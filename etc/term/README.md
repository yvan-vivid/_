# Terminal Dotfiles

Some notes about terminal config files.

## Shells

My main shell is `zsh`, but I have some support for `bash` and `sh`. The aim is to share common environmental variables and settings across these.

### sh
Login reads       => `~/.profile`
Interactive reads => `$ENV`

I am not going to support `sh` as an interactive shell.

### bash
Login reads       => `~/.bash_profile` or `~/.profile`
Interactive reads => `~/.bashrc`

For login, `~/.bash_profile` should call `~/.bashrc`

I am not going to support bash as a login shell since I use `zsh`, but will support `bash` as interactive since that is at times convenient.

### zsh
All cases read    => `~/.zshenv`
Interactive reads => `~/.zshrc`
Login reads       => `~/.zlogin`

### synthesis of these
Environmental variables for interactive shells will be in `~/.env`.
This will be sourced by `~/.zshenv` and set to `$ENV` and `$BASH_ENV`.



