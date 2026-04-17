local map = vim.keymap.set

-- General
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<Tab>", function()
  local col = vim.fn.col(".")
  local char = vim.fn.getline("."):sub(col, col)
  if vim.tbl_contains({ ")", "]", "}", "'", '"', "`" }, char) then
    return "<Right>"
  else
    return "<Tab>"
  end
end, { expr = true, desc = "Tab out of delimiters" })
map({ "n", "v" }, "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-- Buffer navigation
map("n", "<tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>bprev<CR>", { desc = "Prev buffer" })
map("n", "<leader>x", function() Snacks.bufdelete() end, { desc = "Close buffer" })

-- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gr", "<cmd>FzfLua lsp_references<CR>", { desc = "Show references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover info" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename" })
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Open Floating Diagnostic" })
map("n", "<leader>q", "<cmd>FzfLua diagnostics_document<CR>", { desc = "Diagnostics (floating)" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- fzf-lua (git)
map("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "Git branches" })
map("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Git status" })

-- Search in directory
map("n", "<leader>fr", function()
  vim.ui.input({ prompt = "Enter directory path: " }, function(input)
    if input then
      require("fzf-lua").live_grep({ cwd = input })
    end
  end)
end, { desc = "Search in Directory" })

-- Run cppcheck on whole project
map("n", "<leader>cc", function()
  local cwd = vim.fn.getcwd()
  local compile_db = vim.fn.findfile("compile_commands.json", cwd .. ";")

  vim.cmd("cexpr []")

  local cmd
  if compile_db ~= "" then
    cmd = "cppcheck --enable=all --std=c++20 --language=c++ --project=" .. vim.fn.fnamemodify(compile_db, ":p") .. " 2>&1"
  else
    vim.notify("No compile_commands.json found, scanning " .. cwd, vim.log.levels.WARN)
    cmd = "cppcheck --enable=all --std=c++20 --language=c++ --suppress=missingIncludeSystem " .. cwd .. " 2>&1"
  end

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.fn.setqflist({}, "a", { lines = data })
      end
    end,
    on_exit = function()
      vim.cmd("copen")
    end,
  })
end, { desc = "Run cppcheck on project" })
