-- Read the config file for a specific project
-- depending on its root directory and filepath
local function read_project_config()
    local workspace = os.getenv("WORKSPACE")
    local paths = {
        "vim_courses/book",
        "webtechno",
    }

    for _, rpath in ipairs(paths) do
        local path = workspace .. '/' .. rpath
        if path == vim.fn.getcwd() then
            vim.cmd("source " .. path .. '/.vim/vimrc') end
    end
end

return {
    read_project_config = read_project_config,
}
