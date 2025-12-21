-- Markdown rendering plugin

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- Required
      "nvim-tree/nvim-web-devicons",     -- For icons (optional)
    },
    ft = { "markdown" }, -- Load only for .md files
    config = function()
      require("render-markdown").setup({
        -- Enable rendering by default
        enabled = true,
        
        -- Heading styles
        heading = {
          enabled = true,
          sign = true,
          icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        },
        
        -- Code blocks
        code = {
          enabled = true,
          sign = true,
          style = "full",
          left_pad = 2,
          right_pad = 2,
        },
        
        -- Bullet points
        bullet = {
          enabled = true,
          icons = { "●", "○", "◆", "◇" },
        },
      })
    end,
  },
}

