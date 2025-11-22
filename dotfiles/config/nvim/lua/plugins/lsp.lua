return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'j-hui/fidget.nvim',
        },
        config = function()
            require('mason').setup()

            vim.diagnostic.config({ virtual_text = false })

            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup()

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    local bufnr = ev.buf

                    require('keymaps').on_lsp_attach(bufnr)

                    vim.o.updatetime = 2500

                    vim.cmd [[ autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float( nil, {focus=false}) ]]
                end,
            })
        end,
    },
}
