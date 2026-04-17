return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
      { "<leader>fw", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc = "Help tags" },
      { "<leader>fa", function() require("fzf-lua").files({ fd_opts = "--hidden --no-ignore" }) end, desc = "Find all files (incl. hidden)" },
      { "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc = "Recent files" },
    },
    opts = {
      "default",
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          layout = "flex",
          flip_columns = 120,
        },
      },
      keymap = {
        builtin = {
          true, -- inherit defaults
          ["<CR>"] = "accept",
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse",
      },
    },
  },
}
