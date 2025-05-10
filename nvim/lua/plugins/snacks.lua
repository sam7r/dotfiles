return {
    -- add snacks config
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                enabled = true,
            },
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
