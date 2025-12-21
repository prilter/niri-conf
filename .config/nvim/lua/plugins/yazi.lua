-- Terminal file manager integration with yazi

return {
  "rolv-apneseth/tfm.nvim",
  lazy = false,
  opts = {
    file_manager = "yazi",
    replace_netrw = true,
    enable_cmds = true,
    keybindings = {
      ["<C-n>"] = "default",
    },
    ui = {
      border = "rounded",
      height = 0.8,
      width = 0.8,
      x = 0.5,
      y = 0.5,
    },
  },
  keys = {
    {
      "<C-n>",
      function()
        require("tfm").open()
      end,
      desc = "Open yazi",
      mode = "n",
    },
  },
}

