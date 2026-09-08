local themes = {
  "AlexvZyl/nordic.nvim",
  "EdenEast/nightfox.nvim",
  "Mofiqul/vscode.nvim",
  "Shatur/neovim-ayu",
  "bluz71/vim-moonfly-colors",
  "catppuccin/nvim",
  "craftzdog/solarized-osaka.nvim",
  "dracula/vim",
  "ellisonleao/gruvbox.nvim",
  "folke/tokyonight.nvim",
  "loctvl842/monokai-pro.nvim",
  "marko-cerovac/material.nvim",
  "navarasu/onedark.nvim",
  "nyoom-engineering/oxocarbon.nvim",
  "olimorris/onedarkpro.nvim",
  "projekt0n/github-nvim-theme",
  "rebelot/kanagawa.nvim",
  "ribru17/bamboo.nvim",
  "rose-pine/neovim",
  "sainnhe/everforest",
  "sainnhe/gruvbox-material",
  "sainnhe/sonokai",
  "savq/melange-nvim",
  "shaunsingh/nord.nvim",
}

local specs = vim.tbl_map(function(repo)
  local spec = { repo, lazy = true }
  if repo == "catppuccin/nvim" then spec.name = "catppuccin" end
  if repo == "rose-pine/neovim" then spec.name = "rose-pine" end
  if repo == "ribru17/bamboo.nvim" then spec.opts = {} end
  return spec
end, themes)

local light = {
  alucard = true,
  ["ayu-light"] = true,
  ["bamboo-light"] = true,
  ["catppuccin-latte"] = true,
  dawnfox = true,
  dayfox = true,
  ["github_light"] = true,
  ["github_light_colorblind"] = true,
  ["github_light_default"] = true,
  ["github_light_high_contrast"] = true,
  ["github_light_tritanopia"] = true,
  ["kanagawa-lotus"] = true,
  ["material-lighter"] = true,
  ["monokai-pro-light"] = true,
  onelight = true,
  ["rose-pine-dawn"] = true,
  ["solarized-osaka-light"] = true,
  ["tokyonight-day"] = true,
}

table.insert(specs, {
  "AstroNvim/astrocore",
  opts = {
    autocmds = {
      stable_theme_preview = {
        {
          event = "ColorSchemePre",
          desc = "Set a stable background before theme previews",
          callback = function(args) vim.o.background = light[args.match] and "light" or "dark" end,
        },
      },
    },
  },
})

return specs
