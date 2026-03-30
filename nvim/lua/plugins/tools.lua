return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dbui", "dbout", "sql" },
        callback = function()
          vim.b.auto_save = false
        end,
      })
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup()
    end,
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal_cmd = vim.fn.expand("~/.local/bin/claude"),
      split_width_percentage = 0.25,
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer to Claude" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude conversation" },
      { "<leader>ao", "<cmd>ClaudeCode --continue<cr>", desc = "Continue last Claude conversation" },
      { "<leader>ay", "<cmd>ClaudeCode --dangerously-skip-permissions<cr>", desc = "Claude (skip permissions)" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
    opts = {
      enhanced_diff_hl = true,
      hooks = {
        view_opened = function()
          vim.cmd([[highlight DiffAdd guibg=#266b21 guifg=NONE]])
          vim.cmd([[highlight DiffChange guibg=#21476b guifg=NONE]])
          vim.cmd([[highlight DiffDelete guibg=#700202 guifg=NONE]])
          vim.cmd([[highlight DiffText guibg=#1a1078 guifg=NONE]])
        end,
      },
    },
  },
}
