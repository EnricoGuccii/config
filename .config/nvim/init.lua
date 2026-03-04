vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },

  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },

  { src = "https://github.com/nvim-treesitter/nvim-treesitter",    build = ":TSUpdate" },

  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.nvim" },

  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },

  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/WTFox/jellybeans.nvim" },
  { src = "https://github.com/norcalli/nvim-colorizer.lua" },

})

vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 5

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Unset 'formatexpr'
    vim.bo[args.buf].formatexpr = nil
    -- Unset 'omnifunc'
    vim.bo[args.buf].omnifunc = nil
    -- Disable document colors
    vim.lsp.document_color.enable(false, args.buf)
  end,
})

require("nvim-treesitter").setup({
  ensure_installed = {
    "lua", "vim", "bash", "json", "python",
    "cpp", "css", "java", "c"
  },
  highlight = { enable = true },
})

require("colorizer").setup()

require("ibl").setup({
  indent = { char = "▏" },
  scope = { enabled = false },
})

require("nvim-autopairs").setup()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

vim.lsp.config("pyright", {
  capabilities = capabilities,
})


vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = { "clangd", "--compile-commands-dir=." },
})

vim.lsp.config("html", {
  capabilities = capabilities,
})
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})

vim.lsp.config("cssls", {
  capabilities = capabilities,
})

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "clangd",
  "html",
  "cssls",
  "ts_ls",
})

require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

require("oil").setup({
  view_options = { show_hidden = true },
})
vim.keymap.set("n", "<leader>e", require("oil").open)

require("mini.pick").setup()
vim.keymap.set("n", "<leader>p", function()
  require("mini.pick").builtin.files()
end)

require("which-key").setup()


vim.keymap.set("n", "<leader>d", "<cmd>bdelete<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<leader><Tab>", "<cmd>bprevious<CR>")
vim.keymap.set("n", "K", vim.diagnostic.open_float)
vim.keymap.set("x", "<leader>p", '"_dP')


vim.cmd("colorscheme jellybeans")
