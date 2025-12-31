return {
    "folke/edgy.nvim",
    opts = function(_, opts)
        local step = 15
        opts.keys = {
            -- increase width
            ["<c-Right>"] = function(win)
                win:resize("width", step)
            end,
            -- decrease width
            ["<c-Left>"] = function(win)
                win:resize("width", 0 - step)
            end,
            -- increase height
            ["<c-Up>"] = function(win)
                win:resize("height", 2)
            end,
            -- decrease height
            ["<c-Down>"] = function(win)
                win:resize("height", -2)
            end,
        }
    end,
}
