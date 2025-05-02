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
}
