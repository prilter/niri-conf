-- Tree settings

return {
  -- Icons (Lua)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {}, -- default setup
    priority = 100,
  },

  -- NERDTree
  {
    "preservim/nerdtree",
    cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind" },
    keys = {
      { "<C-n>", "<cmd>NERDTreeToggle<cr>", desc = "Toggle NERDTree" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      -- Autoclosing if only NERDTree (optional)
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
          if vim.fn.winnr("$") == 1 and vim.b.NERDTree and vim.b.NERDTree.isTabTree then
            vim.cmd("quit")
          end
        end,
      })
    end,
    config = function()
      vim.g.NERDTreeShowHidden = 1
      pcall(require, "nvim-web-devicons")
    end,
  },
}
