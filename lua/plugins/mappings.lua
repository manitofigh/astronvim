return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<leader>po"] = { "<cmd>Vex<CR>", desc = "[P]roject [O]pen vertically" },
          ["<leader><CR>"] = { "<cmd>Lazy sync<CR>", desc = "Sync Lazy plugins" },
          ["<leader>Y"] = { 'gg"+yG', desc = "Yank entire buffer", silent = true },
          ["<leader>u"] = { "<cmd>UndotreeToggle<CR>", desc = "[U]ndo tree toggle" },
          ["<leader>p"] = { '"_dP', desc = "Paste without overwriting register", noremap = true },
          ["<leader>j"] = { ":cnext<CR>", desc = "Next quickfix item", noremap = true, silent = true },
          ["<leader>k"] = { ":cprev<CR>", desc = "Previous quickfix item", noremap = true, silent = true },
          ["<leader>sf"] = {
            function() require("telescope.builtin").find_files() end,
            desc = "[S]earch [F]iles",
          },
          ["<leader>sg"] = {
            function() require("telescope.builtin").live_grep() end,
            desc = "[S]earch by [G]rep",
          },
          ["<leader>cs"] = {
            function() require("telescope.builtin").colorscheme { enable_preview = true } end,
            desc = "Select colorscheme",
          },
          ["<leader>D"] = { ":%d _<CR>", desc = "[D]elete buffer to blackhole", noremap = true, silent = true },
          ["<leader>W"] = { ":w<CR>", desc = "[W]rite file", noremap = true, silent = true },
          ["<leader>X"] = { ":x<CR>", desc = "Save and e[x]it", noremap = true, silent = true },
          ["<leader>Q"] = { ":q<CR>", desc = "[Q]uit", noremap = true, silent = true },
          ["x"] = { '"_x', noremap = true, silent = true },
          ["<leader>no"] = { "<cmd>nohlsearch<CR>", desc = "[NO] highlight" },
        },
        v = {
          ["<leader>y"] = { '"+y', desc = "Yank to system clipboard" },
          ["<leader>Y"] = { 'gg"+yG', desc = "Yank entire buffer", silent = true },
          ["J"] = { ":m '>+1<CR>gv=gv", desc = "Move selection down", noremap = true, silent = true },
          ["K"] = { ":m '<-2<CR>gv=gv", desc = "Move selection up", noremap = true, silent = true },
          ["<leader>p"] = { '"_dP', desc = "Paste without overwriting register", noremap = true },
        },
      },
    },
  },
}
