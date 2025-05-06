vim.g.mapleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.encoding = 'UTF-8'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.filetype = 'on'
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.colorcolumn = '80'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 10

vim.api.nvim_create_autocmd('Filetype', {
    pattern = {
        'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript', 'json',
        'ruby', 'css', 'scss', 'tsx', 'typescriptreact', 'yuck'
    },
    command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2'
})
