return {
  {
    "mfussenegger/nvim-dap",
    event = "BufReadPost",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mxsdev/nvim-dap-vscode-js",
    },
    config = function()
      require("configs.nvim-dap")
    end,
  },
}
