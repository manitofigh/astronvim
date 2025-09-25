-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==
  { "mbbill/undotree" },
  { "nvim-tree/nvim-tree.lua" },
  {
    "neanias/everforest-nvim",
    priority = 1,
    config = function()
      require("everforest").setup {
        background = "hard", -- Use hard background for darkest default
        transparent_background_level = 0,
      }
      -- Hook into the colorscheme to override the background after it's loaded
      --[[
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "everforest",
        callback = function()
          vim.cmd "highlight Normal guibg=#000000"
          vim.cmd "highlight NormalFloat guibg=#000000"
          vim.cmd "highlight NonText guibg=#000000"
          vim.cmd "highlight LineNr guibg=#000000"
          vim.cmd "highlight SignColumn guibg=#000000"
          vim.cmd "highlight EndOfBuffer guibg=#000000"
        end,
      })
      ]]
      --
    end,
  },

  -- customize alpha options
  -- You can disable default plugins as follows:
  { "rcarriga/nvim-notify", enabled = false },

  {
    "kevinhwang91/nvim-ufo",
    enabled = false,
  },

  --[[
  {
    "Darazaki/indent-o-matic",
    enabled = false,
  },
  --]]

  { "max397574/better-escape.nvim", enabled = false },
  { "kevinhwang91/nvim-ufo", enabled = false },

  { "tpope/vim-fugitive" },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup {
        options = {
          theme = "auto",
          -- Add any additional options here
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        -- You can configure inactive sections if needed
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        -- Add extensions if necessary
        extensions = {},
      }
    end,
  },

  --[[
  {
    "Darazaki/indent-o-matic",
  },
  ]]
  --

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
