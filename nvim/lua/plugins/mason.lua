return {
    -- add any tools you want to have installed below
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shellcheck",
                "shfmt",
                "flake8",
                "golangci-lint",
                "gofumpt",
                "goimports",
                "golines",
                "goimports-reviser",
                "buf",
                "hadolint",
                "jsonlint",
                "prettier",
            },
        },
    },
    {
        { "mason-org/mason.nvim", version = "^1.0.0" },
        { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    },
}
