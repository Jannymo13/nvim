-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
         {
            "s1n7ax/nvim-window-picker",
            version = "2.*",
            config = function()
                require("window-picker").setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { "neo-tree", "neo-tree-popup", "notify" },
                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { "terminal", "quickfix" },
                        },
                    },
                })
            end,
        },
      },
      lazy = false, -- neo-tree will lazily load itself
    },
    {
    'Shatur/neovim-ayu',
    lazy = false,
    priority = 100,
    config = function ()
        local colors = require("config.colors")

        require('ayu').setup({
            mirage = true,
            terminal = true,
            overrides = {
                Cursor = { fg = colors.bg, bg = colors.fg },
                Normal = {bg = colors.None},
                NormalFloat = {bg = colors.None},
                SignColumn = { bg = colors.None },
                NormalNC = {bg = colors.None},
                -- StatusLine = {bg = colors.panel_bg},
                StatusLine = {bg = colors.panel_bg},
                LineNr = { fg = colors.guide_normal },
                CursorLine = { bg = colors.line },
                CursorLineNr = { fg = colors.guide_normal, bg = colors.panel_bg},
                SnacksDashboardHeader = {fg = colors.None},
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
}

local opts = {

}
require("lazy").setup(plugins,opts)
