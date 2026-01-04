setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=8
setlocal textwidth=80
setlocal noexpandtab

setlocal cindent
setlocal cinoptions=:0,l1,t0,g0,(0

autocmd FileType c match ColumnMargin /\%>80v.\+/ " virtual column 80 and more

" ALE auto import is bugie with c
let g:ale_completion_autoimport = 0
