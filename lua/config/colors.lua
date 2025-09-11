local colors = {
    None = "None",
    accent = "#e07321",
    bg = "#1F2430",
    black = "#000000",
    comment = "#6C7A8B",
    constant = "#DF9FFF",
    entity = "#70CFFF",
    error = "#FF6666",
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
    markup = "#e04671",
    operator = "#F29E74",
    panel_bg = "#1C212B",
    panel_border = "#101521",
    panel_shadow = "#161922",
    regexp = "#95E6CB",
    selection_bg = "#274364",
    selection_border = "#232A4C",
    selection_inactive = "#23344B",
    special = "#FFDFB3",
    string = "#44e7a2",
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
        a = { fg = colors.bg, bg = colors.string, gui = 'bold' },
        b = { fg = colors.string, bg = colors.line },
        c = { bg = colors.bg }
    },
    replace = {
        a = { fg = colors.bg, bg = colors.markup, gui = 'bold' },
        b = { fg = colors.markup, bg = colors.line },
        c = { bg = colors.panel_bg }
    },
    inactive = {
        a = { fg = colors.fg, bg = colors.panel_bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.line },
        c = { fg = colors.fg, bg = colors.panel_bg },
    },
    normal = {
        a = { fg = colors.bg, bg = colors.entity, gui = 'bold' },
        b = { fg = colors.entity, bg = colors.line },
        c = { fg = colors.fg, bg = colors.panel_bg },
    },
    insert = {
        a = { fg = colors.bg, bg = colors.accent, gui = 'bold' },
        b = { fg = colors.accent, bg = colors.line },
        c = { bg = colors.panel_bg }
    },
    command = {
        a = { fg = colors.bg, bg = colors.constant, gui = 'bold' },
        b = { fg = colors.constant, bg = colors.line },
        c = { bg = colors.panel_bg }
    },
    terminal = {
        a = { fg = colors.bg, bg = colors.string, gui = 'bold' },
        b = { fg = colors.string, bg = colors.line },
        c = { bg = colors.panel_bg }
    },
}
return colors
