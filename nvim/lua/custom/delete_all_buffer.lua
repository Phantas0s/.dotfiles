#!/usr/bin/env lua

local function buflist()
    local list = {}
    vim.cmd([[
        redir => bufnames
        silent ls
        redir END
    ]])

    bufnames = vim.api.nvim_exec('silent ls', true)
    print(vim.inspect(bunames))
    local bufs = vim.fn.split(bufnames, "\n")
    print(vim.inspect(bufs))
    for k, v in pairs(bufs) do
        local buf = vim.fn.split(v, '"')
        vim.fn.add(list, buf[-2])
    end

    print('lala')
    vim.inspect(list)
    return list
end
buflist()

return {
    buffer_list = buflist
}
