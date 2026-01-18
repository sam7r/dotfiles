return {
    "folke/noice.nvim",
    opts = function(_, opts)
        opts.presets = {
            lsp_doc_border = true,
            bottom_search = true, -- use a classic bottom cmdline for search
        }
        opts.lsp.signature = {
            opts = { size = { max_height = 15 } },
        }
    end,
}
