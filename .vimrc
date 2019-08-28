set nocp " turn off compatability with VI

filetype indent plugin on

set expandtab
set shiftwidth=2
set softtabstop=2

"execute pathogen#infect()

set showmatch
set incsearch " search immediately highlights matches

" https://github.com/altercation/vim-colors-solarized
" MODIFIED
set background=dark
colorscheme base16-solarized-dark

" Line numbers in the left-hand gutter: turn on and make grey
set number
" Unfortunately, relativenumber is slow
"set relativenumber
autocmd VimEnter * highlight CursorLineNr ctermfg=DarkGreen

" Stop Q from sending into execute mode
map Q :q

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug '~/.fzf' | Plug 'junegunn/fzf.vim'
call plug#end()

" fzf integration
nmap <C-P> :Files<CR>
map <Leader>f :GFiles<CR>
map <Leader>b :Buffers<CR>

" tagbar shortcuts
map <Leader>p :TagbarToggle<CR>

" Detect markdown files by default

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

" Dispatch: run a buld command
map <Leader>d :Dispatch<CR>

let g:vim_markdown_folding_disabled = 1
let g:vimwiki_list = [{
  \ 'auto_toc': 1,
  \ 'ext': '.md',
  \ 'syntax': 'markdown',
  \ 'nested_syntaxes': {
  \   'python': 'python',
  \   'sh': 'sh',
  \   'sql': 'sql',
  \   'bash': 'sh',
  \   'perl': 'perl',
  \   'javascript': 'javascript',
  \   'js': 'javascript',
  \   'ruby': 'ruby',
  \   'rb': 'ruby',
  \   'c++': 'cpp'
  \  }
\ }]

let g:ale_fixers = {
      \ 'ruby': ['rubocop'],
      \ 'typescript': ['prettier'],
      \ 'javascript': ['prettier','eslint'],
      \ 'json': ['prettier']
      \ }
let g:ale_linters = {
      \ 'ruby': ['rubocop', 'ruby'],
      \ 'typescript': ['tsserver', 'tslint']
      \ }
"let g:ale_typescript_tslint_config_path = '/home/amacleay/src/cht-ng/cht-app-policies/tslint.yml'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_completion_enabled = 1
let g:ale_set_balloons = 1
"let g:ale_fix_on_save = 1
" for when fixing is turned off
nmap <Leader>= :ALEFix<CR>

let g:airline#extensions#ale#enabled = 1

let g:jsx_ext_required = 0

" Make easytags stop bricking the window
let g:easytags_async = 1

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.graphql set filetype=graphql

" Define folds by syntax, but leave open by default.
" Modified from http://vim.wikia.com/wiki/Folding#Indent_folding_with_manual_folds
augroup vimrc
  au BufReadPre * setlocal foldmethod=syntax
  au BufWinEnter * if &fdm == 'syntax' | setlocal foldlevel=1000 | endif
augroup END

" https://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting#16920294
" Use old regexp engine which is faster in ruby
" And, as it turns out, also in JS, so let's just always leave it on
" au BufRead,BufNewFile *.rb set re=1
set re=1

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" Enable project-specific vimrc files
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure
