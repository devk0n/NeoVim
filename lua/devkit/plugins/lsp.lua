return {
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
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
          "--background-index",          -- index your codebase for fast cross-ref
          "--clang-tidy",                -- run clang-tidy diagnostics
          "--completion-style=detailed", -- better autocompletion
          "--header-insertion=never",    -- don’t auto-insert headers
          "--cross-file-rename",         -- smarter renaming across files
          "--offset-encoding=utf-16",    -- avoid encoding mismatches in Neovim
          "--compile-commands-dir=build",
          "--query-driver=/home/devkon/.espressif/tools/xtensa-esp-elf*/**/bin/xtensa-esp32s3-elf-*"
        },
        init_options = {
          clangdFileStatus = true,   -- show file status in LSP messages
          usePlaceholders = true,    -- enable placeholders for function args
          completeUnimported = true, -- suggest symbols from not-included headers
          semanticHighlighting = true,
        },
      })

      -- Define sign icons for each severity
      local signs = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN]  = " ",
        [vim.diagnostic.severity.HINT]  = "󰠠 ",
        [vim.diagnostic.severity.INFO]  = " ",
      }

      -- Set the diagnostic config with all icons
      vim.diagnostic.config({
        signs = {
          text = signs            -- Enable signs in the gutter
        },
        virtual_text = true,      -- Specify Enable virtual text for diagnostics
        underline = true,         -- Specify Underline diagnostics
        update_in_insert = false, -- Keep diagnostics active in insert mode
      })

      -- Lua LS (for Neovim config)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.fn.stdpath("data") .. "/lazy/nvim-cmp"
              },
            },
          },
        },
      })
    end,
  },
}
