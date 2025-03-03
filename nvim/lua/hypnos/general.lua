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

local function zoom_toggle()
   local t = vim.api.nvim_get_current_tabpage()
   if _G.get_var(t,"zoomed", false, vim.api.nvim_tabpage_get_var) then
       local restore = _G.get_var(t,"restore", false, vim.api.nvim_tabpage_get_var)
       vim.api.nvim_exec2(restore,{output=false})
       vim.api.nvim_tabpage_set_var(t, "zoomed", false)
   else
       local restore = vim.api.nvim_call_function("winrestcmd",{})
       vim.api.nvim_tabpage_set_var(t, "restore", restore)
       vim.api.nvim_command("resize")
       vim.api.nvim_command("vertical resize")
       vim.api.nvim_tabpage_set_var(t, "zoomed", true)
   end
end

local function close_floating_windows()
    -- the argument 0 only close the popups in current tabpage
    for _, window_id in ipairs(vim.api.nvim_tabpage_list_wins(vim.api.nvim_get_current_tabpage())) do
        if vim.api.nvim_win_get_config(window_id).relative ~= '' then
            vim.api.nvim_win_close(window_id, true)
        end
    end
end

-- From the help itself
local function setTimeout(timeout, callback)
    local timer = vim.loop.new_timer()
    timer:start(timeout, 0, function ()
        timer:stop()
        timer:close()
        callback()
    end)
    return timer
end

-- function general#GitBlame() abort
--     let commit = system(printf("git blame -s -L %s,%s -- %s | head -c 8", line('.'), line('.'), expand('%')))
--     echom split(system(printf("git log --stat -1 %s | head -n 2",commit)),"\n")
-- endfunc

-- local function git_blame()
--     local commit = vim.fn.system(string.format("git blame -s -L %s,%s -- %s | head -c 8", vim.api.nvim_get_current_line(), vim.api.nvim_get_current_line(), vim.fn.expand('%')))
--     print(vim.fn.system(string.format("git log --stat -1 %s | head -n 2",commit)))
-- end

local function git_blame()
    local commit = vim.fn.system(string.format("git blame -s -L %s,%s -- %s | head -c 8", vim.api.nvim_win_get_cursor(0)[1], vim.api.nvim_win_get_cursor(0)[1], vim.fn.expand('%')))
    local info = vim.fn.system(string.format("git log --stat -1 %s | head -n 2",commit))
    local buf = vim.api.nvim_create_buf(false,true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, _G.split(info,"\n"))
    vim.api.nvim_open_win(buf, false, {relative='cursor', row=0, col=0, width=24, height=6})
end

local function git_branch()
    local branch = ""
    if vim.o.modifiable then
        -- vim.cmd('lcd %:p:h')
        local temp = osExec('git rev-parse --abbrev-ref HEAD 2> /dev/null')
        if temp ~= "" then
            branch = temp:gsub("\n", "")
            return "[" .. branch .. "]"
        end
    end
    return ""
end

local function word_count()
    -- 0 is the current buffer
    if vim.current_buffer and vim.api.nvim_get_option_value('filetype', { scope = "local" }) ~= "markdown" then
        return ""
    end
    local words = vim.fn.wordcount().words
    if vim.fn.wordcount().visual_words then
        words = vim.fn.wordcount().visual_words
    end
    return " | " .. words .. " words"
end

local function char_count()
    -- 0 is the current buffer
    if vim.api.nvim_get_option_value('filetype', { scope = "local" }) ~= "markdown" then
        return ""
    end
    local chars = vim.fn.wordcount().chars
    if vim.fn.wordcount().visual_chars then
        chars = vim.fn.wordcount().visual_chars
    end
    return " | " .. chars .. " chars"
end

local function buf_change()
    if vim.api.nvim_get_option_value('modified', { scope = "local" } ) then
        return " "
    end
    return ""
end


return {
    restore_position = restore_position,
    del_trailing_ws = del_trailing_ws,
    zoom_toggle = zoom_toggle,
    git_blame = git_blame,
    close_floating_windows = close_floating_windows,
    git_branch = git_branch,
    word_count = word_count,
    char_count = char_count,
    buf_change = buf_change,
}
