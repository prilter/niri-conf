-- Render .md files for comfort

return {
  {
    -- Markdown renderer (virtual text/highlights)
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "rmd", "quarto" }, -- lazy-load on Markdown-like files
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons", -- optional, but nice to have
    },
    opts = {
      -- Basic, safe defaults; tweak to taste
      enabled = true,           -- enable plugin by default
      file_types = { "markdown", "rmd", "quarto" },
      anti_conceal = true,      -- keep regular text readable while rendering
      headings = {
        enabled = true,
        -- Example: set different icons per level
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      bullets = {
        enabled = true,
        icons = { "•", "◦", "▪" }, -- levels 1..n, cycles if fewer values
      },
      code = {
        enabled = true,
        sign = true,            -- show a left gutter sign for code blocks
        style = "full",         -- "none" | "normal" | "full"
      },
      latex = {
        enabled = true,         -- render inline math delimiters like $...$
      },
      links = {
        enabled = true,
        underline = true,
      },
      checkboxes = {
        enabled = true,
        -- Example: toggle symbols for [ ] [x] etc.
        unchecked = "",
        checked   = "",
        pending   = "",
      },
      -- You can add many more options per plugin docs
    },
    keys = {
      -- Toggle rendering in current buffer
      { "<leader>mr", function() require("render-markdown").toggle() end, desc = "Markdown: toggle render" },
      -- Refresh rendering
      { "<leader>mR", function() require("render-markdown").refresh() end, desc = "Markdown: refresh render" },
    },
  },

  -- Buffer navigation/close using Bufferline and mini.bufremove (optional but recommended)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        show_close_icon = false,
        show_buffer_close_icons = false,
        separator_style = "slant",
        -- Use mini.bufremove for non-destructive close
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      },
    },
    keys = {
      -- Ctrl+k: next buffer
      { "<C-k>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      -- Ctrl+j: previous buffer
      { "<C-j>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
      -- Ctrl+d: close current buffer (non-destructive)
      { "<C-d>", function() require("mini.bufremove").delete(0, false) end, desc = "Close buffer" },
    },
  },

  -- Soft buffer deletion that keeps windows/splits intact
  {
    "echasnovski/mini.bufremove",
    version = "*",
    opts = {},
  },

  -- Treesitter: ensure Markdown parsers are present
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
        -- add other languages you use
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

