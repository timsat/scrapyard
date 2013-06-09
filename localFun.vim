
fun! localFun#insertPrefix(s,e, prefix)
    for lineNum in range(a:s,a:e) 
        let line = a:prefix . getline(lineNum) 
        call setline(lineNum, line)
    endfor
endf
