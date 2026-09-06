return {
    'Shatur/neovim-ayu',
    enabled = true, -- disabled: use a small config-based theme instead
    priority = 100,
    config = function()
        local colors = require("config.colors")

        require('ayu').setup({
            mirage = true,
            terminal = true,
            overrides = {
                Cursor = { fg = colors.bg, bg = colors.fg },
                Normal = { bg = colors.None },
                NormalFloat = { bg = colors.None },
                SignColumn = { bg = colors.None },
                NormalNC = { bg = colors.None },
                StatusLine = { bg = colors.panel_bg },
                LineNr = { fg = colors.gutter_normal },
                SnacksDashboardHeader = { fg = colors.None },
                String = { fg = colors.string },
                Constant = { fg = colors.constant },
                ["@property"] = { fg = colors.entity },
                ["@variable.member"] = { fg = colors.entity },
                ["@tag"] = { fg = colors.identifier },
                ["@tag.delimiter"] = { fg = colors.func },
                ["@tag.delimiter.astro"] = { fg = colors.func },
                ["@tag.attribute"] = { fg = colors.fg },


                -- Blink.cmp colors
                BlinkCmpNormal = { bg = colors.None, fg = colors.fg },
                BlinkCmpBorder = { bg = colors.None, fg = colors.ui },
                BlinkCmpSel = { bg = colors.panel_bg, fg = colors.entity },
                BlinkCmpItemIdx = { fg = colors.accent, bold = true },
                BlinkCmpDivider = { fg = colors.guide_normal },
                BlinkCmpKind = { bg = colors.None },
            },
        })

        vim.cmd.colorscheme("ayu")



        -- terminal colors
        vim.g.terminal_color_0 = colors.bg
        vim.g.terminal_color_1 = colors.markup
        vim.g.terminal_color_2 = colors.string
        vim.g.terminal_color_3 = colors.accent
        vim.g.terminal_color_4 = colors.tag
        vim.g.terminal_color_5 = colors.constant
        vim.g.terminal_color_6 = colors.regexp
        vim.g.terminal_color_7 = colors.fg
        vim.g.terminal_color_8 = colors.fg_idle
        vim.g.terminal_color_9 = colors.error
        vim.g.terminal_color_10 = colors.string
        vim.g.terminal_color_11 = colors.accent
        vim.g.terminal_color_12 = colors.tag
        vim.g.terminal_color_13 = colors.constant
        vim.g.terminal_color_14 = colors.regexp
        vim.g.terminal_color_15 = colors.comment
        vim.g.terminal_color_background = colors.bg
        vim.g.terminal_color_foreground = colors.fg
    end
}
