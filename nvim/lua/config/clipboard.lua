-- Configure clipboard integration
if vim.fn.executable("xclip") == 1 then
    vim.g.clipboard = {
        name = "xclip",
        copy = {
            ["+"] = { "xclip", "-selection", "clipboard" },
            ["*"] = { "xclip", "-selection", "primary" },
        },
        paste = {
            ["+"] = { "xclip", "-selection", "clipboard", "-o" },
            ["*"] = { "xclip", "-selection", "primary", "-o" },
        },
        cache_enabled = true,
    }
    vim.opt.clipboard = "unnamedplus"
end
