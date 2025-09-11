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
    -- Load enabled languages fresh (avoid Lua module cache) so menu reflects latest saves
    local enabled = {}
    do
        local enabled_path = vim.fn.stdpath("config") .. "/lua/languages/enabled.lua"
        local ok, mod = pcall(dofile, enabled_path)
        if ok and type(mod) == "table" then
            enabled = mod
        end
    end
    local checked = {}
    for _, lang in ipairs(enabled) do checked[lang] = true end

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
        for _, name in ipairs(vim.fn.readdir(langs_dir, [[v:val =~ '\.lua$']])) do
            if name ~= "init.lua" and name ~= "enabled.lua" and name ~= "menu.lua" then
                table.insert(all_langs, name:sub(1, -5))
            end
        end
    end
    table.sort(all_langs)

    local items = {}
    for _, lang in ipairs(all_langs) do
        table.insert(items, {
            label = (checked[lang] and "✔ " or "□ ") .. lang,
            value = lang,
            checked = checked[lang] or false,
        })
    end
    -- Enhanced floating UI (optimize for fast open)
    local Win = require("snacks.win")

    -- Define controls/header first so we can use header_lines in sizing
    local controls = "[Space] toggle  [Esc/Enter] save  [q] cancel  [a] all  [c] clear"
    local header_lines = {
        " Select the languages you want enabled:",
        " " .. controls,
        "",
    }

    -- compute dynamic width based on content
    local max_len = 0
    for _, it in ipairs(items) do
        local len = #it.value + 4 -- checkbox + space
        if len > max_len then max_len = len end
    end
    for _, hl in ipairs(header_lines) do
        if #hl > max_len then max_len = #hl end
    end
    if #controls > max_len then max_len = #controls end
    local width = math.min(math.max(38, max_len + 2), 80)
    -- height: header lines + items + 1 trailing blank line
    local content_height = #header_lines + #items + 1
    local height = math.max(5, content_height)
    height = math.min(height, vim.o.lines - 4)

    local win = Win.new({
        title = " Language Packs ",
        height = height,
        width = width,
        border = "rounded",
        wo = {
            cursorline = true,
            winhl = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual",
        },
    })

    -- Buffer settings to prevent manual edits
    vim.bo[win.buf].buftype = 'nofile'
    vim.bo[win.buf].bufhidden = 'wipe'
    vim.bo[win.buf].swapfile = false
    vim.bo[win.buf].modifiable = false

    -- header_lines already defined above

    local ns = vim.api.nvim_create_namespace("LangMenuNS")
    local header_len = #header_lines
    local footer_extra = 1 -- single blank line after list
    local function build_line(it)
        return string.format(" %s %s", it.checked and "✔" or "□", it.value)
    end
    local function full_render()
        if not vim.bo[win.buf].modifiable then vim.bo[win.buf].modifiable = true end
        local out = {}
        vim.list_extend(out, header_lines)
    for _, it in ipairs(items) do table.insert(out, build_line(it)) end
    table.insert(out, "")
        vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, out)
        vim.api.nvim_buf_clear_namespace(win.buf, ns, 0, -1)
        for idx, it in ipairs(items) do
            if it.checked then
                local line = header_len + idx - 1
                vim.api.nvim_buf_add_highlight(win.buf, ns, "String", line, 0, -1)
            end
        end
    -- highlight header controls line as Comment
    vim.api.nvim_buf_add_highlight(win.buf, ns, "Comment", 1, 0, -1)
    if vim.bo[win.buf].modifiable then vim.bo[win.buf].modifiable = false end
    end

    local function toggle()
        local cursor = vim.api.nvim_win_get_cursor(win.win)[1]
        local idx = cursor - header_len
        local it = items[idx]
        if not it then return end
        it.checked = not it.checked
        -- Update only that line
        local line_nr = header_len + idx - 1
    if not vim.bo[win.buf].modifiable then vim.bo[win.buf].modifiable = true end
        vim.api.nvim_buf_set_lines(win.buf, line_nr, line_nr + 1, false, { build_line(it) })
        vim.api.nvim_buf_clear_namespace(win.buf, ns, line_nr, line_nr + 1)
        if it.checked then
            vim.api.nvim_buf_add_highlight(win.buf, ns, "String", line_nr, 0, -1)
        end
    if vim.bo[win.buf].modifiable then vim.bo[win.buf].modifiable = false end
        vim.api.nvim_win_set_cursor(win.win, { cursor, 0 })
    end

    local function save_and_close()
        local new_enabled = {}
        for _, it in ipairs(items) do if it.checked then table.insert(new_enabled, it.value) end end
        table.sort(new_enabled)
        write_enabled_langs(new_enabled)
        vim.notify("Saved enabled languages to languages/enabled.lua", vim.log.levels.INFO)
        win:close()
    end

    local function cancel()
        win:close()
        vim.notify("Language selection canceled", vim.log.levels.INFO)
    end

    full_render()

    local function select_all()
    local changed = false
    for _, it in ipairs(items) do if not it.checked then it.checked = true; changed = true end end
    if changed then full_render() end
    end
    local function clear_all()
    local changed = false
    for _, it in ipairs(items) do if it.checked then it.checked = false; changed = true end end
    if changed then full_render() end
    end

    vim.keymap.set("n", "<Space>", toggle, { buffer = win.buf, nowait = true, desc = "Toggle" })
    -- Block entering insert mode
    for _, k in ipairs({ 'i', 'I', 'a', 'A', 'o', 'O', 'cc', 'S', 's' }) do
        vim.keymap.set('n', k, '<NOP>', { buffer = win.buf })
    end
    vim.keymap.set("n", "a", select_all, { buffer = win.buf, desc = "Select all" })
    vim.keymap.set("n", "c", clear_all, { buffer = win.buf, desc = "Clear all" })
    vim.keymap.set("n", "<CR>", save_and_close, { buffer = win.buf, desc = "Save" })
    vim.keymap.set("n", "<Esc>", save_and_close, { buffer = win.buf, desc = "Save" })
    vim.keymap.set("n", "q", cancel, { buffer = win.buf, desc = "Cancel" })
end

return M
