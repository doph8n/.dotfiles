return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    latex = {
      enabled = false,
      converter = "latex2text",
      highlight = "RenderMarkdownMath",
      top_padding = 0,
      bottom_padding = 0,
    },
  },
  config = function(_, opts)
    local markdown = require("render-markdown")
    markdown.setup(opts)
  end,
}
