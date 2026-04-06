-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- "lua", "vim", "bash", "c", "markdown", "markdown_inline", "python", "query", "vimdoc"
    -- are already included by AstroNvim defaults. Add additional parsers here:
    ensure_installed = {},
  },
}
