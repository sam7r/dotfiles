-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true
vim.opt_local.smarttab = true
vim.opt_local.ttyfast = true

vim.opt.scroll = 5
vim.opt.scrolloff = 3
vim.opt.textwidth = 80
vim.opt.clipboard = "unnamedplus"
vim.opt.ttyfast = true

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.g.minipairs_disable = true
vim.g.snacks_animate = false
vim.lsp.set_log_level("off")
