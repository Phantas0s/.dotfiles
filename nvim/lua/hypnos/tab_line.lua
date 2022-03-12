function TabLine()
    local line = ''
    for i = 1 ,vim.fn.tabpagenr('$') do
        local buffers = vim.fn.tabpagebuflist(i)
        local mod = ''
        if i == vim.fn.tabpagenr() then
            line = line .. '%#TabLineNumSel#'
            line = line .. ' ' .. i .. ':'
            line = line .. '%#TabLineSel#'
            mod = '%#TabLineModSel#'
            mod = mod .. ""
        else
            line = line .. '%#TabLineNum#'
            line = line .. ' ' .. i .. ':'
            line = line .. '%#TabLine#'
            mod = '%#TabLineMod#'
            mod = mod .. ""
        end
        if vim.api.nvim_buf_get_name(buffers[1]) == "" then
            line = line .. '[No Name]'
        else
            local list = vim.split(vim.api.nvim_buf_get_name(buffers[1]), '/')
            line = line .. list[#list]
        end
        for idx,val in ipairs(buffers) do
            if vim.api.nvim_buf_get_option(val, 'modified') then
                line = line .. mod
                break
            end
        end
    end

    return line
end

vim.cmd([[
  augroup TabLine
  au!
  au BufEnter,TabEnter,BufWritePost,CursorMoved,CursorMovedI * lua vim.o.tabline = TabLine()
  augroup END
]])
