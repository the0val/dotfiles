" General
exe 'source '.stdpath('config').'/general.vim'
exe 'source '.stdpath('config').'/keys.vim'

if !exists('g:vscode')
  " Plugin
  exe 'luafile '.stdpath('config').'/plugins.lua'

  " Theme
  exe 'source '.stdpath('config').'/theme.vim'
endif
