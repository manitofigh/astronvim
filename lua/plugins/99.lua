---@type LazySpec
return {
  {
    "ThePrimeagen/99",
    config = function()
      local _99 = require "99"

      _99.setup {
        model = "openai/gpt-5.6-luna",
        provider_extra_args = { "--variant", "xhigh" },
      }

      vim.keymap.set("v", "<leader>cc", function() _99.visual() end, {
        desc = "AI edit selection with 99",
      })
    end,
  },
}
