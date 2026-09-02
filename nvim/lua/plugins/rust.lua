return {
  {
    "mrcjkb/rustaceanvim",
    version = "^7",
    lazy = false,
    ft = { "rust" },
    init = function()
      local dap_adapter = nil
      local ok, mason_registry = pcall(require, "mason-registry")
      if ok then
        local has_pkg, codelldb = pcall(mason_registry.get_package, "codelldb")
        if has_pkg then
          local has_path, install_path = pcall(codelldb.get_install_path, codelldb)
          if has_path then
            local extension_path = install_path .. "/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = extension_path .. "lldb/lib/liblldb"
              .. (vim.uv.os_uname().sysname == "Linux" and ".so" or ".dylib")
            local cfg = require("rustaceanvim.config")
            dap_adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
          end
        end
      end

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
        dap = {
          adapter = dap_adapter,
        },
      }
    end,
  },
}
