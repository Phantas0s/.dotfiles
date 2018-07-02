" Last modified 2017-12-09
" Dorai Sitaram

func! neoscmindent#GetScmIndent(lnum)
  return luaeval('require("neoscmindent").GetScmIndent(_A.lnum)', {'lnum': a:lnum})
endfunc
