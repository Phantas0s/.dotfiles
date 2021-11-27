#!/usr/bin/env lua

local function restorePosition()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
        vim.cmd('normal! g`\"')
    end
end

local function deleteTrailingWS()
    vim.cmd([[
        normal mz
        %s/\v\s+$//ge
        normal `z
    ]])
end

return {
    restore_position = restorePosition,
    delete_trailing_ws = deleteTrailingWS
}
