-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.scrolloff = 10

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  if #vim.api.nvim_list_uis() == 0 then vim.cmd "cquit 1" end
  vim.fn.getchar()
  vim.cmd "cquit 1"
end

-- Shim deprecated APIs to silence warnings from plugins not yet updated for Neovim 0.12
vim.lsp.with = function(handler, override_config)
  return function(err, result, ctx, config)
    return handler(err, result, ctx, vim.tbl_deep_extend("force", config or {}, override_config or {}))
  end
end

local _original_diagnostic_config = vim.diagnostic.config
vim.diagnostic.config = function(opts, ...)
  if opts and opts.jump and opts.jump.float ~= nil then
    opts = vim.deepcopy(opts)
    if not opts.jump.on_jump then
      local should_float = opts.jump.float
      opts.jump.on_jump = should_float and function() return true end or nil
    end
    opts.jump.float = nil
  end
  return _original_diagnostic_config(opts, ...)
end

local _original_validate = vim.validate
-- Map old-style single-char type abbreviations to full type names
local _validate_type_map = {
  s = "string", S = "string",
  n = "number", N = "number",
  t = "table", T = "table",
  f = "function", F = "function",
  b = "boolean", B = "boolean",
  c = "callable", C = "callable",
}
vim.validate = function(...)
  local args = { ... }
  -- Detect old-style vim.validate({name = {val, type}}) single-table call
  if #args == 1 and type(args[1]) == "table" then
    local tbl = args[1]
    -- Check if it looks like old-style (values are tables with positional entries)
    local first_key = next(tbl)
    if first_key and type(first_key) == "string" and type(tbl[first_key]) == "table" and tbl[first_key][1] ~= nil then
      -- Convert old-style to new-style calls
      for name, spec in pairs(tbl) do
        local val = spec[1]
        local expected = spec[2]
        local optional = spec[3]
        -- Translate short type names (e.g. "f" -> "function")
        if type(expected) == "string" then
          expected = _validate_type_map[expected] or expected
        end
        _original_validate(name, val, expected, optional)
      end
      return
    end
  end
  return _original_validate(...)
end

vim.api.nvim_create_augroup("FileExplorer", { clear = false })
require "lazy_setup"
require "polish"
