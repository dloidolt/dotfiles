set nocompatible

" turn syntax highlighting on
syntax on
colorscheme smyck

" turn spell checker on
set spell spelllang=en_gb

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

