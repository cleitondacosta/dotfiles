return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            local ls = require 'luasnip'

            vim.keymap.set({ "i" }, "<C-S>", function()
                if ls.expand_or_jumpable() then
                    ls.expand()
                end
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-N>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })
        end,
    }
}
