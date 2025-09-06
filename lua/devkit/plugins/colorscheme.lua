return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,                     -- load before other plugins
    config = function()
      -- Set up Gruvbox with your preferred options
      require("gruvbox").setup({
        contrast = "hard",               -- "soft", "medium", or "hard"
        palette_overrides = {},          -- you can override specific colours here
        overrides = {},                  -- per‑group overrides if you need them
      })

      -- Activate the colorscheme
      vim.cmd("colorscheme gruvbox")

      -- ---------------------------------------------------------
      -- Link Oil.nvim’s floating‑window highlights to the generic
      -- Neovim float highlights that Gruvbox already defines.
      -- This makes the Oil window inherit the same border/background.
      -- ---------------------------------------------------------
      vim.api.nvim_set_hl(0, "OilFloatBorder", { link = "FloatBorder" })
      vim.api.nvim_set_hl(0, "OilFloatNormal", { link = "NormalFloat" })
    end,
  },

  -- …your other plugin specs go here…
}
