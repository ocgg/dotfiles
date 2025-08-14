local global = vim.g
local o = vim.opt

global.mapleader = " "

-- required for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

o.number = true
o.relativenumber = true
o.clipboard = "unnamedplus"
o.syntax = "on"
-- o.autoindent = true
-- o.cursorline = true
vim.wo.wrap = false
o.linebreak = true
o.expandtab = true
o.shiftwidth = 0
o.tabstop = 4
-- o.encoding = "UTF-8"
-- o.ruler = true
o.mouse = "a"
o.title = true
-- o.hidden = true
-- o.wildmenu = true
-- o.showcmd = true
o.showmatch = true
o.inccommand = "split"
o.splitright = true
o.splitbelow = true
o.termguicolors = true

-- o.hlsearch = false
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
vim.wo.signcolumn = "yes"
-- o.updatetime = 250
o.timeoutlen = 300
-- o.completeopt = 'menuone,noselect'
-- vertical line
o.colorcolumn = "80"
o.scrolloff = 5
o.sidescrolloff = 15

vim.diagnostic.config({
  float = {
    source = "always", -- Shows from which LSP comes the diagnostic
  },
})
