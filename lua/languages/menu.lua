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
    local ok_enabled, enabled = pcall(require, "languages.enabled")
    if not ok_enabled or type(enabled) ~= "table" then enabled = {} end
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

    -- Emulate multi-select using recursive picker calls with Save/Cancel sentinel items
    local selected_set = {}
    for _, it in ipairs(items) do if it.checked then selected_set[it.value] = true end end

    local function build_items()
        local list = {}
        for _, it in ipairs(items) do
            local checked_now = selected_set[it.value] or false
            it.label = (checked_now and "✔ " or "□ ") .. it.value
            it.checked = checked_now
            table.insert(list, it)
        end
        table.insert(list, { value = "__SAVE__", label = "💾 Save & Close" })
        table.insert(list, { value = "__CANCEL__", label = " Cancel" })
        return list
    end

    local function open_picker()
        local picker_items = build_items()
        require("snacks.picker").select(
            picker_items,
            {
                prompt = "Select Languages (toggle entries; choose Save when done)",
                format_item = function(item) return item.label end,
            },
            function(choice)
                if not choice then return end
                if choice.value == "__SAVE__" then
                    local new_enabled = {}
                    for lang, v in pairs(selected_set) do if v then table.insert(new_enabled, lang) end end
                    table.sort(new_enabled)
                    write_enabled_langs(new_enabled)
                    vim.notify("Saved enabled languages to languages/enabled.lua", vim.log.levels.INFO)
                    return
                elseif choice.value == "__CANCEL__" then
                    vim.notify("Language selection canceled", vim.log.levels.INFO)
                    return
                else
                    selected_set[choice.value] = not selected_set[choice.value]
                    open_picker()
                end
            end
        )
    end

    open_picker()
end

return M
