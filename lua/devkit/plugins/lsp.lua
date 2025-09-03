return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Common on_attach for keymaps
    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local keymap = vim.keymap.set

      -- Navigation
      keymap("n", "gd", vim.lsp.buf.definition, opts)
      keymap("n", "gD", vim.lsp.buf.declaration, opts)
      keymap("n", "gi", vim.lsp.buf.implementation, opts)
      keymap("n", "gr", vim.lsp.buf.references, opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)

      -- Workspace / diagnostics
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap("n", "<leader>e", vim.diagnostic.open_float, opts)
      keymap("n", "[d", vim.diagnostic.goto_prev, opts)
      keymap("n", "]d", vim.diagnostic.goto_next, opts)
      keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)

      -- Formatting (if supported)
      keymap("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end

    -- C/C++ with clangd
    lspconfig.clangd.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
      },
    })

    -- Lua LS (for Neovim config)
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
        },
      },
    })
  end,
}
