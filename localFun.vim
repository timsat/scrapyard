fun! localFun#get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  return [lnum1, col1, lnum2, col2 - (&selection == 'inclusive' ? 1 : 2)]
endf

fun! localFun#insertPrefix(s,e, prefix)
    for lineNum in range(a:s,a:e) 
        let line = a:prefix . getline(lineNum) 
        call setline(lineNum, line)
    endfor
endf

fun! localFun#surroundL(s,e, prefix, postfix)
    call append(a:s, a:prefix)
    call append(a:e+1, a:postfix)
endf

fun! localFun#surround(prefix, postfix)
    let sel = localFun#get_visual_selection()
    let line = getline(sel[0]) 
    let line = strpart(line, 0, sel[1]) . a:prefix . strpart(line, sel[1])
    call setline(sel[0], line)
    let line = getline(sel[2]) 
    let line = strpart(line, 0, sel[3]) . a:postfix . strpart(line, sel[3])
    call setline(sel[2], line)
endf
