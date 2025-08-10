local enabled = {
    "python",
    -- "java",
    "lua",
}

local M = {
    plugins = {},
    mason_packages = {},
    lsp = {},
    linters = {},
    formatters = {},
}

M.setup = function()
    for _, lang in ipairs(enabled) do
        local ok, mod = pcall(require, "languages." .. lang)
        if not ok then goto continue end

        -- Collect plugins
        if mod.plugins then
            vim.list_extend(M.plugins, mod.plugins)
        end

        -- Collect Mason packages
        vim.list_extend(M.mason_packages, mod.mason_packages or {})


        -- Merge linter config
        if mod.linters then
            for ft, list in pairs(mod.linters) do
                M.linters[ft] = vim.tbl_extend("force", M.linters[ft] or {}, list)
            end
        end

        -- Merge formatter config
        if mod.formatters then
            for ft, formatters in pairs(mod.formatters) do
                M.formatters[ft] = vim.list_extend(M.formatters[ft] or {}, formatters)
            end
        end

        -- Configure LSP
        if mod.lsp and mod.lsp.name then
            local server = mod.lsp.name
            local overrides = mod.lsp.config or {}

            -- Load lspconfig defaults
            local lsp_ok, lspconfig = pcall(require, "lspconfig")
            if lsp_ok and lspconfig[server] then
                lspconfig[server].setup({})
            end

            -- Merge overrides
            vim.lsp.config[server] = vim.tbl_deep_extend(
                "force",
                vim.lsp.config[server] or {},
                overrides
            )

            table.insert(M.lsp, server)
        end

        -- Extra setup
        if mod.extra then mod.extra() end

        ::continue::
    end
end

return M
