return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            -- "nvim-mini/mini.icons",  -- if you use standalone mini plugins
        }, ---@module 'render-markdown'
        ---@type render.md.UserConfig
        -- ft = { "markdown" },
        opts = {
            render_modes = true, -- Render in ALL modes
            sign = {
                enabled = false, -- Turn off in the status column
            },
            heading = {
                -- Useful context to have when evaluating values.
                -- | level    | the number of '#' in the heading marker         |
                -- | sections | for each level how deeply nested the heading is |

                -- Turn on / off heading icon & background rendering.
                enabled = true,
                -- Additional modes to render headings.
                render_modes = false,
                -- Turn on / off atx heading rendering.
                atx = true,
                -- Turn on / off setext heading rendering.
                setext = true,
                -- Turn on / off sign column related rendering.
                sign = true,
                -- Replaces '#+' of 'atx_h._marker'.
                -- Output is evaluated depending on the type.
                -- | function | `value(context)`              |
                -- | string[] | `cycle(value, context.level)` |
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                -- Determines how icons fill the available space.
                -- | right   | '#'s are concealed and icon is appended to right side                      |
                -- | inline  | '#'s are concealed and icon is inlined on left side                        |
                -- | overlay | icon is left padded with spaces and inserted on left hiding additional '#' |
                position = "overlay",
                -- Added to the sign column if enabled.
                -- Output is evaluated by `cycle(value, context.level)`.
                signs = { "󰫎 " },
                -- Width of the heading background.
                -- | block | width of the heading text |
                -- | full  | full width of the window  |
                -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
                width = "full",
                -- Amount of margin to add to the left of headings.
                -- Margin available space is computed after accounting for padding.
                -- If a float < 1 is provided it is treated as a percentage of available window space.
                -- Can also be a list of numbers evaluated by `clamp(value, context.level)`.
                left_margin = 0,
                -- Amount of padding to add to the left of headings.
                -- Output is evaluated using the same logic as 'left_margin'.
                left_pad = 0,
                -- Amount of padding to add to the right of headings when width is 'block'.
                -- Output is evaluated using the same logic as 'left_margin'.
                right_pad = 0,
                -- Minimum width to use for headings when width is 'block'.
                -- Can also be a list of integers evaluated by `clamp(value, context.level)`.
                min_width = 0,
                -- Determines if a border is added above and below headings.
                -- Can also be a list of booleans evaluated by `clamp(value, context.level)`.
                border = false,
                -- Always use virtual lines for heading borders instead of attempting to use empty lines.
                border_virtual = false,
                -- Highlight the start of the border using the foreground highlight.
                border_prefix = false,
                -- Used above heading for border.
                above = "▄",
                -- Used below heading for border.
                below = "▀",
                -- Highlight for the heading icon and extends through the entire line.
                -- Output is evaluated by `clamp(value, context.level)`.
                backgrounds = {
                    "RenderMarkdownH1Bg",
                    "RenderMarkdownH2Bg",
                    "RenderMarkdownH3Bg",
                    "RenderMarkdownH4Bg",
                    "RenderMarkdownH5Bg",
                    "RenderMarkdownH6Bg",
                },
                -- Highlight for the heading and sign icons.
                -- Output is evaluated using the same logic as 'backgrounds'.
                foregrounds = {
                    "RenderMarkdownH1",
                    "RenderMarkdownH2",
                    "RenderMarkdownH3",
                    "RenderMarkdownH4",
                    "RenderMarkdownH5",
                    "RenderMarkdownH6",
                },
                -- Define custom heading patterns which allow you to override various properties based on
                -- the contents of a heading.
                -- The key is for healthcheck and to allow users to change its values, value type below.
                -- | pattern    | matched against the heading text @see :h lua-patterns |
                -- | icon       | optional override for the icon                        |
                -- | background | optional override for the background                  |
                -- | foreground | optional override for the foreground                  |
                custom = {},
            },
            checkbox = {
                -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'.
                -- There are two special states for unchecked & checked defined in the markdown grammar.

                -- Turn on / off checkbox state rendering.
                enabled = true,
                -- Additional modes to render checkboxes.
                render_modes = false,
                -- Render the bullet point before the checkbox.
                bullet = false,
                -- Padding to add to the left of checkboxes.
                left_pad = 0,
                -- Padding to add to the right of checkboxes.
                right_pad = 1,
                unchecked = {
                    -- Replaces '[ ]' of 'task_list_marker_unchecked'.
                    icon = "󰄱 ",
                    -- Highlight for the unchecked icon.
                    highlight = "RenderMarkdownUnchecked",
                    -- Highlight for item associated with unchecked checkbox.
                    scope_highlight = nil,
                },
                checked = {
                    -- Replaces '[x]' of 'task_list_marker_checked'.
                    icon = "󰱒 ",
                    -- Highlight for the checked icon.
                    highlight = "RenderMarkdownChecked",
                    -- Highlight for item associated with checked checkbox.
                    scope_highlight = nil,
                },
        -- Define custom checkbox states, more involved, not part of the markdown grammar.
        -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw             | matched against the raw text of a 'shortcut_link'           |
        -- | rendered        | replaces the 'raw' value when rendering                     |
        -- | highlight       | highlight for the 'rendered' icon                           |
        -- | scope_highlight | optional highlight for item associated with custom checkbox |
        -- stylua: ignore
        custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
                -- Priority to assign to scope highlight.
                scope_priority = nil,
            },
        },
    },
}
