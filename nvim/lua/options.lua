local o = vim.o

-- Over SSH, force OSC 52 so yanks travel through the terminal back to the
-- client machine's clipboard. Without this, nvim picks pbcopy and yanks land
-- on the remote Mac's clipboard instead. Copy uses OSC 52; paste falls back
-- to nvim's own register (most terminals refuse OSC 52 clipboard *reads*,
-- which would otherwise make `p` hang).
if vim.env.SSH_TTY then
  local osc52 = require("vim.ui.clipboard.osc52")
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end

o.number = true
o.relativenumber = true
o.clipboard = "unnamedplus"
o.cursorline = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 400
o.undofile = true
o.updatetime = 250
o.mouse = "a"
o.ignorecase = true
o.smartcase = true
o.scrolloff = 15
o.foldmethod = "indent"
o.foldenable = true
o.foldlevelstart = 99
o.foldlevel = 0
o.autoread = true
o.swapfile = false
o.spell = true
o.spelllang = "en_us"
