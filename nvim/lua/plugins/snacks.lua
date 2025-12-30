return {
    -- add snacks config
    {
        "folke/snacks.nvim",
        opts = {
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
                layout = {
                    preset = "vertical",
                    width = 0.99,
                },
            },
        },
    },
}
