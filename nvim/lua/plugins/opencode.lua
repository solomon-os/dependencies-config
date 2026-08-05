local opencode_cmd = "opencode --port"

---@type snacks.terminal.Opts
local opencode_terminal_opts = {
  win = {
    position = "right",
    enter = false,
  },
}

return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    init = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          -- Start the integrated OpenCode server in a snacks terminal
          start = function()
            require("snacks.terminal").open(opencode_cmd, opencode_terminal_opts)
          end,
        },
      }
    end,
    keys = {
      { "<leader>oa", function() require("opencode").ask("@this: ") end, mode = { "n", "x" }, desc = "Ask OpenCode" },
      { "<leader>os", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Select OpenCode action" },
      { "<leader>ot", function() require("snacks.terminal").toggle(opencode_cmd, opencode_terminal_opts) end, desc = "Toggle OpenCode terminal" },
      { "go", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, expr = true, desc = "Append range to OpenCode" },
      { "goo", function() return require("opencode").operator("@this ") .. "_" end, expr = true, desc = "Append line to OpenCode" },
      { "<S-C-u>", function() require("opencode").command("session.half.page.up") end, desc = "Scroll OpenCode up" },
      { "<S-C-d>", function() require("opencode").command("session.half.page.down") end, desc = "Scroll OpenCode down" },
    },
  },
}
