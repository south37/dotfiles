"
" Filetype detection
"
augroup filetypedetect
    " Detect .txt as 'text'
    autocmd! BufNewFile,BufRead *.txt setfiletype text
    autocmd! BufNewFile,BufRead *.scala setfiletype scala
    autocmd! BufNewFile,BufRead *.sbt setfiletype scala
    autocmd! BufNewFile,BufRead *.cpp setfiletype cpp
    autocmd! BufNewFile,BufRead *.go setfiletype go
    autocmd! BufNewFile,BufRead *.rb setfiletype ruby
augroup END
au BufNewFile,BufRead *.gb    setf goby
