return {
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup({
                formatters = {
                    prettier = {
                        require_cwd = true,
                    },
                    prettierd = {
                        require_cwd = true,
                    },
                    lsp_format = {
                        require_cwd = true,
                    },
                },
                format_on_save = {
                    timeout_ms = 1000,
                    lsp_format = 'fallback',
                },
            })
        end,
    }
}
