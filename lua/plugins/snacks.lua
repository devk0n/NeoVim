
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
    keys = {
      -- Snacks extras
      { 
        "<leader>lg", 
        function() 
          require("snacks").lazygit({ cwd = vim.fn.getcwd() }) 
        end, 
        desc = "Lazygit (repo root)" 
      },
      { "<leader>gl", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
      { "<leader>rN", function() require("snacks").rename.rename_file() end, desc = "Fast Rename Current File" },
      { "<leader>dB", function() require("snacks").bufdelete() end, desc = "Delete or Close Buffer (Confirm)" },

      -- Snacks pickers
      { 
        "<leader>pf", function() require("snacks").picker.files() end, 
        desc = "Find Files (Snacks Picker)" 
      },
      { 
        "<leader>pc", function() require("snacks").picker.files({ cwd = "~/dotfiles/nvim/.config/nvim/lua" }) end, 
        desc = "Find Config File" 
      },
      { 
        "<leader>ps", function() require("snacks").picker.grep() end, 
        desc = "Grep word" 
      },
      { 
        "<leader>pws", function() require("snacks").picker.grep_word() end, 
        desc = "Search Visual selection or Word", mode = { "n", "x" } 
      },
      { 
        "<leader>pk", function() require("snacks").picker.keymaps({ layout = "ivy" }) end, 
        desc = "Search Keymaps (Snacks Picker)" 
      },
    }
  }
}
