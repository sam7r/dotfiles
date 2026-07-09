return {
    -- add any tools you want to have installed below
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "bash-language-server",
                "buf",
                "delve",
                "dotenv-linter",
                "gofumpt",
                "goimports",
                "golines",
                "gomodifytags",
                "gopls",
                -- "golangci-lint", # conflicts with local version
                "golangci-lint-langserver",
                "gotests",
                "hadolint",
                "html-lsp",
                "htmlhint",
                "impl", -- go code actions
                "js-debug-adapter",
                "json-lsp",
                "jsonlint",
                "lua-language-server",
                "markdownlint-cli2",
                "prettier",
                "shellcheck",
                "shfmt",
                "spectral-language-server",
                "stylua",
                "terraform-ls",
                "tflint",
                "typos-lsp",
                "yq",
            },
        },
    },
}
