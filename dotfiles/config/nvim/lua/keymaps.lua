local fzfFunctions = require('telescope/builtin')

local keymaps = {}

vim.g.mapleader = ' '
vim.g.user_emmet_leader_key = ','

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<CR>', 'i<Enter><esc>k$')

vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')
vim.keymap.set('v', '<tab>', '>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
    desc = 'Go to previous diagnostic message'
})

vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
    desc = 'Go to next diagnostic message'
})

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>ff', function()
    fzfFunctions.find_files({ hidden = true })
end, {})
vim.keymap.set('n', '<leader>fg', fzfFunctions.live_grep, {})
vim.keymap.set('n', '<leader>fh', fzfFunctions.help_tags, {})
vim.keymap.set('n', '<leader>fb', fzfFunctions.buffers, {})
vim.keymap.set('n', '<leader>ft', fzfFunctions.treesitter, {})
vim.keymap.set('n', '<leader>fd', fzfFunctions.diagnostics, {})
vim.keymap.set('n', '<leader>fw', fzfFunctions.grep_string, {})
vim.keymap.set('n', '<leader>et', '<cmd>NvimTreeToggle<CR>', {})

vim.keymap.set('n', '<leader>d', '"_d');
vim.keymap.set('v', '<leader>d', '"_d');

vim.keymap.set('n', '<leader>ot', function()
    vim.fn.jobstart({vim.env.TERM})
end, {})

function keymaps.on_gitsigns_attach(bufnr)
    local gitsigns = package.loaded.gitsigns

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']h', function()
        if vim.wo.diff then return ']h' end

        vim.schedule(function()
            gitsigns.next_hunk()
        end)

        return '<Ignore>'
    end, {expr=true})

    map('n', '[h', function()
        if vim.wo.diff then return '[h' end

        vim.schedule(function()
            gitsigns.prev_hunk()
        end)

        return '<Ignore>'
    end, {expr=true})

    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hS', gitsigns.undo_stage_hunk)
    map('n', '<leader>hu', gitsigns.reset_hunk)
    map('v', '<leader>hs', function()
        gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')}
    end)

    map('v', '<leader>hu', function()
        gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')}
    end)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hc', gitsigns.toggle_deleted)

    map('n', '<leader>gb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>gd', gitsigns.diffthis)
end

function keymaps.on_lsp_attach(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>dt', function()
        if vim.diagnostic.is_disabled() then
            vim.diagnostic.enable()
        else
            vim.diagnostic.disable()
        end

    end, '[D]iagnostics [T]oggle')

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('<leader>fr', fzfFunctions.lsp_references, '[G]oto [R]eferences')
    nmap(
        '<leader>fs',
        fzfFunctions.lsp_document_symbols,
        '[D]ocument [S]ymbols'
    )
    nmap(
        '<leader>fa',
        fzfFunctions.lsp_dynamic_workspace_symbols,
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

return keymaps
