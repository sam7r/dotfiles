return {
    -- add snacks config
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                hidden = true,
                ignored = true,
                sources = {
                    explorer = {
                        auto_close = true,
                    },
                },
            },
        },
    },
}
