-- Fzf finder 

return {
  -- Telescope core
  {
    "nvim-telescope/telescope.nvim",
    version = false, -- latest
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- fzf-native for faster, better sorting
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = (function()
          -- Use make if available, otherwise CMake
          if vim.fn.executable("make") == 1 then
            return "make"
          elseif vim.fn.executable("cmake") == 1 then
            return table.concat({
              "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release",
              "&& cmake --build build --config Release",
              "&& cmake --install build --prefix build",
            }, " ")
          else
            return nil
          end
        end)(),
      },
      -- Optional: devicons for nicer UI (recommended)
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    keys = {
      -- Ctrl-o opens the FZF-like file picker
      { "<C-o>", function() require("telescope.builtin").find_files() end, desc = "Find Files (Telescope/FZF)" },
      -- Optional: more handy mappings
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help" },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          -- Use a dropdown/layout similar to FZF (tweak to taste)
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top" },
          prompt_prefix = "  ",
          selection_caret = " ",
          -- fzf-style settings (when fzf-native is loaded)
          file_ignore_patterns = { "%.git/", "node_modules/", "build/", "dist/" },
          mappings = {
            i = {
              -- Emulate FZF-like behavior: Tab to move selection, etc. (optional)
              -- ["<Tab>"] = "move_selection_next",
              -- ["<S-Tab>"] = "move_selection_previous",
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true, -- include dotfiles
          },
          live_grep = {
            -- additional ripgrep args if desired:
            -- additional_args = function() return { "--hidden" } end,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- fuzzy matching
            override_generic_sorter = true, -- replace generic sorter
            override_file_sorter = true,    -- replace file sorter
            case_mode = "smart_case",       -- or "ignore_case"/"respect_case"
          },
        },
      })

      -- Load fzf-native if built
      pcall(telescope.load_extension, "fzf")
    end,
  },
}

