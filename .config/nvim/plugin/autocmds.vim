augroup TrimTrailingWhitespaces
    autocmd!
    autocmd BufWritePre * silent! lua require("utils").trim_trailing_whitespaces()
augroup END

augroup HightlightYank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

" augroup DisableCommentsContinuation
"     autocmd!
"     autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" augroup END
