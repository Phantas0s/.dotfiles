local function redir(cmd)
    local win = vim.api.nvim_list_wins()
    for _, val in pairs(win) do
        if _G.get_var(val, "scratch", false, vim.api.nvim_win_get_var) then
            vim.api.nvim_win_close(val, true)
        end
    end

    local result = {}

	if cmd == nil or cmd == "" then
		table.insert(result, "Attempt to execute empty command!")
    elseif cmd:sub(1, #"!") == "!" then
		result = vim.fn.systemlist(string.sub(cmd, 2))
	else
		result = vim.fn.split(vim.fn.execute(cmd), "\n")
	end

	vim.api.nvim_command("vnew")
	local buf = vim.api.nvim_get_current_buf()
    local w = vim.api.nvim_get_current_win()

	vim.api.nvim_buf_set_name(0, "result #" .. buf)

    vim.api.nvim_win_set_var(w, "scratch", true)
    vim.api.nvim_buf_set_option(buf, "modifiable", true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, result)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(0, "buftype", "nofile")
	vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")

	vim.api.nvim_command("setlocal wrap")
	vim.api.nvim_command("setlocal cursorline")
end

return {
    redir = redir,
}
