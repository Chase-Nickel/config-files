colorscheme wildcharm 

set relativenumber
set number

set ruler

syntax on

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

noremap <C-h> <cmd> TmuxNavigateLeft<CR>
noremap <C-j> <cmd> TmuxNavigateDown<CR>
noremap <C-k> <cmd> TmuxNavigateUp<CR>
noremap <C-l> <cmd> TmuxNavigateRight<CR>
noremap <silent> <c-_> :let @/ = ""<CR>
noremap <silent> <C-t> :split\|resize 15\|term<CR>i
noremap dm :execute 'delmarks '.nr2char(getchar())<cr>
tnoremap <Esc> <C-\><C-n>
call plug#begin('~/vimplugins')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()
function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
    let g:lsp_diagnostics_echo_cursor = 1
    nmap <buffer> gi <plug>(lsp-definition)
    nmap <buffer> gd <plug>(lsp-declaration)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gl <plug>(lsp-document-diagnostics)
    nmap <buffer> <f2> <plug>(lsp-rename)
    nmap <buffer> <f1> <plug>(lsp-hover)
endfunction
augroup lsp_install
	au!
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
