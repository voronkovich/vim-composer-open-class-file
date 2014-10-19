fun! ComposerOpenFileUnderCursor()
    let fqcn = ComposerFindFqcn(expand('<cword>'))
    let file = ComposerFindFile(fqcn)
    if filereadable(file)
        exe ':e ' . file
    else
        throw 'File "' .file.  '" not found. Class: "' . fqcn . '"'
    endif
endf

fun! ComposerFindFqcn(class)
   let fqcn = PhpFindMatchingUse(a:class) 
   if fqcn isnot 0
       return fqcn
   endif
   " Parsing current namespace
   " Copied from https://github.com/arnaud-lb/vim-php-namespace
   if search('^\%(<?\%(php\s\+\)\?\)\?\s*namespace\s\+', 'be') > 0
       let start = col('.')
       call search('\([[:blank:]]*[[:alnum:]\\_]\)*', 'ce')
       let end = col('.')
       let ns = strpart(getline(line('.')), start, end-start)
       return ns . "\\" . a:class
   else
       return a:class
   endif
endf

fun! ComposerFindFile(class)
    " TODO: adjusting vendor directory
    let autoload_file = findfile('vendor/autoload.php', '.;')
    if autoload_file == ''
        throw 'File vendor/autoload.php not found!'
    endif
    let code = '$c = require "' . autoload_file . '"; echo $c->findFile($argv[1]);'
    return system("php -r " . shellescape(code) . ' ' . shellescape(a:class)) 
endf
