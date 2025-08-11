local langs = require("languages")
langs.setup()

local lsp = {
    -- Core LSP & tools
    {
        "williamboman/mason.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-lint",
            "stevearc/conform.nvim",
        },
        lazy = false,
        keys = {
            {
                "<leader>fm",
                function()
                    require("conform").format({
                        async = true,
                        lsp_fallback = true,
                    })
                end,
                desc = "ForMat code"
            },
        },

        config = function()
            -- install mason packages
            require("mason").setup()
            local mason_registry = require("mason-registry")
            for _, tool in ipairs(langs.mason_packages) do
                if not mason_registry.is_installed(tool) then
                    mason_registry.get_package(tool):install()
                end
            end


            -- Setup linters
            local lint = require("lint")
            lint.linters_by_ft = langs.linters

            --linting on save
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })

            require("conform").setup({
                formatters_by_ft = langs.formatters,
            })

            vim.lsp.enable(langs.lsp)

            vim.diagnostic.config({
                virtual_text = { current_line = false },
                virtual_lines = {
                    current_line = true,
                },
                underline = true,
                update_in_insert = false,
            })
        end,
    },

    {
        "saghen/blink.cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'enter',

                ['<A-k>'] = { 'select_prev', 'fallback' },
                ['<A-j>'] = { 'select_next', 'fallback' },
                ['<A-CR>'] = { 'accept', 'fallback' },
                ['<CR>'] = false,

                ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
                ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
                ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
                ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
                ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
                ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
                ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
                ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
                ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
                ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
            },

            completion = {
                ghost_text = { enabled = true },
                menu = {
                    auto_show = true,
                    draw = {
                        padding = { 0, 1 },
                        columns = {
                            { 'item_idx' },
                            { 'divider' },
                            { 'kind_icon' },
                            { 'label',    'label_description', gap = 1 },
                        },

                        components = {
                            item_idx = {
                                text = function(ctx)
                                    return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or
                                        tostring(ctx.idx)
                                end,
                                highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
                            },

                            divider = {
                                text = function(_) return '│' end,
                                highlight = 'BlinkCmpDivider'
                            },

                            kind_icon = {
                                text = function(ctx) return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' ' end,
                                highlight = 'BlinkCmpNormal'
                            },
                        },
                    },

                    -- border = 'rounded',
                    winhighlight = 'Normal:BlinkCmpNormal,FloatBorder:BlinkCmpBorder,CursorLine:BlinkCmpSel,Search:None',
                },

                list = {
                    selection = { preselect = true, auto_insert = false }
                },
            },

            documentation = { auto_show = true, auto_show_delay_ms = 500 },

            signature = { enabled = true },

            appearance = {
                nerd_font_variant = 'mono'
            },

            ghost_text = {
                enabled = true
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" },
    }
}

if langs.plugins then
    vim.list_extend(lsp, langs.plugins or {})
end

return lsp
