return {
    {
        "nvim-neotest/neotest",
        optional = true,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            {
                "fredrikaverpil/neotest-golang", -- Installation
                dependencies = {
                    "uga-rosa/utf8.nvim", -- Additional dependency required
                },
            },
            {
                -- "nvim-neotest/neotest-jest",
                -- "adrigzr/neotest-mocha",
                -- "marilari88/neotest-vitest",
            },
        },
        ---@class neotest.CoreConfig
        opts = {
            -- See all config options with :h neotest.Config
            discovery = {
                -- Drastically improve performance in ginormous projects by
                -- only AST-parsing the currently opened buffer.
                enabled = false,
                -- Number of workers to parse files concurrently.
                -- A value of 0 automatically assigns number based on CPU.
                -- Set to 1 if experiencing lag.
                concurrent = 0,
            },
            running = {
                -- Run tests concurrently when an adapter provides multiple commands to run.
                concurrent = true,
            },
            summary = {
                -- Enable/disable animation of icons.
                animated = true,
            },
            adapters = {
                ["neotest-golang"] = {
                    -- Here we can set options for neotest-golang, e.g.
                    go_test_args = { "-timeout=60s" },
                    -- dap_go_enabled = true, -- requires leoluz/nvim-dap-go
                    sanitize_output = true,
                    runner = "gotestsum",
                    log_level = vim.log.levels.ERROR,
                },
                -- ["neotest-jest"] = {
                --     jestCommand = "npm test --",
                --     jest_test_discovery = true,
                --     env = { CI = true },
                --     args = { "--coverage=false", "--passWithNoTests" },
                -- },
                -- ["neotest-mocha"] = {
                --     mochaCommand = "npm test --",
                --     mocha_test_discovery = true,
                --     env = { CI = true },
                --     args = { "--reporter", "spec" },
                -- },
                -- ["neotest-vitest"] = {
                --     filter_dir = function(name, rel_path, root)
                --         return name ~= "node_modules"
                --     end,
                --     is_test_file = function(file_path)
                --         return string.match(file_path, ".test.tsx")
                --     end,
                -- },
            },
        },
    },
}
