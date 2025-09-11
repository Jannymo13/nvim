local uv = vim.loop

-- Create .nvimlocal directory in current working directory
local function create_nvimlocal_dir()
    local cwd = vim.fn.getcwd()
    local nvimlocal_path = cwd .. "/.nvimlocal"
    local stat = uv.fs_stat(nvimlocal_path)
    if not stat then
        uv.fs_mkdir(nvimlocal_path, 493) -- 493 = 0o755
    end
    return nvimlocal_path
end


--- Copilot ---
local function create_copilot_file()
    local dir = create_nvimlocal_dir()
    local copilot_file = dir .. "/copilot"
    local fd = uv.fs_open(copilot_file, "w", 420) -- 420 = 0o644
    if fd then
        uv.fs_write(fd, "true\n", -1)
        uv.fs_close(fd)
        vim.notify("Created: " .. copilot_file, vim.log.levels.INFO)
    else
        vim.notify("Failed to create: " .. copilot_file, vim.log.levels.INFO)
    end
end

--- Bind Commands ---
vim.api.nvim_create_user_command("EnableProjectCopilot", create_copilot_file, {})
