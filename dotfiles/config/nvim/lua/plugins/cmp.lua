return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local cmp = require 'cmp'

            cmp.setup {
                mapping = cmp.mapping.preset.insert(require('keymaps').cmp()),
                sources = {
                    { name = 'nvim_lsp' },
                },
            }
        end
    },
}
