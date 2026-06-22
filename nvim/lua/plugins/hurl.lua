return {
    {
        "jellydn/hurl.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- Optional, for markdown rendering with render-markdown.nvim
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "hurl" },
                },
                ft = { "markdown" },
            },
        },
        ft = "hurl",
        opts = {
            -- Show debugging info
            debug = false,
            -- Show notification on run
            show_notification = false,
            -- Show response in popup or split
            mode = "split",
            -- Default formatter
            formatters = {
                json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
                html = {
                    "prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
                    "--parser",
                    "html",
                },
                xml = {
                    "tidy", -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
                    "-xml",
                    "-i",
                    "-q",
                },
            },
            -- Default mappings for the response popup or split views
            mappings = {
                close = "q", -- Close the response popup or split view
                next_panel = "<C-n>", -- Move to the next response popup window
                prev_panel = "<C-p>", -- Move to the previous response popup window
            },
        },
        keys = {
            -- Run API request
            { "<leader>QA", "<cmd>HurlRunner<CR>", desc = "Run all requests" },
            { "<leader>Qa", "<cmd>HurlRunnerAt<CR>", desc = "Run API request" },
            { "<leader>Ql", "<cmd>HurlShowLastResponse<CR>", desc = "Show last response" },
            { "<leader>Qte", "<cmd>HurlRunnerToEntry<CR>", desc = "Run API request to entry" },
            { "<leader>QtE", "<cmd>HurlRunnerToEnd<CR>", desc = "Run API Request from current entry to end" },
            { "<leader>Qtm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
            { "<leader>Qtv", "<cmd>HurlVerbose<CR>", desc = "Run API in verbose mode" },
            { "<leader>QtV", "<cmd>HurlVeryVerbose<CR>", desc = "Run API in very verbose mode" },
            -- Run Hurl request in visual mode
            { "<leader>Qh", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
        },
    },
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                {
                    mode = "n",
                    {
                        "<leader>Q",
                        desc = "query hurl",
                        icon = { icon = "󰁥 ", color = "pink" },
                    },
                },
            },
        },
    },
}
