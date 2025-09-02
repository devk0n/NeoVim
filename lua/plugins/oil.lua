
return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for icons

  -- Disable netrw early so Oil can take over as the file explorer
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,

  -- Setup
  config = function()
    require("oil").setup({
      default_file_explorer = true,    -- use Oil instead of netrw
      delete_to_trash = true,          -- requires `trash-cli` on Linux
      skip_confirm_for_simple_edits = true,

      -- Show/hide columns (leave empty for minimal UI)
      -- Common choices: "icon", "permissions", "size", "mtime"
      columns = {},

      -- Oil-specific keymaps (only inside Oil buffers)
      keymaps = {
        ["<C-h>]"] = false,            -- example: disable built-in if you don’t want it
        ["<C-c>"] = false,             -- don’t close Oil on <C-c> (treat it like <Esc>)
        ["<M-h>"] = "actions.select_split",
        ["q"] = "actions.close",
      },

      view_options = {
        show_hidden = true,            -- show dotfiles
      },
    })

    -- Global mappings
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Oil (float)" })

    -- Buffer-local tweaks in Oil
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        vim.opt_local.cursorline = true
      end,
      desc = "Oil: enable cursorline",
    })
  end,
}
