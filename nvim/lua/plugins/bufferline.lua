return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = function()
        require("bufferline").setup({
            options = {
                -- required for transparency, removes white lines
                separator_style = { " ", " " },
            },
        })
    end,
}
