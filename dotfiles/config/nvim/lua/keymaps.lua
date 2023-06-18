local fzfFunctions = require('telescope/builtin')

vim.g.mapleader = ' '
vim.g.user_emmet_leader_key = ','

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<CR>', 'i<Enter><esc>k$')

vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')
vim.keymap.set('v', '<tab>', '>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

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

vim.keymap.set('n', '<leader>ot', function()
    vim.fn.jobstart({vim.env.TERM})
end, {})

-- More on after/plugin/lsp.lua
