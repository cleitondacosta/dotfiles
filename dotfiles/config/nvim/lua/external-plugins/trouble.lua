return {
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        config = function()
            require('trouble').setup {
                keys = require('keymaps').trouble
            }
        end,
    }
}
