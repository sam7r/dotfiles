return {
    "folke/noice.nvim",
    opts = function(_, opts)
        opts.presets = {
            lsp_doc_border = true,
        }
        opts.lsp.signature = {
            opts = { size = { max_height = 15 } },
        }
    end,
}
