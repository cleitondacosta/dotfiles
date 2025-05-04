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

            vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
            vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
            vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
            vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})

            local s = ls.snippet
            local t = ls.text_node
            local d = ls.dynamic_node
            local i = ls.insert_node
            local sn = ls.snippet_node
            local c = ls.choice_node
            local extras = require("luasnip.extras")
            local fmt = require("luasnip.extras.fmt").fmt

            ls.add_snippets('typescriptreact', {
                s('rc', fmt(
                    [[
                        {export}function {componentName}() {{
                          return (
                            <>
                              {componentContent}
                            </>
                          );
                        }}
                    ]],
                    {
                        export = c(1, {
                            t(''),
                            t('export '),
                            t('export default ')
                        }),
                        componentName = i(2, 'ComponentName'),
                        componentContent = i(0),
                    }
                )),
                s('rcp', fmt(
                    [[
                        type {type1}Props = {{
                          {props}
                        }};

                        {exportc}function {componentName}({{ {propsDestructuring} }}: {type2}Props) {{
                          return (
                            <>
                              {componentContent}
                            </>
                          );
                        }}
                    ]],
                    {
                        props = i(1, 'props'),
                        exportc = c(3, {
                            t(''),
                            t('export '),
                            t('export default ')
                        }),
                        propsDestructuring = d(2, function(args)
                            local node = vim.treesitter.get_node()

                            if node == nil then
                                return sn(nil, { t '' })
                            end

                            while node ~= nil do
                                if node:type() == 'type_alias_declaration' then
                                    break
                                end

                                node = node:parent();
                            end

                            if node == nil then
                                return sn(nil, { t '' })
                            end

                            local query = vim.treesitter.query.parse('tsx', [[
                                value: (object_type
                                    (property_signature
                                        name: (property_identifier) @identifier
                                    )
                                 )
                            ]])

                            local identifiers = {}

                            for _, capture in query:iter_captures(node, 0) do
                                local start_row, start_col, _ = capture:start()
                                local end_row, end_col, _ = capture:end_()

                                local text = vim.api.nvim_buf_get_text(
                                    0,
                                    start_row,
                                    start_col,
                                    end_row,
                                    end_col,
                                    {}
                                )

                                table.insert(identifiers, text[1])
                            end

                            if #identifiers == 0 then
                                return sn(nil, { t '' })
                            end

                            return sn(nil, { t(vim.fn.join(identifiers, ', ')) })
                        end, { 1 }),
                        componentName = i(4, 'ComponentName'),
                        type1 = extras.rep(4),
                        type2 = extras.rep(4),
                        componentContent = i(0),
                    }
                )),
            })
        end,
    }
}
