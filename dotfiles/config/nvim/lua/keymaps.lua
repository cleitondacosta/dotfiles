local telescope_api = require 'telescope/builtin'
local nvimtree_api = require 'nvim-tree.api'
local cmp = require 'cmp'
local keymaps = {}
local luasnip = require 'luasnip'
local harpoonMarks = require 'harpoon.mark'
local harpoonUI = require 'harpoon.ui'

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

keymaps.on_gitsigngs_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']h', function() gitsigns.nav_hunk('next') end)
    map('n', '[h', function() gitsigns.nav_hunk('prev') end)
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hS', gitsigns.undo_stage_hunk)
    map('n', '<leader>hu', gitsigns.reset_hunk)
    map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hu', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>gb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>gd', gitsigns.diffthis)
    map('n', '<leader>hc', gitsigns.toggle_deleted)
end

--Trouble
keymaps.trouble = {
    {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
    },
    {
       "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
    },
    {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
    },
    {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
    },
   {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
    },
}

-- vim.keymap.set('n', '<leader>x', utils.toggle_auto_save)

vim.keymap.set('n', '<leader>1', function() harpoonMarks.set_current_at(1) end, {})
vim.keymap.set('n', '<leader>2', function() harpoonMarks.set_current_at(2) end, {})
vim.keymap.set('n', '<leader>3', function() harpoonMarks.set_current_at(3) end, {})
vim.keymap.set('n', '<leader>4', function() harpoonMarks.set_current_at(4) end, {})

vim.keymap.set('n', '<F1>', function() harpoonUI.nav_file(1) end, {})
vim.keymap.set('n', '<F2>', function() harpoonUI.nav_file(2) end, {})
vim.keymap.set('n', '<F3>', function() harpoonUI.nav_file(3) end, {})
vim.keymap.set('n', '<F4>', function() harpoonUI.nav_file(4) end, {})

vim.keymap.set('n', '<leader><leader>m', harpoonMarks.rm_file, {})

return keymaps

