return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
            -- Add custom components for taskwarrior and timewarrior
            local task_count = {
                function()
                    local handle = io.popen("task count rc.gc=off rc.verbose=nothing status:pending 2>/dev/null")
                    if handle then
                        local result = handle:read("*a")
                        handle:close()
                        local count = tonumber(result:match("%d+")) or 0
                        if count > 0 then
                            return "󰣉 " .. count
                        end
                    end
                    return ""
                end,
                cond = function()
                    return vim.fn.executable("task") == 1
                end,
                color = { fg = "#b9eb81" },
            }

            local task_context = {
                function()
                    local handle = io.popen("task _get rc.context 2>/dev/null")
                    if handle then
                        local result = handle:read("*a")
                        handle:close()
                        result = result:gsub("%s+", "")
                        if result ~= "" then
                            return " " .. result
                        end
                    end
                    return ""
                end,
                cond = function()
                    return vim.fn.executable("task") == 1
                end,
                color = { fg = "#b9eb81" },
            }

            local timewarrior_timer = {
                function()
                    local handle = io.popen(
                        'if command -v timew >/dev/null 2>&1 && [ "$(timew get dom.active)" = "1" ]; then timew | grep "Total" | awk \'{print "󰔛 " $2}\'; fi 2>/dev/null'
                    )
                    if handle then
                        local result = handle:read("*a")
                        handle:close()
                        result = result:gsub("%s+$", "")
                        return result
                    end
                    return ""
                end,
                cond = function()
                    return vim.fn.executable("timew") == 1
                end,
                color = { fg = "#b9eb81" },
            }

            table.insert(opts.sections.lualine_x, timewarrior_timer)
            table.insert(opts.sections.lualine_x, task_count)
            table.insert(opts.sections.lualine_x, task_context)
        end,
    },
}
