-- Lsp server 

return {
  -- Package manager for LSP/formatters/linters
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  -- Bridge Mason <-> lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",     -- C/C++
          "lua_ls",   	-- Lua 
          -- "tsserver", -- TS/JS
          -- "gopls",    -- Go
          -- "rust_analyzer", -- Rust
        },
        automatic_installation = true,
      })
    end,
  },
  -- LSP configurations
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- для расширенных возможностей completion
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_cap = require("cmp_nvim_lsp").default_capabilities()

      -- Common on_attach: ключевые биндинги LSP
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
        -- Диагностики
        map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
      end

      -- Настройка серверов
      -- clangd
      lspconfig.clangd.setup({
        capabilities = cmp_cap,
        on_attach = on_attach,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })

      -- pyright
      lspconfig.pyright.setup({
        capabilities = cmp_cap,
        on_attach = on_attach,
      })

      -- Пример для Lua (отключите, если не нужно)
      -- lspconfig.lua_ls.setup({
      --   capabilities = cmp_cap,
      --   on_attach = on_attach,
      --   settings = {
      --     Lua = {
      --       diagnostics = { globals = { "vim" } },
      --       workspace = { checkThirdParty = false },
      --     },
      --   },
      -- })
    end,
  },
}

