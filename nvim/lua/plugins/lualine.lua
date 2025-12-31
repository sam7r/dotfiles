return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
            -- Add custom components for taskwarrior and timewarrior
            local task_count = {
                function()
                    local cache_key = "task_count"
                    local cache_time = 60000 -- 60 seconds cache
                    local current_time = vim.loop.hrtime() / 1000000
                    if not _G.lualine_cache then
                        _G.lualine_cache = {}
                    end
                    if
                        _G.lualine_cache[cache_key]
                        and (current_time - _G.lualine_cache[cache_key].time) < cache_time
                    then
                        return _G.lualine_cache[cache_key].value
                    end
                    local result = vim.fn.system("task count rc.gc=off rc.verbose=nothing status:pending 2>/dev/null")
                    local count = tonumber(result:match("%d+")) or 0
                    local display = count > 0 and "󰣉 " .. count or ""
                    _G.lualine_cache[cache_key] = { value = display, time = current_time }
                    return display
                end,
                cond = function()
                    return vim.fn.executable("task") == 1
                end,
                color = { fg = "#b9eb81" },
                max_width = 10,
            }

            local task_context = {
                function()
                    local cache_key = "task_context"
                    local cache_time = 60000 -- 60 seconds cache
                    local current_time = vim.loop.hrtime() / 1000000
                    if not _G.lualine_cache then
                        _G.lualine_cache = {}
                    end
                    if
                        _G.lualine_cache[cache_key]
                        and (current_time - _G.lualine_cache[cache_key].time) < cache_time
                    then
                        return _G.lualine_cache[cache_key].value
                    end

                    local result = vim.fn.system("task _get rc.context 2>/dev/null")
                    result = result:gsub("%s+", "")
                    local display = result ~= "" and result or ""

                    _G.lualine_cache[cache_key] = { value = display, time = current_time }
                    return display
                end,
                cond = function()
                    return vim.fn.executable("task") == 1
                end,
                color = { fg = "#b9eb81" },
                max_width = 15,
            }

            local timewarrior_timer = {
                function()
                    local cache_key = "timewarrior_timer"
                    local cache_time = 60000 -- 1 minute cache
                    local current_time = vim.loop.hrtime() / 1000000

                    if not _G.lualine_cache then
                        _G.lualine_cache = {}
                    end

                    if
                        _G.lualine_cache[cache_key]
                        and (current_time - _G.lualine_cache[cache_key].time) < cache_time
                    then
                        return _G.lualine_cache[cache_key].value
                    end

                    local result = vim.fn.system(
                        'if command -v timew >/dev/null 2>&1 && [ "$(timew get dom.active)" = "1" ]; then timew | grep "Total" | awk \'{print $2}\' | awk -F: \'{print "󰔛 " $1":"$2}\'; fi 2>/dev/null'
                    )
                    result = result:gsub("%s+$", "")
                    _G.lualine_cache[cache_key] = { value = result, time = current_time }
                    return result
                end,
                cond = function()
                    return vim.fn.executable("timew") == 1
                end,
                color = { fg = "#b9eb81" },
                max_width = 8,
            }

            table.insert(opts.sections.lualine_x, timewarrior_timer)

            opts.sections = {
                lualine_a = opts.sections.lualine_a,
                lualine_b = opts.sections.lualine_b,
                lualine_c = opts.sections.lualine_c,
                lualine_x = opts.sections.lualine_x,
            }
        end,
    },
}
