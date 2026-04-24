vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.fixeol = true

local function setup_lsp()
  vim.lsp.enable({
    "lua_ls",
    "clangd",
    "gopls",
    "pyright",
  })

  local augroup = vim.api.nvim_create_augroup("LspConfig", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = function(ev)
      local bufopts = { noremap = true, silent = true, buffer = ev.buf }
      vim.keymap.set("n", "grd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("i", "<C-k>", vim.lsp.completion.get, bufopts)
      vim.keymap.set("n", "<leader>f", function()
	  vim.lsp.buf.format({ async = true })
      end, bufopts)
      local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
      local methods = vim.lsp.protocol.Methods
      if client:supports_method(methods.textDocument_completion) then
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end
    end,
  })
end

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/nvim-mini/mini.files",
  "https://github.com/echasnovski/mini.pairs",
  "https://github.com/rose-pine/neovim",
})

require('rose-pine').setup({
    disable_background = true,
    styles = {
        bold = true,
        italic = false,
        transparency = true,
    },
})

vim.cmd("colorscheme rose-pine-moon")

setup_lsp()
require("mini.pick").setup()
require("mini.files").setup()
require("mini.pairs").setup()
