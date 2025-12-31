return {
    {
        "folke/snacks.nvim",
        opts = {
            ---@type table<string, snacks.win.Config>
            styles = {
                zen = {
                    width = 120,
                    backdrop = { transparent = false, blend = 40 },
                },
            },
            ---@class snacks.zen.Config
            zen = {
                -- You can add any `Snacks.toggle` id here.
                -- Toggle state is restored when the window is closed.
                -- Toggle config options are NOT merged.
                ---@type table<string, boolean>
                toggles = {
                    dim = true,
                    git_signs = false,
                    mini_diff_signs = false,
                    diagnostics = false,
                    inlay_hints = false,
                },
                center = true, -- center the window
                show = {
                    statusline = false, -- can only be shown when using the global statusline
                    tabline = false,
                },
                ---@type snacks.win.Config
                win = { style = "zen" },
                --- Callback when the window is opened.
                ---@param win snacks.win
                on_open = function(win) end,
                --- Callback when the window is closed.
                ---@param win snacks.win
                on_close = function(win) end,
                --- Options for the `Snacks.zen.zoom()`
                ---@type snacks.zen.Config
                zoom = {
                    toggles = {},
                    center = false,
                    show = { statusline = true, tabline = true },
                    win = {
                        backdrop = false,
                        width = 0, -- full width
                    },
                },
            },
            dashboard = {
                enabled = true,
                sections = {
                    {
                        section = "terminal",
                        cmd = 'figlet -w 100 $(basename "$PWD")',
                        height = 6,
                        padding = 1,
                    },
                    {
                        icon = " ",
                        desc = "Browse Repo",
                        padding = 1,
                        key = "b",
                        action = function()
                            Snacks.gitbrowse()
                        end,
                    },
                    function()
                        local in_git = Snacks.git.get_root() ~= nil
                        local cmds = {
                            -- gh extension `notify`, needs to be installed separately
                            {
                                title = "Notifications",
                                cmd = "gh notify -s -a -n5",
                                action = function()
                                    vim.ui.open("https://github.com/notifications")
                                end,
                                key = "n",
                                icon = " ",
                                height = 5,
                                enabled = true,
                            },
                            {
                                icon = " ",
                                title = "Open PRs",
                                cmd = "gh pr list -L 3",
                                key = "P",
                                action = function()
                                    vim.fn.jobstart("gh pr list --web", { detach = true })
                                end,
                                height = 9,
                            },
                            {
                                icon = " ",
                                title = "Actions",
                                cmd = "gh run list -L 3",
                                height = 5,
                            },
                            {
                                icon = " ",
                                title = "Git Status",
                                cmd = "git --no-pager diff --stat -B -M -C",
                                height = 3,
                            },
                        }
                        return vim.tbl_map(function(cmd)
                            return vim.tbl_extend("force", {
                                section = "terminal",
                                enabled = in_git,
                                padding = 1,
                                ttl = 5 * 60,
                                -- indent = 3,
                            }, cmd)
                        end, cmds)
                    end,
                    { section = "startup" },
                },
            },
            picker = {
                hidden = true,
                ignored = true,
                sources = {
                    explorer = {
                        auto_close = true,
                    },
                },
            },
            image = {
                enabled = true,
                resolve = function(path, src)
                    if require("obsidian.api").path_is_note(path) then
                        return require("obsidian.api").resolve_image_path(src)
                    end
                end,
            },
        },
    },
}
