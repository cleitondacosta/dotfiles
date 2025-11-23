return {
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    javascript = { 'prettier' },
                    typescript = { 'prettier' },
                    javascriptreact = { 'prettier' },
                    typescriptreact = { 'prettier' },
                    json = { 'prettier' },
                    css = { 'prettier' },
                    scss = { 'prettier' },
                    less = { 'prettier' },
                    html = { 'prettier' },
                    yaml = { 'prettier' },
                    markdown = { 'prettier' },
                },
                formatters = {
                    prettier = {
                        condition = function()
                            local has_prettier_config = vim
                                .fs
                                .root(0, { '.prettierrc' }) ~= nil

                            return has_prettier_config
                        end,
                    },
                },
                format_on_save = {
                    lsp_fallback = false,
                    timeout_ms = 500,
                },
            })
        end,
    }
}
