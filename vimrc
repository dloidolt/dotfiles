set nocompatible

" use the zsh shell
set shell=/bin/zsh

" turn syntax highlighting on
syntax on
color smyck

" Set encoding
set encoding=utf-8

" remap <leader> key to ,
:let mapleader = ","

" enable undo changes after file write
if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif

" I always hit ":W" instead of ":w" because I linger on the shift key...
command! Q q
command! W w

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
" Ignoring case in a pattern
set ignorecase
" Overrides ignorecase if your pattern contains mixed case
set smartcase

" Map Ctrl+l to clear highlighted searches
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Highlight characters behind the 80 chars margin
au FileType c au BufWinEnter * let w:m2=matchadd('ColumnMargin', '\%>80v.\+', -1)

" Disable code folding
set nofoldenable

" change the direction of new splits
set splitbelow
set splitright

" By default, Vim assumes all .h files to be C++ files.  Since project also comes with doxygen documentation, I want to set subtype to doxygen to enable very nice doxygen highlighting.
let g:c_syntax_for_h = 1

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
nmap <silent> <leader>s :ALEGoToDefinition -vsplit<CR>
nmap <silent> <leader>t :ALEGoToDefinition -tab<CR>
" nmap <silent> <leader>ss :ALEGoToDefinition -split<CR>
nmap <silent> <leader>r :ALERename<CR>
nmap <silent> <leader>h :ALEHover<CR>
"" navigate between errors quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" disable virtualtext
let g:ale_virtualtext_cursor = 0

" change the format for echo messages
let g:ale_echo_msg_format = '%s [%linter%]'

"" Always show ALE Gutter
"let g:ale_sign_column_always = 1

"" No bgcolor for ALE SignColumn
"highlight clear SignColumn
"
"
"" use the brew python version
" let b:ale_python_pyright_config = {
" \ 'python': {
" \   'pythonPath': '/usr/local/bin/python3',
" \ },
" \}
"
"" ale c configuration
"" use the Weverything to enable all clang errors
"let g:ale_c_cc_options = '-Weverything'
"
"" use rust analyser
"let g:ale_linters = {'rust': ['cargo', 'rls', 'analyzer']} ", 'rustc']}

""""""""""""
" deoplete "
""""""""""""
" let g:deoplete#enable_at_startup = 1

" close the preview window after completion is done.
autocmd CompleteDone * silent! pclose!

"""""""""""""
" UltiSnips "
"""""""""""""
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"

" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger="<c-b>"

" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" use numpy  docstring format for python
let g:ultisnips_python_style="numpy"

"""""""""""""""""""""""""""""
" lightline / lightline-ale "
"""""""""""""""""""""""""""""
source ~/.vim/colors/smyck_lightline.vim

" Always show status bar
set laststatus=2

" Disable Mode Display because Status line is on
set noshowmode
let g:lightline = {
      \ 'colorscheme':        'smyck',
      \ 'separator':          { 'left': "", 'right': "" },
      \ 'subseparator':       { 'left': "", 'right': "" },
      \ 'component_function': { 'gitbranch': 'LightlineGitbranch' },
      \ 'component_expand':   { 'linter_checking':  'lightline#ale#checking',
      \                         'linter_infos':     'lightline#ale#infos',
      \                         'linter_warnings':  'lightline#ale#warnings',
      \                         'linter_errors':    'lightline#ale#errors',
      \                         'linter_ok': 'lightline#ale#ok'
      \ },
      \ 'component_type' :    { 'linter_checking': 'left',
      \                         'linter_warnings': 'warning',
      \                         'linter_errors': 'error',
      \                         'linter_ok': 'left'
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch'],
      \             [ 'filename', 'readonly', 'modified' ] ],
      \  'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \             [ 'filetype'] ]
      \  }
    \ }

function! LightlineGitbranch()
  if exists('*gitbranch#name')
    let mark = "@"  " edit here for cool mark
    let branch = gitbranch#name()
    return branch !=# '' ? mark.branch : ''
  endif
  return ''
endfunction


" Gitgutter
set updatetime=250
let g:gutentags_enabled='0'

"""""""
" fzf "
"""""""
" Set fzf runtime "
set rtp+=/usr/local/opt/fzf

" Key Bindings
nmap <Leader><Leader> :Buffers<CR>
nmap <Leader>f :GFiles<CR>
nmap <Leader>j :Files<CR>

""""""""""""""""""""""""""""""
" Pear Tree auto-pair plugin "
""""""""""""""""""""""""""""""
" rules for matching:
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
            \ '/\*': {'closer': ' \*/'}
            \ }

"""""""""
" latex "
"""""""""
" enable soft wrapping at the edge of the screen
au FileType tex set wrap linebreak

let g:vimtex_view_method = 'skim'
nmap <silent> <leader>v :VimtexView

" tex-conceal
"set conceallevel=2
"let g:tex_conceal="abdgms"

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
