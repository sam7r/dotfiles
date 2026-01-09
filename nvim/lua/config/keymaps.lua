-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "dm", function()
    local char = vim.fn.getcharstr()
    vim.cmd("delmarks " .. char)
end, { desc = "Delete Mark" })
