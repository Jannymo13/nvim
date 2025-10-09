local check_copilot = function()
    local function file_exists(name)
        local f = io.open(name, "r")
        if f ~= nil then
            io.close(f)
            return true
        else
            return false
        end
    end

    local function read_file(name)
        local f = io.open(name, "r")
        if f ~= nil then
            local content = f:read("*all")
            io.close(f)
            return content
        else
            return nil
        end
    end

    local cwd = vim.fn.getcwd()
    local config_file = cwd .. "/.nvimlocal/copilot"
    if not file_exists(config_file) then return false end

    local content = read_file(config_file)

    if content and content:match("true") then
        return true
    end

    return false
end

return {
    "github/copilot.vim",
    lazy = true,
    cmd = { "StartCopilot" },
    -- load plugin if the project has a file .nvimlocal/copilot and the file contains true
    init = function()
        vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
            callback = function()
                if not check_copilot() then
                    -- If Copilot is loaded, disable it
                    if vim.g.copilot_enabled or package.loaded["copilot"] then
                        vim.cmd("Copilot disable")
                    end
                    return
                end
                vim.schedule(function()
                    require("lazy").load({ plugins = { "copilot.vim" } })
                    vim.cmd("Copilot enable")
                end)
            end,
        })
    end,

    config = function()
        -- remap Alt Enter to accepting copilot suggestion
        vim.keymap.set("i", "<A-CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
    end,
}
