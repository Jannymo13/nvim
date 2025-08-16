local M = {}

local function write_enabled_langs(enabled_langs)
    local path = vim.fn.stdpath("config") .. "/lua/languages/enabled.lua"
    local lines = { "return {", }
    for _, lang in ipairs(enabled_langs) do
        table.insert(lines, string.format('  "%s",', lang))
    end
    table.insert(lines, "}")
    vim.fn.writefile(lines, path)
end

function M.select_languages()
    local langs_dir = vim.fn.stdpath("config") .. "/lua/languages"

    -- current enabled list (from languages/enabled.lua)
    local ok_enabled, enabled = pcall(require, "languages.enabled")
    if not ok_enabled or type(enabled) ~= "table" then enabled = {} end
    local checked = {}
    for _, lang in ipairs(enabled) do checked[lang] = true end

    -- discover language files
    local all_langs = {}
    local okdir, iter = pcall(vim.fs.dir, langs_dir)
    if okdir then
        for name, type_ in iter do
            if type_ == "file"
                and name:sub(-4) == ".lua"
                and name ~= "init.lua"
                and name ~= "enabled.lua"
                and name ~= "menu.lua"
            then
                table.insert(all_langs, name:sub(1, -5))
            end
        end
    else
        -- fallback to vim.fn.readdir if needed
        for _, name in ipairs(vim.fn.readdir(langs_dir, [[v:val =~ '\.lua$']])) do
            if name ~= "init.lua" and name ~= "enabled.lua" and name ~= "menu.lua" then
                table.insert(all_langs, name:sub(1, -5))
            end
        end
    end
    table.sort(all_langs)

    -- menu items
    local items = {}
    for _, lang in ipairs(all_langs) do
        table.insert(items, { lang = lang, checked = checked[lang] or false })
    end

    local function render_lines()
        local lines = {}
        for _, it in ipairs(items) do
            table.insert(lines, (it.checked and "✔ " or "□ ") .. it.lang)
        end
        return lines
    end

    -- snacks.win UI
    local Win = require("snacks.win")
    local height = math.max(3, #items + 2)
    local width = 32
    local total_rows = vim.o.lines
    local total_cols = vim.o.columns
    local row = math.floor((total_rows - height) / 2)
    local col = math.floor((total_cols - width) / 2)

    local win = Win.new({
        title = "Select Languages",
        height = height,
        width = width,
        row = row,
        col = col,
    })
    vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, render_lines())

    local function toggle_current()
        local row = vim.api.nvim_win_get_cursor(win.win)[1]
        local it = items[row]
        if it then
            it.checked = not it.checked
            vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, render_lines())
        end
    end

    -- Space = toggle, Enter = save & close, q = close w/o saving
    vim.keymap.set("n", "<Space>", toggle_current, { buffer = win.buf })
    vim.keymap.set("n", "<CR>", function()
        local new_enabled = {}
        for _, it in ipairs(items) do
            if it.checked then table.insert(new_enabled, it.lang) end
        end
        write_enabled_langs(new_enabled)
        win:close()
        vim.notify("Saved enabled languages to languages/enabled.lua", vim.log.levels.INFO)
    end)
    vim.keymap.set("n", "q", function() win:close() end)
end

return M
