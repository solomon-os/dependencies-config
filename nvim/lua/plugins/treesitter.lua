return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup()

      local parsers = {
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
        "proto",
        "ini",
      }

      local installed = ts.get_installed("parsers") or {}
      local missing = vim.tbl_filter(function(p)
        return not vim.tbl_contains(installed, p)
      end, parsers)
      if #missing > 0 then
        ts.install(missing)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      vim.treesitter.language.register("ini", { "conf", "cfg", "dosini" })
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
