-- To switch themes permanently: comment/uncomment the vim.cmd.colorscheme
-- lines below. To try one temporarily: `:colorscheme tokyonight-moon` or
-- `:colorscheme rose-pine` inside neovim (resets on restart).
return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "main", -- "main" | "moon" | "dawn"
      dark_variant = "main",
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd.colorscheme("rose-pine")
      -- vim.cmd.colorscheme("tokyonight-moon")
    end,
  },
  -- kept installed (lazy) so `:colorscheme tokyonight-moon` works anytime
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },
}
