" LSP config - https://github.com/neovim/nvim-lspconfig 
" LSPs - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

lua << EOF
-- Mappings.
-- For diagnostic, see `:help vim.diagnostic.*`
local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
   local on_attach = function(client, bufnr)
-- Enable completion triggered by <c-x><c-o>
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>]', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>g', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
   end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'gopls' }
-- for _, lsp in pairs(servers) do
-- require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     flags = {
--         debounce_text_changes = 150,
--     }
-- }
-- end

-- nvim-cmp

-- Add additional capabilities supported by nvim-cmp
-- luasnip setup
-- local luasnip = require 'luasnip'

--cmp.setup.cmdline('/', {
--    sources = {
--        { name = 'buffer' }
--    }
--})

-- cmp.setup.cmdline(':', {
--    sources = cmp.config.sources({
--       { name = 'path' }
--     }, {
--       { name = 'cmdline' }
--     })
-- })

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')


-- require'lspconfig'.sqlls.setup{
--     cmd = { "sql-language-server", "up", "--method", "stdio" },
--     filetypes = { "sql", "mysql" },
--     settings = {}
-- }

local lib = vim.api.nvim_get_runtime_file("", true)
table.insert(lib, "/usr/lib/lua-language-server/meta/3rd/love2d")

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
table.insert(runtime_path, "?.lua")
table.insert(runtime_path, "/usr/share/5.3/?.lua")
table.insert(runtime_path, "/usr/share/lua/5.3/?/init.lua")

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = lib,
        checkThirdParty = false,
        ignoreSubmodules = false,
        useGitIgnore = false,
        preloadFileSize = 65536,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 
    'gopls', 
    -- 'ltex', 
    'cssls', 
    'html',
    'phpactor',
    'eslint',
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- Disable diagnosis for now
 vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

function goimports(timeout_ms)
  local context = { only = { "source.organizeImports" } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-c>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        -- ['<Tab>'] = function(fallback)
        --   if cmp.visible() then
        --     cmp.select_next_item()
        --   elseif luasnip.expand_or_jumpable() then
        --     luasnip.expand_or_jump()
        --   else
        --     fallback()
        --   end
        -- end,
        -- ['<S-Tab>'] = function(fallback)
        --   if cmp.visible() then
        --     cmp.select_prev_item()
        --   elseif luasnip.jumpable(-1) then
        --     luasnip.jump(-1)
        --   else
        --     fallback()
        --   end
        -- end,
    },
    sources = cmp.config.sources({
        -- { name = 'nvim_lsp' },
        -- { name = 'ultisnips' },
        -- { name = 'tmux' },
        -- { name = 'path' },
        { name = 'nvim_lua' },
        -- { name = "nvim_lsp_signature_help" },
    }, {
        -- { name = 'buffer' },
    })
  }

EOF

autocmd BufWritePre *.go lua goimports(1000)
