local checkout = vim.fn.expand "~/dev/Underleaf"

return {
  {
    "manitofigh/Underleaf",
    dir = vim.fn.isdirectory(checkout) == 1 and checkout or nil,
    branch = "main",
    version = false, -- Follow main rather than pinning a release tag.
    -- Keep Chrome on macOS; use the system browser on Linux.
    opts = { browser = vim.fn.has "mac" == 1 and "chrome" or nil },
  },
}
