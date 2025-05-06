return {
    {
        'numToStr/Comment.nvim',
        dependencies = {
            {
                'JoosepAlviste/nvim-ts-context-commentstring',
            }
        },
        config = function()
            require('Comment').setup {
                ---@diagnostic disable-next-line: assign-type-mismatch
                post_hook = nil,
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                padding = true,
                sticky = true,
                ---@diagnostic disable-next-line: assign-type-mismatch
                ignore = nil,
                mappings = {
                    basic = true,
                    extra = true,
                },
                toggler = {
                    line = 'gcc',
                    block = 'gbc',
                },
                extra = {
                    above = 'gcO',
                    below = 'gco',
                    eol = 'gcA',
                },
                opleader = {
                    line = 'gc',
                    block = 'gb',
                },
            }
        end
    }
}
