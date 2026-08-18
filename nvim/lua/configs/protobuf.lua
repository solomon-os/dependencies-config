local M = {}

local function shquote(s)
  return "'" .. s:gsub("'", "'\\''") .. "'"
end

-- Per-language protoc plugin definitions.
-- Plugins with `installer = "go"` are auto-installed via `go install`.
-- Plugins with `installer = "cargo"` are auto-installed via `cargo install`.
-- Plugins with no installer must be present on the system.
local language_plugins = {
  go = {
    { bin = "protoc-gen-go", pkg = "google.golang.org/protobuf/cmd/protoc-gen-go@latest", installer = "go" },
    { bin = "protoc-gen-go-grpc", pkg = "google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest", installer = "go" },
  },
  rust = {
    { bin = "protoc-gen-prost", pkg = "protoc-gen-prost", installer = "cargo" },
    { bin = "protoc-gen-tonic", pkg = "protoc-gen-tonic", installer = "cargo" },
  },
  cpp = {},
}

-- Detect the project's target language from common markers.
local function detect_language(cwd)
  local markers = {
    go = { "go.mod" },
    rust = { "Cargo.toml" },
    cpp = { "CMakeLists.txt", "compile_commands.json" },
  }

  for lang, files in pairs(markers) do
    for _, name in ipairs(files) do
      if vim.fn.filereadable(cwd .. "/" .. name) == 1 then
        return lang
      end
    end
  end

  -- C++ heuristic: any .cpp/.h/.hpp files in the project.
  local cpp_files = vim.fn.glob(cwd .. "/**/*.{cpp,h,hpp}", false, true)
  if #cpp_files > 0 then
    return "cpp"
  end

  return "unknown"
end

-- Build a protoc command for the detected language.
local function build_language_cmd(lang, relpath, cwd)
  if lang == "go" then
    return string.format(
      "protoc --proto_path=%s --go_out=%s --go_opt=paths=source_relative --go-grpc_out=%s --go-grpc_opt=paths=source_relative %s",
      shquote(cwd),
      shquote(cwd),
      shquote(cwd),
      shquote(relpath)
    )
  elseif lang == "rust" then
    return string.format(
      "protoc --proto_path=%s --prost_out=%s --tonic_out=%s %s",
      shquote(cwd),
      shquote(cwd),
      shquote(cwd),
      shquote(relpath)
    )
  elseif lang == "cpp" then
    return string.format(
      "protoc --proto_path=%s --cpp_out=%s %s",
      shquote(cwd),
      shquote(cwd),
      shquote(relpath)
    )
  end

  return nil
end

-- Install a single plugin asynchronously.
local function install_plugin(plugin, callback)
  local cmd
  if plugin.installer == "go" then
    cmd = { "go", "install", plugin.pkg }
  elseif plugin.installer == "cargo" then
    cmd = { "cargo", "install", plugin.pkg }
  else
    callback(false, "no installer configured for " .. plugin.bin)
    return
  end

  vim.notify("Installing " .. plugin.bin .. "...", vim.log.levels.INFO)
  vim.system(cmd, {}, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        callback(true, nil)
      else
        callback(false, obj.stderr or "unknown error")
      end
    end)
  end)
end

-- Ensure all plugins for a language are installed.
local function ensure_plugins(plugins, callback)
  local missing = {}
  for _, plugin in ipairs(plugins) do
    if vim.fn.executable(plugin.bin) == 0 then
      table.insert(missing, plugin)
    end
  end

  if #missing == 0 then
    callback(true)
    return
  end

  local pending = #missing
  local failed = false

  for _, plugin in ipairs(missing) do
    install_plugin(plugin, function(ok, err)
      pending = pending - 1

      if not ok then
        failed = true
        vim.notify("Failed to install " .. plugin.bin .. ":\n" .. err, vim.log.levels.ERROR)
      else
        vim.notify("Installed " .. plugin.bin, vim.log.levels.INFO)
      end

      if pending == 0 then
        callback(not failed)
      end
    end)
  end
end

-- Default build command.
-- Priority:
--   1. User override via vim.g.protoc_build_cmd
--   2. buf.gen.yaml in cwd -> buf generate
--   3. Language detection from project markers
M.default_cmd = function(relpath, _, cwd)
  -- Prefer buf if the project already uses it.
  if vim.fn.filereadable(cwd .. "/buf.gen.yaml") == 1 then
    return string.format("cd %s && buf generate %s", shquote(cwd), shquote(relpath))
  end

  local lang = detect_language(cwd)
  if lang ~= "unknown" then
    vim.notify("protoc: detected language '" .. lang .. "'", vim.log.levels.INFO)
    return build_language_cmd(lang, relpath, cwd)
  end

  -- Fallback to Go.
  vim.notify("protoc: no project marker found, falling back to Go", vim.log.levels.INFO)
  return build_language_cmd("go", relpath, cwd)
end

-- Resolve which plugins are needed for the command we're about to run.
local function plugins_for_command(cmd, cwd)
  if cmd:match("buf generate") then
    return {}
  end

  if cmd:match("%-%-go%-grpc_out") then
    return language_plugins.go
  end

  if cmd:match("%-%-tonic_out") then
    return language_plugins.rust
  end

  if cmd:match("%-%-cpp_out") then
    return language_plugins.cpp
  end

  -- If user provided a custom command, try to infer from cwd.
  local lang = detect_language(cwd)
  return language_plugins[lang] or {}
end

local function run_protoc(cmd)
  vim.notify("protoc: " .. cmd, vim.log.levels.INFO)

  vim.fn.setqflist({}, "r", { title = "protoc build" })

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.fn.setqflist({}, "a", { lines = data, efm = "%f:%l:%c: %m,%f:%l: %m" })
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.fn.setqflist({}, "a", { lines = data, efm = "%f:%l:%c: %m,%f:%l: %m" })
      end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 then
          vim.notify("protoc build succeeded", vim.log.levels.INFO)
        else
          vim.notify("protoc build failed (exit " .. code .. ")", vim.log.levels.ERROR)
          vim.cmd("copen")
        end
      end)
    end,
  })
end

function M.build()
  local file = vim.api.nvim_buf_get_name(0)
  if vim.bo.filetype ~= "proto" then
    vim.notify("Not a .proto file", vim.log.levels.WARN)
    return
  end

  local cwd = vim.fn.getcwd()
  local relpath = vim.fn.fnamemodify(file, ":.")
  if relpath:sub(1, 2) == "./" then
    relpath = relpath:sub(3)
  end

  local cmd = vim.g.protoc_build_cmd or M.default_cmd
  if type(cmd) == "string" then
    cmd = cmd:format(relpath)
  elseif type(cmd) == "function" then
    cmd = cmd(relpath, file, cwd)
  else
    vim.notify("Invalid vim.g.protoc_build_cmd", vim.log.levels.ERROR)
    return
  end

  if not cmd or cmd == "" then
    vim.notify("Could not determine protoc command", vim.log.levels.ERROR)
    return
  end

  local plugins = plugins_for_command(cmd, cwd)

  ensure_plugins(plugins, function(ok)
    if not ok then
      vim.notify("protoc build aborted: plugin installation failed", vim.log.levels.ERROR)
      return
    end

    run_protoc(cmd)
  end)
end

vim.api.nvim_create_user_command("ProtocBuild", M.build, { desc = "Build current .proto file with protoc" })

return M
