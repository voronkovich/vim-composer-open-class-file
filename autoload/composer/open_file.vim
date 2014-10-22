if exists('g:loaded_composer_open_file') && g:loaded_composer_open_file
    finish
endif

" Open file for specified name
fun! composer#open_file#open(name)
    let fqn = composer#open_file#find_fqn(a:name)
    let file = composer#open_file#find_file(fqn)
    if filereadable(file)
        exe ':e ' . file
    else
        throw 'File "' .file.  '" not found. Name: "' . fqn . '"'
    endif
endf

" Find fully qualified name for specified name
fun! composer#open_file#find_fqn(name)
   let fqn = PhpFindMatchingUse(a:name) 
   if fqn isnot 0
       return fqn
   endif
   " Parsing current namespace
   " Copied from https://github.com/arnaud-lb/vim-php-namespace
   if search('^\%(<?\%(php\s\+\)\?\)\?\s*namespace\s\+', 'be') > 0
       let start = col('.')
       call search('\([[:blank:]]*[[:alnum:]\\_]\)*', 'ce')
       let end = col('.')
       let ns = strpart(getline(line('.')), start, end-start)
       return ns . "\\" . a:name
   else
       return a:name
   endif
endf

" Find full file path for specified name
fun! composer#open_file#find_file(name)
    " TODO: adjusting vendor directory
    let autoload_file = findfile('vendor/autoload.php', '.;')
    if autoload_file == ''
        throw 'File vendor/autoload.php not found!'
    endif
    let code = '$c = require "' . autoload_file . '"; echo $c->findFile($argv[1]);'
    return system("php -r " . shellescape(code) . ' ' . shellescape(a:name)) 
endf

let g:loaded_composer_open_file = 1
