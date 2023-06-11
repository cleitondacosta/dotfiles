local fzfFunctions = require('telescope/builtin')

vim.g.mapleader = ','
vim.g.user_emmet_leader_key = ','

vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'G', 'Gzz')
vim.keymap.set('n', '<CR>', 'i<Enter><esc>k$')

vim.keymap.set('n', '<leader>ff', fzfFunctions.find_files, {})
vim.keymap.set('n', '<leader>fg', fzfFunctions.live_grep, {})

