local function GitBranch()
    local branch = ""
    if vim.api.nvim_buf_get_option(vim.current_buffer, 'modifiable') then
        vim.cmd('lcd %:p:h')
        temp = syscmd('git rev-parse --abbrev-ref HEAD')
        vim.cmd('lcd -')
        if temp ~= 'fatal: no git repository' then
            temp:gsub("\n", "")
            branch = temp
        end
    end
    return branch
end

local function WordCount()
    -- TODO to finish
    if vim.api.nvim_buf_get_option(vim.current_buffer, 'filetype') ~= "markdown" then
        return
    end
    local currentMode = vim.api.nvim_get_mode()
    local stats = vim.api.nvim_exec([[execute("silent normal g\<c-g>")]], true)
    local wordcount = 0
    local info = {}
    if stats ~= "--No lines in buffer--" then
        info = vim.split(stats, " ")
    end
    tprint(info)
end

function status_line()
    return table.concat {
        "%r",
        "%t",
        "%M",
        " %=",
        " %=",
        "[" .. GitBranch() .. "]",
        -- WordCount(),
        " %l/%L %p%%",
        " | Buf %n"
    }
end

-- vim.o.statusline = "%!luaeval('status_line()')"

return {
    word_count = WordCount
}
