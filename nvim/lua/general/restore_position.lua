#!/usr/bin/env lua

function restorePosition()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then 
        vim.fn.execute('normal! g`\"')
    end
end

return { restore_position = restorePosition }
