return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*", -- use latest release, remove to use latest commit
        ft = "markdown",
        ---@module 'obsidian'
        ---@type obsidian.config
        opts = {
            legacy_commands = false, -- this will be removed in the next major release
            ui = {
                enable = false, -- we have markdown-renderer
            },
            workspaces = {
                {
                    name = "vault",
                    path = "~/Notes/vault",
                },
            },
            callbacks = {
                enter_note = function(note)
                    vim.keymap.set("n", "<Tab>", function()
                        require("obsidian.api").nav_link("next")
                    end, {
                        buffer = true,
                        desc = "Go to next link",
                    })
                    vim.keymap.set("n", "<S-Tab>", function()
                        require("obsidian.api").nav_link("prev")
                    end, {
                        buffer = true,
                        desc = "Go to previous link",
                    })
                end,
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
    },

    -- custom which-key bindings for Obsidian
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                -- Normal mode bindings
                {
                    mode = "n",
                    { "<leader>o", group = "obsidian", icon = { icon = "󰋘 ", color = "purple" } },
                    { "<leader>ow", group = "workspace", icon = { icon = "󰕉 ", color = "purple" } },
                    { "<leader>on", group = "note", icon = { icon = "󰈙 ", color = "purple" } },
                    {
                        "<leader>oo",
                        "<cmd>lua require('obsidian.workspace').set('vault')<cr>",
                        desc = "Open vault",
                        icon = { icon = "󰒔 ", color = "purple" },
                    },
                    {
                        "<leader>owc",
                        "<cmd>Obsidian workspace<cr>",
                        desc = "Change",
                        icon = { icon = "󰡊 ", color = "purple" },
                    },
                    {
                        "<leader>os",
                        "<cmd>Obsidian search<cr>",
                        desc = "Search",
                        icon = { icon = "󰍉 ", color = "purple" },
                    },
                    {
                        "<leader>ot",
                        "<cmd>Obsidian today<cr>",
                        desc = "Today",
                        icon = { icon = "󰃭 ", color = "purple" },
                    },
                    {
                        "<leader>od",
                        "<cmd>Obsidian dailies<cr>",
                        desc = "Dailies",
                        icon = { icon = "󰃲 ", color = "purple" },
                    },
                    {
                        "<leader>oT",
                        "<cmd>Obsidian tags<cr>",
                        desc = "Tags",
                        icon = { icon = " ", color = "purple" },
                    },
                    {
                        "<leader>onn",
                        "<cmd>Obsidian new<cr>",
                        desc = "New note",
                        icon = { icon = "󰏪 ", color = "purple" },
                    },
                    {
                        "<leader>onb",
                        "<cmd>Obsidian backlinks<cr>",
                        desc = "Backlinks",
                        icon = { icon = "󰌹 ", color = "purple" },
                    },
                    {
                        "<leader>onl",
                        "<cmd>Obsidian links<cr>",
                        desc = "Links",
                        icon = { icon = "󰌹 ", color = "purple" },
                    },
                },
                -- Visual mode bindings
                {
                    mode = "x",
                    { "<leader>o", group = "obsidian", icon = { icon = "󰋘 ", color = "purple" } },
                    { "<leader>ov", group = "visual", icon = { icon = "󰘍 ", color = "purple" } },
                    {
                        "<leader>ove",
                        "<cmd>Obsidian extract_note<cr>",
                        desc = "Extract to note",
                        icon = { icon = "󰈆 ", color = "purple" },
                    },
                    {
                        "<leader>ovl",
                        "<cmd>Obsidian link_new<cr>",
                        desc = "Link to new",
                        icon = { icon = " ", color = "purple" },
                    },
                },
            },
            filter = function(mapping)
                -- Check if obsidian workspace is initialized for the session
                local function obsidian_workspace_active()
                    return package.loaded["obsidian"] ~= nil and _G.Obsidian ~= nil
                end

                -- Check if this is an obsidian-related mapping or group
                if
                    mapping.lhs
                    and (mapping.lhs:match("^<leader>o") or mapping.lhs:match("^<Space>o") or mapping.lhs:match("^ o"))
                then
                    -- Always show entry-point group for obsidian
                    if mapping.group and mapping.desc and mapping.desc == "obsidian" then
                        return true
                    end
                    -- Always show open vault mapping
                    if mapping.desc and mapping.desc:match("Open vault") then
                        return true
                    end
                    -- Only show everything else if workspace is initialized
                    return obsidian_workspace_active()
                end

                return true -- Show all other mappings
            end,
        },
    },
}
