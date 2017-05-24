if exists('g:loaded_composer_open_file') && g:loaded_composer_open_file
    finish
endif

" Open file for specified name
fun! composer#open_file#open(name)
    let fqn = s:resolve_fqn(a:name)
    let file = s:find_file(fqn)
    if filereadable(file)
        exe ':e ' . file
    else
        throw 'File "' . file .  '" not found. Name: "' . fqn . '"'
    endif
endf

" Find fully qualified name for specified name
fun! s:resolve_fqn(name)
   let fqn = s:find_matching_use(a:name)
   if fqn isnot 0
       return fqn
   endif
   if search('^\%(<?\%(php\s\+\)\?\)\?\s*namespace\s\+', 'be') > 0
       let start = col('.')
       call search('\([[:blank:]]*[[:alnum:]\\_]\)*', 'ce')
       let end = col('.')
       let ns = strpart(getline(line('.')), start, end-start)
       return ns . '\' . a:name
   else
       return a:name
   endif
endf

fun! s:find_matching_use(name)
    let pattern = '\%(^\|\r\|\n\)\s*use\%(\_s+function\)\?\_s\+\_[^;]\{-}\_s*\(\_[^;,]*\)\_s\+as\_s\+' . a:name . '\_s*[;,]'
    let fqn = s:search_capture(pattern, 1)
    if fqn isnot 0
        return fqn
    endif

    let pattern = '\%(^\|\r\|\n\)\s*use\%(\_s+function\)\?\_s\+\_[^;]\{-}\_s*\(\_[^;,]*\%(\\\|\_s\)' . a:name . '\)\_s*[;,]'
    let fqn = s:search_capture(pattern, 1)
    if fqn isnot 0
        return fqn
    endif
endf

" Copied from https://github.com/arnaud-lb/vim-php-namespace
fun! s:search_capture(pattern, nr)
    let s:capture = 0
    let str = join(getline(0, line('$')),"\n")
    call substitute(str, a:pattern, '\=[submatch(0), s:save_capture(submatch('.a:nr.'))][0]', 'e')
    return s:capture
endf

" Copied from https://github.com/arnaud-lb/vim-php-namespace
fun! s:save_capture(capture)
    let s:capture = a:capture
endf

" Find full file path for specified name
fun! s:find_file(name)
    " TODO: adjusting vendor directory
    let autoload_file = findfile('vendor/autoload.php', '.;')
    if autoload_file == ''
        throw 'File vendor/autoload.php not found!'
    endif
    let code = '$c = require "' . autoload_file . '"; echo $c->findFile($argv[1]);'
    return system("php -r " . shellescape(code) . ' ' . shellescape(a:name))
endf

let g:loaded_composer_open_file = 1
