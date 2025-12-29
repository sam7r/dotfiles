return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    ft = "markdown",
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false, -- this will be removed in the next major release
        workspaces = {
            {
                name = "vault",
                path = "~/Notes/vault",
            },
        },
        new_notes_location = "notes_subdir",
        notes_subdir = "+Inbox",
        note_id_func = function(title)
            if title ~= nil and title ~= "" then
                -- Use the title for the ID, but make it filename-safe
                local safe_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                return safe_title
            else
                -- Fallback to timestamp for untitled notes
                local suffix = ""
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
                return tostring(os.time()) .. "-" .. suffix
            end
        end,

        note_path_func = function(spec)
            -- Convert Path to string for comparison
            local dir_str = tostring(spec.dir)
            -- Check if this is a daily note by directory
            if dir_str:match("00%-Daily$") then
                -- Daily note - ensure filename is YYYY-MM-DD.md
                local date = vim.fn.strftime("%Y-%m-%d")
                return spec.dir / (date .. ".md")
            else
                -- Regular note - use default behavior
                if spec.title ~= nil and spec.title ~= "" then
                    -- Use title for filename, make it filename-safe
                    local safe_title = spec.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                    return spec.dir / (safe_title .. ".md")
                else
                    -- Default behavior for untitled notes
                    local path = spec.dir / tostring(spec.id)
                    return path:with_suffix(".md")
                end
                local path = spec.dir / tostring(spec.id)
                return path:with_suffix(".md")
            end
        end,

        note_frontmatter_func = function(note)
            -- Add the title as an alias if it exists
            if note.title then
                note:add_alias(note.title)
            end
            -- Optionally, use title as ID if no ID is set
            if note.title and (note.id == nil or note.id == "") then
                local safe_title = note.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                note.id = safe_title
            end
            -- Return the frontmatter
            local out = { id = note.id, aliases = note.aliases, tags = note.tags }

            -- Include any manually added fields
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            return out
        end,
        ---@class obsidian.config.TemplateOpts
        templates = {
            folder = "99-Templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            substitutions = {
                daily_date = function()
                    return vim.fn.strftime("%Y-%m-%d")
                end,
            },

            ---@class obsidian.config.CustomTemplateOpts
            customizations = {},
        },
        ---@class obsidian.config.DailyNotesOpts
        daily_notes = {
            folder = "00-Daily",
            template = "Daily template",
            date_format = "%Y-%m-%d",
            alias_format = nil,
            default_tags = {},
            workdays_only = true,
        },
    },
}
