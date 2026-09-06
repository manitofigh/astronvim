local checkout = vim.fn.expand "~/dev/Underleaf"

return {
  {
    "manitofigh/Underleaf",
    dir = vim.fn.isdirectory(checkout) == 1 and checkout or nil,
    branch = "main",
    opts = { browser = "chrome" },
  },
}
