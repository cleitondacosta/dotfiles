local fzfFunctions = require('telescope/builtin')

vim.g.mapleader = ','
vim.g.user_emmet_leader_key = ','

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<CR>', 'i<Enter><esc>k$')

vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', 'ff', fzfFunctions.find_files, {})
vim.keymap.set('n', 'fg', fzfFunctions.live_grep, {})
vim.keymap.set('n', 'fh', fzfFunctions.help_tags, {})
vim.keymap.set('n', 'fb', fzfFunctions.buffers, {})
vim.keymap.set('n', 'ft', fzfFunctions.treesitter, {})
vim.keymap.set('n', 'fk', fzfFunctions.keymaps, {})
