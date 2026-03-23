return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "gopls",
        "golangci-lint",
        "json-lsp",
        "gomodifytags",
        "impl",
        "goimports_reviser",
        "golines",
        "gofumpt",
        "refactoring",
        "eslint",
        "basedpyright",
        "black",
        "ruff",
        "sqlls",
        "solidity-ls",
        "rust-analyzer",
        "codelldb",
        "clangd",
        "goimports",
        "goimports-reviser",
        "nomicfoundation-solidity-language-server",
        "prisma-language-server",
        "typescript-language-server",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require "configs.lspconfig"
    end,
  },
}
