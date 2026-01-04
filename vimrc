colorscheme smyck

" Set encoding
set encoding=utf-8

set updatetime=1000

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

" Search related settings
" While typing a search command, show where the pattern, as it was typed so far, matches.
set incsearch
" highlighting of search matches
set hlsearch
" Ignoring case in a pattern
set ignorecase
" Overrides ignorecase if your pattern contains mixed case
set smartcase


" Show trailing spaces and highlight hard tabs
set list listchars=tab:»·,trail:·,nbsp:␣

" Strip trailing whitespaces on each save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" a new file will in split view open on the right/bottom side of the current split.
set splitright
set splitbelow

" Mimic English keyboard: map 'ü' and '+' to '[' and ']' respectively in normal mode
nmap ü [
nmap + ]

" c-syntax highlighting options
autocmd FileType diff setlocal ts=8
autocmd FileType make setlocal ts=8 sw=8 sts=8 noet

"for *.h files use C syntax instead of C++ and use objc syntax instead of objcpp
:let c_syntax_for_h = 1
" GNU gcc specific items
:let c_gnu = 1
" spaces before a <Tab> as error
:let c_space_errors = 1
:let c_no_trail_space_error = 1



"""""""""""""""""""""""""""
" Dash Doku Configuration "
"""""""""""""""""""""""""""
nmap <silent> <leader>d <Plug>DashSearch


"""""""""""
" signify "
"""""""""""
let g:signify_sign_change = '~'
nnoremap <leader>gu :SignifyHunkUndo<cr>


"""""""
" fzf "
"""""""
"Respecting .gitignore
"If you want the command to follow symbolic links and don't want it to exclude
"hidden files, use the following command:
let $FZF_DEFAULT_COMMAND = 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

" Key Bindings
nmap <Leader><Leader> :Buffers<CR>
nmap <Leader>f :GFiles --cached --others --exclude-standard<cr>
nmap <Leader>j :Files<CR>


"""""""""""""""""""""
" ALE Configuration "
"""""""""""""""""""""
nmap <silent> <leader>g :ALEGoToDefinition<CR>
nmap <silent> <leader>s :ALEGoToDefinition -vsplit<CR>
nmap <silent> <leader>r :ALERename<CR>
nmap <silent> <leader>h :ALEHover<CR>
"" navigate between errors quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" disable virtualtext
let g:ale_virtualtext_cursor = 'disabled'
" change the format for echo messages
let g:ale_echo_msg_format = '%s [%linter%]'
" Enable completion where available.
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
let g:ale_completion_enabled = 1


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


"""""""""""""
" UltiSnips "
"""""""""""""
" If you prefer to use the same trigger for expanding snippets and jumping forward,
let g:UltiSnipsExpandOrJumpTrigger = "<tab>"
" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"


"""""""""""
" Mesonic "
"""""""""""
nmap <silent> <leader>t :MesonTest --print-errorlogs<CR>


" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
