vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = true

vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true

local function setup_lsp()
  vim.lsp.enable({
    "clangd",
    "gopls",
    "pyright",
    "tsgo",
    "zls",
  })

  local augroup = vim.api.nvim_create_augroup("LspConfig", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = function(ev)
      local bufopts = { noremap = true, silent = true, buffer = ev.buf }
      vim.keymap.set("n", "grd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("i", "<C-k>", vim.lsp.completion.get, bufopts)
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
})

--vim.cmd("colorscheme default")

setup_lsp()
require("mini.pick").setup()
require("mini.files").setup()

