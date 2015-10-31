set nocp " turn off compatability with VI

filetype indent plugin on

set expandtab
set shiftwidth=2
set softtabstop=2

execute pathogen#infect()

set showmatch
set incsearch " search immediately highlights matches

" Line numbers in the left-hand gutter: turn on and make grey
set number
set relativenumber
autocmd VimEnter * highlight LineNr ctermfg=DarkGrey

" Stop Q from sending into execute mode
map Q :q

" Detect markdown files by default
au BufRead,BufNewFile *.md set filetype=markdown

" Perl stuff
let perl_extended_vars = 1
let perl_sync_dist = 300 "more context for syntax highlighting

" dragvisuals.vim
vmap <expr> <LEFT> DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN> DVB_Drag('down')
vmap <expr> <UP> DVB_Drag('up')

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

