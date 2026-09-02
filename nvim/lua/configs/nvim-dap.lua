require("dapui").setup()
require("dap-go").setup()

local dap = require("dap")

-- Rust debugging is configured by rustaceanvim via :RustLsp debuggables

local js_debug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

for _, adapter in ipairs { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" } do
  dap.adapters[adapter] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = { js_debug_path, "${port}" },
    },
  }
end

dap.adapters.node = function(cb, config)
  local merged = vim.tbl_extend("force", config, { type = "pwa-node" })
  dap.adapters["pwa-node"](cb, merged)
end

for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      port = function()
        return coroutine.create(function(dap_run_co)
          vim.ui.input({ prompt = "Port: " }, function(input)
            coroutine.resume(dap_run_co, tonumber(input))
          end)
        end)
      end,
      cwd = "${workspaceFolder}",
    },
  }
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  require("dapui").open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  require("dapui").close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  require("dapui").close()
end

vim.api.nvim_set_var("dap_log_level", "DEBUG")
vim.api.nvim_set_var("dap_log", true)

vim.fn.sign_define("DapBreakpoint", { text = "⭕", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "♦️", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "", numhl = "" })

vim.api.nvim_set_keymap("n", "<F12>", '<Cmd>lua require"dap".step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>db",
  '<Cmd>lua require"dap".toggle_breakpoint()<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>dc", require("dap").continue, { noremap = true, desc = "debug continue", silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>B', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F6>", '<Cmd>lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F9>", '<Cmd>lua require"dap".run_last()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>du", '<Cmd>lua require"dapui".toggle()<CR>', { noremap = true, silent = true })

-- Keybinding to hover and evaluate expression
vim.api.nvim_set_keymap(
  "n",
  "<leader>dh",
  '<cmd>lua require("dap.ui.widgets").hover()<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>dt", function()
  if vim.bo.filetype == "go" then
    require("dap-go").debug_test()
  elseif vim.bo.filetype == "rust" then
    vim.cmd.RustLsp("debuggables")
  else
    vim.notify("No test debugger configured for " .. vim.bo.filetype, vim.log.levels.WARN)
  end
end, { noremap = true, desc = "debug test", silent = true })
-- Keybinding to open a sidebar with expression evaluation
vim.api.nvim_set_keymap(
  "n",
  "<leader>df",
  '<cmd>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)<CR>',
  { noremap = true, silent = true }
)
