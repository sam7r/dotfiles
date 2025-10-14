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
                "nvim-neotest/neotest-jest",
            },
            {
                "adrigzr/neotest-mocha",
            },
        },
        opts = {
            adapters = {
                ["neotest-golang"] = {
                    -- Here we can set options for neotest-golang, e.g.
                    go_test_args = { "-timeout=60s" },
                    dap_go_enabled = true, -- requires leoluz/nvim-dap-go
                    sanitize_output = true,
                    log_level = vim.log.levels.ERROR,
                    runner = "gotestsum", -- needed at the moment, running project tests results in warn toast hell
                },
                ["neotest-jest"] = {
                    jestCommand = "npm test --",
                    jest_test_discovery = true,
                    env = { CI = true },
                    args = { "--coverage=false", "--passWithNoTests" },
                },
                ["neotest-mocha"] = {
                    mochaCommand = "npm test --",
                    mocha_test_discovery = true,
                    env = { CI = true },
                    args = { "--reporter", "spec" },
                },
            },
        },
    },
}
