vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",    build = ":TSUpdate" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/catppuccin/nvim" },
})

vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.signcolumn = "yes"
vim.o.scrolloff = 5

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    vim.lsp.buf.format({ bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "bash", "json", "python", "cpp", "css", "arduino", },
  highlight = { enable = true },
})

require("ibl").setup({
  indent = { char = "▏" },
  scope = { enabled = true },
})

require("luasnip.loaders.from_vscode").lazy_load()


local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = true },
    },
  },
})
lspconfig.pyright.setup({})
lspconfig.cssls.setup({})
lspconfig.clangd.setup({
  cmd = { "clangd", "--compile-commands-dir=." },
  filetypes = { "c", "cpp", "objc", "objcpp", "arduino" },
})

vim.keymap.set("n", "K", vim.diagnostic.open_float, { noremap = true, silent = true })

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set("n", "<leader>e", require("oil").open)

require("mini.pick").setup()
vim.keymap.set("n", "<leader>p", function()
  require("mini.pick").builtin.files()
end, { desc = "Pick files" })

require("which-key").setup()

require("catppuccin").setup {
  color_overrides = {
    mocha = {
      base = "#121212"
    },
  }
}
vim.cmd("colorscheme catppuccin-mocha")
vim.cmd(":hi statusline guibg=NONE")
