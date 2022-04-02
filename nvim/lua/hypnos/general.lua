#!/usr/bin/env lua

local function restore_position()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
        vim.cmd([[normal! g`"]])
    end
end

local function del_trailing_ws()
    vim.cmd([[
        normal mz
        %s/\v\s+$//ge
        normal `z
    ]])
end

return {
    restore_position = restore_position,
    del_trailing_ws = del_trailing_ws
}
