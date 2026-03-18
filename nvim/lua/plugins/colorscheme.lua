return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup {
        background = "hard",
        transparent_background_level = 2,
        italics = true,
      }
      vim.cmd.colorscheme "everforest"
    end,
  },
}
