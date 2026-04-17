local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.diagnostic.config({
  virtual_text = { prefix = "" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN]  = "▲",
      [vim.diagnostic.severity.HINT]  = "⚑",
      [vim.diagnostic.severity.INFO]  = "»",
    },
  },
  underline = true,
  update_in_insert = false,
  float = { border = "rounded" },
})

-- Default config for all servers
vim.lsp.config("*", {
  capabilities = capabilities,
  on_init = function(client, _)
    if client:supports_method("textDocument/semanticTokens") then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Server-specific configs
vim.lsp.config("gopls", {
  settings = {
    completeUnimported = true,
    usePlaceholders = true,
    analyses = {
      unreachable = true,
      unusedvariable = true,
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

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders=true",
  },
  init_options = {
    fallbackFlags = { "-std=c++20" },
  },
})

vim.lsp.config("solidity_ls_nomicfoundation", {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_markers = { "foundry.toml", "hardhat.config.js", "hardhat.config.ts", "package.json", ".git" },
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
vim.lsp.enable({
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
})

-- Rust is handled by rustaceanvim plugin
