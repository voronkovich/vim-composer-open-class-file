# vim-composer-open-class-file

Vim plugin for fast opening php classes (interfaces, traits and etc.) files in projects using Composer.

## How to use

Add to vimrc:

``` vim
au FileType php nnoremap gf :call composer#open_file#open(expand('<cword>'))<CR>
```

Then, hitting `gf` in normal mode will open the class (interface or traits) under the cursor.

## Installation

### Using [pathogen](https://github.com/tpope/vim-pathogen)

``` sh
git clone git://github.com/voronkovich/vim-composer-open-class-file ~/.vim/bundle/vim-composer-open-class-file
```

### Using [vundle](https://github.com/VundleVim/Vundle.vim)

Add to vimrc:

``` vim
Plugin 'voronkovich/vim-composer-open-class-file'
```

Run command in vim:

``` vim
:PluginInstall
```

### Manual installation

Download and copy `autoload/composer/open_file.vim` to `~/.vim/autoload/composer/`

## License

Copyright (c) Voronkovich Oleg.  Distributed under the same terms as Vim itself.
See `:help license`.
