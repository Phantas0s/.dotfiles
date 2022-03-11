function TabLine()
    local line = ''
    local bufmodified = false
    print(vim.fn.tabpagenr('$'))
    for i = 1 ,vim.fn.tabpagenr('$') do
        local buffers = vim.fn.tabpagebuflist(i)
        if i == vim.fn.tabpagenr() then
            line = line .. '%#TabLineSel#'
        else
            line = line .. '%#TabLine#'
        end
        line = line .. ' ' .. i
        for idx,val in ipairs(buffers) do
            if vim.api.nvim_buf_get_option(val, 'modified') then
                line = line .. ' *'
            end
        end
        tprint(buffers)
        if buffers[0] == nil then
            line = line .. ' [No Name]'
        else
            local list = vim.split(vim.api.nvim_buf_get_name(buffers[0]), '/')
            line = line .. ' ' .. list[#list]
        end
    end
    return line
end

vim.cmd([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * lua vim.o.tabline = TabLine()
  " au WinLeave,BufLeave * lua vim.o.tabline = TabLine()
  augroup END
]])
