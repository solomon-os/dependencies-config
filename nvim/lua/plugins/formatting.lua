local function has_biome_config()
  return vim.fs.find({ "biome.json", "biome.jsonc" }, {
    upward = true,
    path = vim.api.nvim_buf_get_name(0),
    stop = vim.uv.os_homedir(),
  })[1] ~= nil
end

local function js_formatters()
  if has_biome_config() then
    return { "biome" }
  end
  return { "prettier" }
end

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        go = { "goimports_reviser", "golines", "gofumpt" },
        javascript = js_formatters,
        typescript = js_formatters,
        javascriptreact = js_formatters,
        typescriptreact = js_formatters,
        json = js_formatters,
        jsonc = js_formatters,
        css = js_formatters,
        html = { "prettier" },
        python = { "black" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        solidity = { "forge_fmt" },
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 10000,
        lsp_fallback = true,
      },
      formatters = {
        clang_format = {
          prepend_args = { "--style=file" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        go = { "golangcilint" },
        python = { "ruff" },
      }
      local js_fts = {
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
      }
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        callback = function()
          if js_fts[vim.bo.filetype] then
            lint.try_lint(has_biome_config() and "biomejs" or "eslint")
          else
            lint.try_lint()
          end
        end,
      })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "Refactor",
    opts = {},
  },
}
