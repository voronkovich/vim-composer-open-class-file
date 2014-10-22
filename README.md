# vim-composer-open-class-file

Vim plugin for fast opening php classes (interfaces, traits and etc.) files in projects using Composer.

## How to use

Add to vimrc:

``` vim
au FileType php nnoremap gf :call composer#open_file#open(expand('<cword>'))<CR>
```

Then, hitting `gf` in normal mode will open the class (interface or traits) under the cursor.

## Installation

Plugin depends on [vim-php-namespace](https://github.com/arnaud-lb/vim-php-namespace)

### Using [pathogen](https://github.com/tpope/vim-pathogen)

``` sh
git clone git://github.com/voronkovich/vim-composer-open-class-file ~/.vim/bundle/vim-composer-open-class-file
```

### Using [vundle](https://github.com/gmarik/vundle)

Add to vimrc:

``` vim
Bundle 'voronkovich/vim-composer-open-class-file'
```

Run command in vim:

``` vim
:BundleInstall
```

### Manual installation

Download and copy `autoload/composer/open_file.vim` to `~/.vim/autoload/composer/`

## License

Copyright (c) Voronkovich Oleg.  Distributed under the same terms as Vim itself.
See `:help license`.
