return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
            opts.sections = {
                lualine_a = opts.sections.lualine_a,
                lualine_b = opts.sections.lualine_b,
            }
        end,
    },
}
