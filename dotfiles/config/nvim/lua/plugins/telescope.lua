return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function()
            local telescope = require 'telescope'

            telescope.setup {
                defaults = {
                    file_ignore_patterns = { ".git/" },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            }

            telescope.load_extension('fzf')
        end,
    },
}
