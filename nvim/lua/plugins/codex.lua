return {
  {
    "nwiizo/codex.nvim",
    cmd = {
      "Codex",
      "CodexAdd",
      "CodexContinue",
      "CodexDiff",
      "CodexFocus",
      "CodexHealth",
      "CodexReview",
      "CodexSendVisual",
    },
    keys = {
      { "<leader>zc", "<cmd>CodexFocus<cr>", desc = "Focus or hide Codex" },
      { "<leader>zb", "<cmd>CodexAdd<cr>", desc = "Add buffer to Codex" },
      { "<leader>zs", "<cmd>CodexSendVisual<cr>", mode = "x", desc = "Send selection to Codex" },
      { "<leader>zr", "<cmd>CodexReview --uncommitted<cr>", desc = "Review uncommitted changes with Codex" },
      { "<leader>zd", "<cmd>CodexDiff<cr>", desc = "Show latest Codex diff" },
      { "<leader>zo", "<cmd>CodexContinue<cr>", desc = "Continue last Codex conversation" },
    },
    opts = {
      backend = "terminal",
      cmd = { "codex" },
      cwd = "root",
      focus_after_send = false,
    },
  },
}
