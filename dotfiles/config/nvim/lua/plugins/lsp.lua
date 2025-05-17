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

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            vim.diagnostic.config({ virtual_text = false })

            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup()

            vim.lsp.config('*', {
                capabilities = capabilities,
                on_attach = require('keymaps').on_lsp_attach,
            })
        end,
    },
}
