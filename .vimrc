" # Vim (~/.vim/autoload)
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" mkdir ~/.config/nvim
" mkdir ~/.config/nvim/colors
" # Neovim (~/.local/share/nvim/site/autoload)
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"

colorscheme wildcharm 

set relativenumber
set number

set ruler

syntax on

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

noremap <C-h> <cmd> TmuxNavigateLeft<CR>
noremap <C-j> <cmd> TmuxNavigateDown<CR>
noremap <C-k> <cmd> TmuxNavigateUp<CR>
noremap <C-l> <cmd> TmuxNavigateRight<CR>

set mouse=
"Keep cursor centered
autocmd CursorMoved,CursorMovedI * call Center_cursor()

function! Center_cursor()
    let pos = getpos(".")
    normal! zz
    call setpos(".", pos)
endfunction
"

noremap <c-_> :let @/ = ""<CR>:echo "Search cleared"<CR>
noremap <silent> <C-t> :split\|resize 15\|term<CR>i
noremap <silent> dm :execute 'delmarks '.nr2char(getchar())<CR>

tnoremap <Esc> <C-\><C-n>

call plug#begin('~/vimplugins')

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

"Bind lsp keybinds
function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
    let g:lsp_diagnostics_echo_cursor = 1
    nmap <buffer> gi mi<plug>(lsp-definition)
    nmap <buffer> g<C-i> <plug>(lsp-peek-definition)
    nmap <buffer> gd md<plug>(lsp-declaration)
    nmap <buffer> g<C-d> <plug>(lsp-peek-declaration)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gl <plug>(lsp-document-diagnostics)
    nmap <buffer> <f2> <plug>(lsp-rename)
    nmap <buffer> <f1> <plug>(lsp-hover)
endfunction
"

augroup lsp_install
	au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
