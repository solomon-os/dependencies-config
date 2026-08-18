-- Default theme. Change this line, or use the theme picker (<leader>ft) to update it.
local active_theme = "gruvbox"

-- Apply the selected theme once the UI is ready.
vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    vim.cmd.colorscheme(active_theme)
  end,
})

return {
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = false,
    priority = 1000,
    opts = {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "hard", -- "hard" | "soft" | ""
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
    end,
  },

  -- Extra themes loaded eagerly so the picker / :colorscheme works instantly.
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    opts = {
      variant = "main", -- "main" | "moon" | "dawn"
      dark_variant = "main",
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = { style = "storm" },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      flavour = "mocha", -- "latte" | "frappe" | "macchiato" | "mocha"
      transparent_background = false,
    },
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    opts = {
      style = "dark", -- "dark" | "darker" | "cool" | "deep" | "warm" | "warmer"
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    opts = {},
  },
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    opts = {
      lualine_style = "stealth",
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    opts = {},
  },
}
