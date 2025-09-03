return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- icons
    "lewis6991/gitsigns.nvim",     -- git signs
  },
  config = function()
    require("gitsigns").setup() -- enable signs in gutter

    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true,
        always_divide_middle = false,
        section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
      },
      sections = {
        lualine_a = {
          { "mode", fmt = function(str) return " " .. str end }, -- Vim icon + mode
        },
        lualine_b = {
          "branch", -- git branch
          { "diff", source = require("gitsigns").diff_source }, -- fast diff from gitsigns
        },
        lualine_c = { "filename" },
        lualine_y = { "progress" },
        lualine_x = {
          { "diagnostics", sources = { "nvim_lsp" } },
          "encoding", "filetype"
        },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
