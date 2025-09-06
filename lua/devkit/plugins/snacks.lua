return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
      local has_fd = (vim.fn.executable("fd") == 1)

      return {
        notifier = { enabled = true },
        picker = {
          enabled = true,
          use_fd = has_fd,     -- smart: use fd only if present
        },
        dashboard = { enabled = true },    -- startup screen
        explorer  = { enabled = true },    -- file explorer
        statuscolumn = { enabled = true }, -- number/diagnostic column

        -- foot doesn't support kitty graphics protocol; keep images off
        image = {
          enabled = false,
          mermaid = false,
          -- (stays off; prevents magick/gs/mmdc checks)
        },

        -- avoid "which-key not installed" warning from Snacks.toggle
        toggle = { enabled = false },
      }
    end,
    keys = {
      -- Snacks extras
      {
        "<leader>lg",
        function() require("snacks").lazygit({ cwd = vim.fn.getcwd() }) end,
        desc = "Lazygit (repo root)"
      },
      { "<leader>gl",  function() require("snacks").lazygit.log() end,         desc = "Lazygit Logs" },
      { "<leader>rN",  function() require("snacks").rename.rename_file() end,  desc = "Fast Rename Current File" },
      { "<leader>dB",  function() require("snacks").bufdelete() end,           desc = "Delete/Close Buffer (Confirm)" },

      -- Snacks pickers
      { "<leader>pf",  function() require("snacks").picker.files() end,                           desc = "Find Files (Snacks)" },
      { "<leader>pc",  function() require("snacks").picker.files({ cwd = "~/dotfiles/nvim/.config/nvim/lua" }) end, desc = "Find Config File" },
      { "<leader>ps",  function() require("snacks").picker.grep() end,                           desc = "Grep word" },
      { "<leader>pws", function() require("snacks").picker.grep_word() end, mode = { "n", "x" }, desc = "Search Visual/Word" },
      { "<leader>pk",  function() require("snacks").picker.keymaps({ layout = "ivy" }) end,      desc = "Search Keymaps (Snacks)" },
    },
  },
}
