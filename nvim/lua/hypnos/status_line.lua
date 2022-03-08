local function GitBranch()
    local branch = ""
    if vim.api.nvim_buf_get_option(vim.current_buffer, 'modifiable') then
        vim.cmd('lcd %:p:h')
        temp = syscmd('git rev-parse --abbrev-ref HEAD')
        vim.cmd('lcd -')
        if temp ~= 'fatal: no git repository' then
            branch = temp:gsub("\n", "")
        end
    end
    return branch
end

local function WordCount()
    if vim.api.nvim_buf_get_option(vim.current_buffer, 'filetype') ~= "markdown" then
        return ""
    end
    words = vim.fn.wordcount().words
    if vim.fn.wordcount().visual_words then
        words = vim.fn.wordcount().visual_words
    end
    return " | " .. words .. " words"
end

local function CharCount()
    if vim.api.nvim_buf_get_option(vim.current_buffer, 'filetype') ~= "markdown" then
        return ""
    end
    chars = vim.fn.wordcount().chars
    if vim.fn.wordcount().visual_chars then
        chars = vim.fn.wordcount().visual_chars
    end
    return " | " .. chars .. " chars"
end

function ModeColor(mode)
    if mode == "i" then
        vim.cmd("hi ModeMsg ctermfg=red ctermbg=NONE cterm=bold")
    elseif mode == "r" then
        vim.cmd("hi ModeMsg ctermfg=green ctermbg=NONE cterm=bold")
    else
        vim.cmd("hi ModeMsg ctermfg=yellow ctermbg=NONE cterm=bold")
    end
end

function StatusLine()
    return table.concat {
        "%r",
        "%t",
        "%M",
        " %=",
        " %=",
        "[" .. GitBranch() .. "]",
        " %l/%L %p%%",
        WordCount(),
        CharCount(),
        " | Buf %n"
    }
end

vim.o.statusline = StatusLine()

vim.cmd([[
augroup Mode
    autocmd!
    au InsertEnter * lua ModeColor(vim.api.nvim_eval('v:insertmode'))
    au InsertLeave * hi ModeMsg ctermfg=yellow ctermbg=NONE cterm=bold
augroup END
]])
