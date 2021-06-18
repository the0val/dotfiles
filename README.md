# the0val's Dotfiles

My configuration files for linux systems. 

## ZSH

I use [antigen](https://github.com/zsh-users/antigen) for a very few plugins. The theme is [p10k](https://github.com/romkatv/powerlevel10k). I haven't included p10k config in this repo.

## Neovim

I use the [vim-plug](https://github.com/junegunn/vim-plug) plugin manager. This means you need to install vim-plug before the config files will work:

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
