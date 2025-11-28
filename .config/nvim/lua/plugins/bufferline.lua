-- Files list at up 

return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        -- interesting features(optional)
        diagnostics = "nvim_lsp",
        separator_style = "slant", -- "slant" | "thick" | "thin" | { "left", "right" }
        show_close_icon = false,
        show_buffer_close_icons = false,
        -- Save window with closing a buffer
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        offsets = {
          { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", separator = true },
        },
      },
    },
    keys = {
      -- Ctrl+k: next 
      { "<C-k>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      -- Ctrl+j: prev 
      { "<C-j>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      -- Ctrl+d: close
      { "<C-d>", function() require("mini.bufremove").delete(0, false) end, desc = "Close buffer" },
    },
  },

  -- For "pleasureful" closing of buffer without layout breaking
  {
    "echasnovski/mini.bufremove",
    version = "*",
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete buffer (force)" },
    },
    opts = {},
  },
}
