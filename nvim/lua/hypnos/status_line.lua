function StatusLine()
    return table.concat {
        "%#StatusLineRO#",
        "%r", --Readonly flat
        "%#StatusLineFile#",
        " %t",
        "%#StatusLineChange#",
        '%{v:lua.require("hypnos/general").buf_change()}',
        "%#StatusLine#",
        " %=",
        '%{v:lua.require("hypnos/general").git_branch()}',
        " %l/%L %p%%",
        '%{v:lua.require("hypnos/general").word_count()}',
        '%{v:lua.require("hypnos/general").char_count()}',
        " | Buf %n"
    }
end

function ModeColor(mode)
    if mode == "i" then
        vim.cmd("highlight ModeMsg ctermfg=red ctermbg=none cterm=bold")
    elseif mode == "r" then
        vim.cmd("highlight ModeMsg ctermfg=magenta ctermbg=none cterm=bold")
    else
        vim.cmd("highlight ModeMsg ctermfg=yellow ctermbg=none cterm=bold")
    end
end

vim.o.statusline = StatusLine()

vim.cmd([[
augroup Mode
    autocmd!
    au InsertEnter * lua ModeColor(vim.api.nvim_eval('v:insertmode'))
    au InsertLeave * hi ModeMsg ctermfg=yellow ctermbg=black cterm=bold
augroup END
]])
