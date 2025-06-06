return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
            { "nvim-lua/plenary.nvim" },
            { "hrsh7th/nvim-cmp" },
        },
        opts = {
            --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
            strategies = {
                opts = {
                    ---Decorate the user message before it's sent to the LLM
                    ---@param message string
                    ---@param adapter CodeCompanion.Adapter
                    ---@param context table
                    ---@return string
                    prompt_decorator = function(message, adapter, context)
                        return string.format([[<prompt>%s</prompt>]], message)
                    end,
                },
                chat = {
                    adapter = "copilot",

                    tools = {
                        opts = {
                            auto_submit_errors = true, -- Send any errors to the LLM automatically?
                            auto_submit_success = true, -- Send any successful output to the LLM automatically?
                        },
                    },
                },
                inline = { adapter = "copilot" },
            },
            display = {
                chat = {
                    show_settings = false,
                },
                action_palette = {
                    provider = "snacks", -- Can be "default", "telescope", "fzf_lua", "mini_pick" and "snacks". If not specified, the plugin will autodetect installed providers.
                },
            },
        },
    },
}
