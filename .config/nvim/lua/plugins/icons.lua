-- Icons for nerdtree

return {
  -- Icons provider (Lua fork of vim-devicons)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      -- enable default icons globally
      default = true,
      -- use per-icon highlight colors
      color_icons = true,
      -- be strict: prefer exact filename match before extension
      strict = true,
    },
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end,
  },
}

