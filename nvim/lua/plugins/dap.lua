return {
  {
    "mfussenegger/nvim-dap",
    event = "BufReadPost",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("configs.nvim-dap")
    end,
  },
}
