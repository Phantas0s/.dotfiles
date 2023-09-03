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

return {
    restore_position = restore_position,
    del_trailing_ws = del_trailing_ws,
    zoom_toggle = zoom_toggle
}
