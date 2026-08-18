local function persist_theme(theme)
  local colorscheme_file = vim.fn.stdpath("config") .. "/lua/plugins/colorscheme.lua"
  local lines = vim.fn.readfile(colorscheme_file)
  local updated = false

  for i, line in ipairs(lines) do
    local new_line, count = line:gsub('^(local active_theme = )"[^"]+"', '%1"' .. theme .. '"')
    if count > 0 then
      lines[i] = new_line
      updated = true
      break
    end
  end

  if updated then
    vim.fn.writefile(lines, colorscheme_file)
  end

  return updated
end

local function theme_picker()
  local themes = {
    "gruvbox",
    "rose-pine",
    "tokyonight-storm",
    "tokyonight-moon",
    "catppuccin-mocha",
    "onedark",
    "duskfox",
    "material-palenight",
    "kanagawa",
  }

  require("fzf-lua").fzf_exec(themes, {
    prompt = "Theme> ",
    actions = {
      ["default"] = function(selected)
        if not (selected and selected[1]) then
          return
        end

        local theme = selected[1]
        vim.cmd.colorscheme(theme)

        if persist_theme(theme) then
          vim.notify("Switched to " .. theme .. " (saved)", vim.log.levels.INFO)
        else
          vim.notify("Switched to " .. theme .. " (not saved)", vim.log.levels.WARN)
        end
      end,
    },
  })
end

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
      { "<leader>ft", theme_picker, desc = "Find theme" },
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
