#!/usr/bin/env lua

local function buflist()
    local bufnames = vim.api.nvim_exec('silent ls', true)
    local list, bufs = {}, vim.split(bufnames, "\n")
    for k, v in pairs(bufs) do
        local buf = vim.split(v, '"')
        table.insert(list, buf[2])
    end

    return list
end

local function BDeleteOnly()
    local currentBuffer = vim.api.nvim_get_current_buf()
    print(vim.uri_from_bufnr(currentBuffer))
    local test = vim.tbl_map(vim.uri_from_fname, buflist())
    tprint(test)
    -- print(currentBuffer)

    -- use  tbl_filter({func}, {t})                                     *vim.tbl_filter()*
    -- local list = buflist()filter(general#Buflist(), 'v:val != bufname("%")')
    -- for buffer in list
    --     call general#DeleteEmptyBuffers()
    --     exec 'bdelete '.buffer
    -- endfor
end

tprint(BDeleteOnly())

return {
    buffer_list = buflist
}
