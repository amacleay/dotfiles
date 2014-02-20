filetype indent plugin on

set expandtab
set shiftwidth=2
set softtabstop=2

execute pathogen#infect()

set makeprg=$P4_HOME/techops/coredev/bin/verify_code\ --vim\ --severity=1\ %\ $*
set errorformat=%f:%l:%m

set showmatch
set incsearch " search immediately highlights matches

" Stop Q from sending into execute mode
map Q :q

" Perl stuff
let perl_extended_vars = 1
let perl_sync_dist = 300 "more context for syntax highlighting
