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

" Wip status line
" set laststatus=2
"
" function! StatuslineActive()
"   return '%(%f%) %7(%m%r%) %= %12(%b (0x%B)%) %12(C:%c-%v%) %12(L:%l/%L%) %12(%p%%%) %='
" endfunction
"
" function! StatuslineInactive()
  " the component goes here
" endfunction

" load statusline using `autocmd` event with this function
" function! StatuslineLoad(mode)
"  if a:mode ==# 'active'
"   " to make it simple, %! is to evaluate the current changes in the window
"    " it can be useful for evaluate current mode in statusline. For more info:
"    " :help statusline.
"    setlocal statusline=%!StatuslineActive()
"  else
"    setlocal statusline=%!StatuslineInactive()
"  endif
" endfunction
" 
" augroup statusline_startup
"   autocmd!
"   " for more info :help WinEnter and :help BufWinEnter
"   autocmd WinEnter,BufWinEnter * call StatuslineLoad('active')
"   autocmd WinLeave * call StatuslineLoad('inactive')
" augroup END

"-- Status Line --"

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

noremap <C-_> :let @/ = ""<CR>:echo "Search cleared"<CR>
noremap <silent> <C-t> :split\|resize 15\|term<CR>i
noremap <silent> dm :execute 'delmarks '.nr2char(getchar())<CR>

tnoremap <Esc> <C-\><C-n>

call plug#begin('~/vimplugins')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

set updatetime=300

" Tab for autocomplete
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter for autocomplete
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent><nowait> <space>d  :call CocAction('jumpDefinition', v:false)<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
 
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

	au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
