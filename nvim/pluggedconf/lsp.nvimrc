" LSP config - https://github.com/neovim/nvim-lspconfig 
" LSPs - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

lua << EOF
-- Mappings.

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable Omni-completion
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   local opts = { noremap=true, silent=true }
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>aa', '<cmd>lua vim.diagnostic.setqflist()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>]', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>g', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'i', '<c-i>', "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
end


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
table.insert(runtime_path, "?.lua")
table.insert(runtime_path, "/usr/share/5.3/?.lua")
table.insert(runtime_path, "/usr/share/lua/5.3/?/init.lua")

local lib = vim.api.nvim_get_runtime_file("", true)
table.insert(lib, "/usr/lib/lua-language-server/meta/3rd/love2d")

vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
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
})

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 
    -- 'ltex', 
    'gopls', 
    'bashls',
    'cssls', 
    'html',
    'phpactor',
    'eslint',
    'clojure_lsp',
    'ts_ls'
}

for _, lsp in ipairs(servers) do
    vim.lsp.config("lsp", {
        on_attach = on_attach,
    })
end

-- LSP diagnostic
do
  local method = "textDocument/publishDiagnostics"
  local default_handler = vim.lsp.handlers[method]

  vim.lsp.handlers[method] = function(err, result, ctx, config)
    default_handler(err, result, ctx, config)

    if result and result.diagnostics then
      for _, v in ipairs(result.diagnostics) do
        v.bufnr = ctx.bufnr
        v.lnum = v.range.start.line + 1
        v.col = v.range.start.character + 1
        v.text = v.message
      end

      local qflist = vim.fn.getqflist({ title = 0, id = 0 })

      vim.fn.setqflist({}, qflist.title == "LSP Workspace Diagnostics" and "r" or " ", {
        title = "LSP Workspace Diagnostics",
        items = vim.diagnostic.toqflist(result.diagnostics),
      })

      -- don't steal focus from other qf lists
      if qflist.id ~= 0 and qflist.title ~= "LSP Workspace Diagnostics" then
        vim.cmd("colder")
      end
    end
  end
end

-- Go import
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end
EOF

" Automatic go import
autocmd BufWritePre *.go lua OrgImports(1000)
