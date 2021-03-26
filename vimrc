set nocompatible

" turn syntax highlighting on
syntax on
color smyck

" Set encoding
set encoding=utf-8

" I always hit ":W" instead of ":w" because I linger on the shift key...
command! Q q
command! W w:

" turn spell checker on
set spell spelllang=en_gb
" Quickly fix spelling errors choosing the first result
nmap <Leader>z z=1<CR><CR>


" turn hybrid line numbers on
" see: https://jeffkreeftmeijer.com/vim-number/
" see: https://github.com/jeffkreeftmeijer/vim-numbertoggle
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" turn off word wrap
set nowrap

" Show trailing spaces and highlight hard tabs
set list listchars=tab:»·,trail:·

" Strip trailing whitespaces on each save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Search related settings
" While typing a search command, show where the pattern, as it was typed so far, matches.
set incsearch
" highlighting of search matches
set hlsearch

" Map Ctrl+l to clear highlighted searches
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Highlight characters behind the 80 chars margin
au FileType c au BufWinEnter * let w:m2=matchadd('ColumnMargin', '\%>80v.\+', -1)

" Disable code folding
set nofoldenable

" VHDL uses 3 spaces
au FileType vhdl set softtabstop=3 tabstop=3 shiftwidth=3

"""""""""""""""""""""""""""
" Dash Doku Configuration "
"""""""""""""""""""""""""""
:nmap <silent> <leader>d <Plug>DashSearch

""""""""""""
" Nerdtree "
""""""""""""
nmap <silent> <Leader>n :NERDTreeToggle<CR>

"" Close window if last remaining window is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""
" ALE Configuration "
"""""""""""""""""""""
nmap <silent> <leader>g :ALEGoToDefinition<CR>
nmap <silent> <leader>r :ALEFindReferences<CR>
nmap <silent> <leader>h :ALEHover<CR>
nmap <silent> <leader>s :ALESymbolSearch<CR>
nmap <silent> <leader>r :ALERename<CR>
" navigate between errors quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" change the format for echo messages
let g:ale_echo_msg_format = '%s [%linter%]'

" Always show ALE Gutter
let g:ale_sign_column_always = 1

" No bgcolor for ALE SignColumn
highlight clear SignColumn

" Truncated information will be displayed when the cursor rests on a symbol
let g:ale_hover_cursor = 1

""""""""""""
" deoplete "
""""""""""""
let g:deoplete#enable_at_startup = 1

" close the preview window after completion is done.
autocmd CompleteDone * silent! pclose!

"""""""""""""""""""""""""""""
" lightline / lightline-ale "
"""""""""""""""""""""""""""""

" Always show status bar
set laststatus=2

" Disable Mode Display because Status line is on
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'smyck',
  \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" configuration form lightline-ale README.md
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \ 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \           ['filetype'] ]
      \ }


" Gitgutter
set updatetime=250

"""""""
" fzf "
"""""""
" Set fzf runtime "
set rtp+=/usr/local/opt/fzf

" Key Bindings
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>


"""""""""
" latex "
"""""""""
" tex-conceal
set conceallevel=2
let g:tex_conceal="abdgms"

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
