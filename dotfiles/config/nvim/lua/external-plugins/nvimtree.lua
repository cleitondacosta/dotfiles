return {
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('nvim-tree').setup({
                update_focused_file = { enable = true },
                git = { ignore = false },
                view = {
                    adaptive_size = true,
                },
                filters = {
                    custom = {
                        '__pycache__',
                    }
                }
            })
        end,
    },
}
