return {
  {
    "mrcjkb/rustaceanvim",
    version = "^7",
    lazy = false,
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = true,
              check = {
                command = "clippy",
              },
              procMacro = {
                enable = true,
              },
              inlayHints = {
                parameterHints = { enable = true },
                chainingHints = { enable = true },
                closureReturnTypeHints = { enable = "with_block" },
              },
            },
          },
        },
      }
    end,
  },
}
