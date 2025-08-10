return {
    mason_packages = { "pyright", "black", "flake8", "debugpy" },
    linters = { python = { "flake8" } },
    formatters = { python = { "black" } },

    lsp = {
        name = "pyright",
        config = {
            settings = {
                python = { analysis = { typeCheckingMode = "strict" } }
            }
        }
    },

}
