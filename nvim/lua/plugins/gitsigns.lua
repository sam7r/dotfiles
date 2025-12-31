return {
    "folke/which-key.nvim",
    opts = {
        spec = {
            {
                mode = "n",
                {
                    "<leader>gC",
                    "<cmd>Gitsigns change_base main<cr>",
                    desc = "Git Change Base (main)",
                    icon = { icon = " ", color = "orange" },
                },
                {
                    "<leader>gc",
                    "<cmd>Gitsigns change_base HEAD<cr>",
                    desc = "Git Change Base (HEAD)",
                    icon = { icon = " ", color = "orange" },
                },
            },
        },
    },
}
