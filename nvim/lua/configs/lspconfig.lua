local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.diagnostic.config {
  virtual_text = { prefix = "" },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  underline = true,
  update_in_insert = false,
  float = { border = "rounded" },
}

-- Default config for all servers
vim.lsp.config("*", {
  capabilities = capabilities,
  on_init = function(client, _)
    if client:supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Server-specific configs
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      ui = {
        completion = {
          completeUnimported = true,
          usePlaceholders = false,
          completeFunctionCalls = false,
        },
      },
      analyses = {
        unreachable = true,
        unusedvariable = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

vim.lsp.config("jsonls", {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end,
})

vim.lsp.config("sqlls", {
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "mysql", "pgsql" },
  settings = {
    sqlLanguageServer = {
      connections = {
        {
          name = "postgresql",
          adapter = "postgres",
        },
      },
    },
  },
})

vim.lsp.config("prismals", {
  cmd = { "prisma-language-server", "--stdio" },
  filetypes = { "prisma" },
  root_markers = { "schema.prisma" },
  settings = {
    prisma = {
      prismaFmtBinPath = "prisma",
    },
  },
})

vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { ".git" },
  settings = {
    basedpyright = {
      typeCheckingMode = "standard",
      reportMissingImports = true,
    },
  },
})

local _clangd_bin = vim.fn.has "mac" == 1 and "/opt/homebrew/opt/llvm/bin/clangd" or vim.fn.exepath "clangd"
local _clangpp_bin = vim.fn.has "mac" == 1 and "/opt/homebrew/opt/llvm/bin/clang++" or vim.fn.exepath "clang++"
vim.lsp.config("clangd", {
  cmd = {
    _clangd_bin,
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders=true",
    "--query-driver=" .. _clangpp_bin,
    -- Crucial flag for C++20 modules
    "--experimental-modules-support",
  },
  init_options = {
    fallbackFlags = { "-std=c++23" },
  },
})

vim.lsp.config("solidity_ls_nomicfoundation", {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_markers = { "foundry.toml", "hardhat.config.js", "hardhat.config.ts", "package.json", ".git" },
})

vim.lsp.config("yamlls", {
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      keyOrdering = false,
      format = { enable = true },
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = {
        kubernetes = {
          "*.k8s.yaml",
          "*.k8s.yml",
          "k8s/**/*.yaml",
          "k8s/**/*.yml",
          "kubernetes/**/*.yaml",
          "kubernetes/**/*.yml",
          "manifests/**/*.yaml",
          "manifests/**/*.yml",
          "deploy/**/*.yaml",
          "deploy/**/*.yml",
          "k8s/**/*deployment*.yaml",
          "k8s/**/*service*.yaml",
          "k8s/**/*ingress*.yaml",
          "k8s/**/*configmap*.yaml",
          "k8s/**/*secret*.yaml",
          "kubernetes/**/*deployment*.yaml",
          "kubernetes/**/*service*.yaml",
          "kubernetes/**/*ingress*.yaml",
          "kubernetes/**/*configmap*.yaml",
          "kubernetes/**/*secret*.yaml",
          "manifests/**/*deployment*.yaml",
          "manifests/**/*service*.yaml",
          "manifests/**/*ingress*.yaml",
          "manifests/**/*configmap*.yaml",
          "manifests/**/*secret*.yaml",
          "deploy/**/*deployment*.yaml",
          "deploy/**/*service*.yaml",
          "deploy/**/*ingress*.yaml",
          "deploy/**/*configmap*.yaml",
          "deploy/**/*secret*.yaml",
        },
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
        ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
        ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.{yml,yaml}",
        ["https://json.schemastore.org/chart.json"] = "Chart.{yml,yaml}",
      },
    },
  },
})

vim.lsp.config("helm_ls", {
  settings = {
    ["helm-ls"] = {
      yamlls = {
        path = "yaml-language-server",
      },
    },
  },
})

vim.lsp.config("buf_ls", {
  cmd = { "buf", "lsp", "serve", "--log-format=text" },
  filetypes = { "proto", "buf-config" },
  root_markers = { "buf.yaml", ".git" },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})

-- Enable all servers
vim.lsp.enable {
  "html",
  "cssls",
  "ts_ls",
  "tailwindcss",
  "gopls",
  "jsonls",
  "sqlls",
  "prismals",
  "basedpyright",
  "clangd",
  "solidity_ls_nomicfoundation",
  "lua_ls",
  "yamlls",
  "helm_ls",
  "buf_ls",
}

-- Rust is handled by rustaceanvim plugin

require("configs.protobuf")
