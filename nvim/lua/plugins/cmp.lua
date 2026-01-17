return {
    {
        "hrsh7th/nvim-cmp",
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            require("cmp").setup({
                window = {
                    completion = {
                        border = "rounded",
                        winhighlight = "Normal:CmpNormal",
                    },
                    documentation = {
                        winhighlight = "Normal:CmpDocNormal",
                    },
                },
            })
        end,
    },
}
