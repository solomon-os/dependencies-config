return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "vim",
          "lua",
          "vimdoc",
          "html",
          "css",
          "go",
          "gosum",
          "gomod",
          "gowork",
          "solidity",
          "c",
          "cpp",
          "rust",
          "toml",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "python",
          "markdown",
          "markdown_inline",
        },
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    opts = {},
  },
}
