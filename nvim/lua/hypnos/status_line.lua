-- TODO not really efficient to run the shell command every refresh of the statusline...
local function GitBranch()
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

local function WordCount()
    -- 0 is the current buffer
    if vim.current_buffer and vim.api.nvim_buf_get_option(0, 'filetype') ~= "markdown" then
        return ""
    end
    local words = vim.fn.wordcount().words
    if vim.fn.wordcount().visual_words then
        words = vim.fn.wordcount().visual_words
    end
    return " | " .. words .. " words"
end

local function CharCount()
    -- 0 is the current buffer
    if vim.api.nvim_buf_get_option(0, 'filetype') ~= "markdown" then
        return ""
    end
    local chars = vim.fn.wordcount().chars
    if vim.fn.wordcount().visual_chars then
        chars = vim.fn.wordcount().visual_chars
    end
    return " | " .. chars .. " chars"
end

local function BufChange()
    if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), 'modified') then
        return " "
    end
    return ""
end

-- TODO call to the different function seems to be cached... and not reloaded when needed
function StatusLine()
    return table.concat {
        "%#StatusLineRO#",
        "%r", --Readonly flat
        "%#StatusLineFile#",
        " %t",
        "%#StatusLineChange#",
        BufChange(),
        "%#StatusLine#",
        " %=",
        GitBranch(),
        " %l/%L %p%%",
        WordCount(),
        CharCount(),
        " | Buf %n"
    }
end

function ModeColor(mode)
    if mode == "i" then
        vim.cmd("hi ModeMsg ctermfg=red ctermbg=NONE cterm=bold")
    elseif mode == "r" then
        vim.cmd("hi ModeMsg ctermfg=magenta ctermbg=NONE cterm=bold")
    else
        vim.cmd("hi ModeMsg ctermfg=yellow ctermbg=NONE cterm=bold")
    end
end

vim.o.statusline = StatusLine()

vim.cmd([[
augroup Mode
    autocmd!
    au InsertEnter * lua ModeColor(vim.api.nvim_eval('v:insertmode'))
    au InsertLeave * hi ModeMsg ctermfg=yellow ctermbg=NONE cterm=bold
    au WinEnter,BufEnter,BufModifiedSet,CursorMoved,CursorMovedI * lua vim.o.statusline = StatusLine()
augroup END
]])
