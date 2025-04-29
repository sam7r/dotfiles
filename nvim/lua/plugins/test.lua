return {
    {
        "nvim-neotest/neotest",
        optional = true,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",

            "fredrikaverpil/neotest-golang",
            "nvim-neotest/neotest-jest",
        },
        opts = {
            adapters = {
                ["neotest-golang"] = {
                    -- Here we can set options for neotest-golang, e.g.
                    go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
                    dap_go_enabled = true, -- requires leoluz/nvim-dap-go
                    runner = "gotestsum", -- needed at the moment, running project tests results in warn toast hell
                },
                ["neotest-jest"] = {
                    jestCommand = "npm test --",
                    jest_test_discovery = true,
                    env = { CI = true },
                    args = { "--coverage=false", "--passWithNoTests" },
                },
            },
        },
    },
}
