local telescope_api = require 'telescope/builtin'
local nvimtree_api = require 'nvim-tree.api'
local cmp = require 'cmp'
local keymaps = {}
local luasnip = require 'luasnip'
local utils = require('utils')

local config_path = vim.fn.stdpath('config') .. '/init.lua'

vim.g.mapleader = ' '

-- Vanilla
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<CR>', 'i<Enter><esc>k$')

vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')
vim.keymap.set('v', '<tab>', '>')

---- Plugins
vim.keymap.set('n', "<leader>et", function()
    require('nvim-tree.api').tree.toggle()
end)

vim.keymap.set('n', '<leader>n', function()
    nvimtree_api.tree.open()
    nvimtree_api.tree.change_root(vim.fn.stdpath('config'))
    vim.cmd.edit(config_path)
end, {})

vim.keymap.set('n', '<leader>ff', function()
    telescope_api.find_files({ hidden = true })
end, {})
vim.keymap.set('n', '<leader>fg', telescope_api.live_grep, {})
vim.keymap.set('n', '<leader>fh', telescope_api.help_tags, {})
vim.keymap.set('n', '<leader>fb', telescope_api.buffers, {})
vim.keymap.set('n', '<leader>ft', telescope_api.treesitter, {})
vim.keymap.set('n', '<leader>fw', telescope_api.grep_string, {})
vim.keymap.set('n', '<leader>fd', telescope_api.diagnostics, {})
vim.keymap.set('n', '<leader>fc', telescope_api.git_bcommits, {})
vim.keymap.set('n', '<leader>fm', telescope_api.git_status, {})

vim.keymap.set('n', "<leader>o", function() require('oil').open() end)

keymaps.on_lsp_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>td', function()
        if not vim.diagnostic.is_enabled() then
            vim.diagnostic.enable()
        else
            vim.diagnostic.enable(false)
        end

    end, '[D]iagnostics [T]oggle')

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('<leader>fr', telescope_api.lsp_references, '[G]oto [R]eferences')
    nmap(
        '<leader>fs',
        telescope_api.lsp_document_symbols,
        '[D]ocument [S]ymbols'
    )
    nmap(
        '<leader>fa',
        telescope_api.lsp_dynamic_workspace_symbols,
        '[W]orkspace [S]ymbols'
    )

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    vim.api.nvim_buf_create_user_command(
        bufnr,
        'Format',
        function(_)
            vim.lsp.buf.format()
        end,
        { desc = 'Format current buffer with LSP' }
    )

    vim.o.updatetime = 2500

    vim.cmd [[ autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float( nil, {focus=false}) ]]
end

keymaps.cmp = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { 'i', 's' }),
}

vim.keymap.set('n', '<leader>x', utils.toggle_auto_save)

return keymaps
