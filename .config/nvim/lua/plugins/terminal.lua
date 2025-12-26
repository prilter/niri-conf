return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-t>]],  -- Switching session(nvim or zsh)
      direction = "float",        -- или "horizontal", "vertical", "tab"
      shade_terminals = true,
      start_in_insert = true,
      ersist_mode = true,         -- Save terminal session by <C-t>
      float_opts = {
        border = "curved",        -- "single", "double", "shadow", "curved"
        width = 120,
        height = 30,
      },
    })
  end,
}

