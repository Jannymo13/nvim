local basic_colors = {
    orange = "#E36837",
    purple = "#515596",
    pink = "#DF9FFF",
    cyan = "#70CFFF",
    red = "#e04671",
    teal = "#4AD9BA",
    green = "#44e7a2"
}

local colors = {
    None = "None",
    -- accent = "#e07321",
    accent = basic_colors.orange,
    bg = "#1F2430",
    black = "#000000",
    comment = "#6C7A8B",
    purple = basic_colors.purple,
    constant = basic_colors.pink,
    entity = basic_colors.cyan,
    -- error = "#FF6666",
    error = basic_colors.red,
    fg = "#CCCAC2",
    fg_idle = "#707A8C",
    func = "#FFD173",
    guide_active = "#444A55",
    guide_normal = "#FFAD66",
    gutter_active = "#757B84",
    gutter_normal = "#4A505A",
    identifier = "#73D0FF",
    keyword = "#FFAD66",
    line = "#171B24",
    lsp_inlay_hint = "#969696",
    lsp_parameter = "#D3B8F9",
    markup = basic_colors.red,
    operator = "#F29E74",
    panel_bg = "#1C212B",
    panel_border = "#101521",
    panel_shadow = "#161922",
    regexp = "#95E6CB",
    selection_bg = "#274364",
    selection_border = "#232A4C",
    selection_inactive = "#23344B",
    special = "#FFDFB3",
    string = basic_colors.green,
    tag = "#5CCFE6",
    ui = "#707A8C",
    vcs_added = "#87D96C",
    vcs_added_bg = "#313D37",
    vcs_modified = "#80BFFF",
    vcs_removed = "#F27983",
    vcs_removed_bg = "#3E373A",
    warning = "#FFA759",
    white = "#FFFFFF",
}

colors.lualine = {
    visual = {
        a = { fg = colors.bg, bg = basic_colors.green, gui = 'bold' },
        b = { fg = basic_colors.green, bg = colors.line },
        c = { bg = colors.bg }
    },
    replace = {
        a = { fg = colors.bg, bg = basic_colors.red, gui = 'bold' },
        b = { fg = basic_colors.red, bg = colors.line },
        c = { bg = colors.bg }
    },
    inactive = {
        a = { fg = colors.fg, bg = colors.panel_bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.line },
        c = { fg = colors.fg, bg = colors.panel_bg },
    },
    normal = {
        a = { fg = colors.bg, bg = basic_colors.cyan, gui = 'bold' },
        b = { fg = basic_colors.cyan, bg = colors.line },
        c = { fg = colors.fg, bg = colors.bg },
    },
    insert = {
        a = { fg = colors.bg, bg = basic_colors.orange, gui = 'bold' },
        b = { fg = basic_colors.orange, bg = colors.line },
        c = { bg = colors.panel_bg }
    },
    command = {
        a = { fg = colors.bg, bg = basic_colors.pink, gui = 'bold' },
        b = { fg = basic_colors.pink, bg = colors.line },
        c = { bg = colors.panel_bg }
    },
    terminal = {
        a = { fg = colors.bg, bg = basic_colors.teal, gui = 'bold' },
        b = { fg = basic_colors.teal, bg = colors.line },
        c = { bg = colors.bg }
    },
}
return colors
