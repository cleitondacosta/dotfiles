vim.opt.showcmd = true
vim.opt.laststatus = 2

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.api.nvim_create_autocmd('Filetype', {
  pattern = {
      'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript', 'json',
      'ruby', 'css', 'scss', 'tsx', 'typescriptreact', 'yuck'
  },
  command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2'
})

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.filetype = 'on'

vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.encoding = 'UTF-8'

vim.opt.colorcolumn = '80'
vim.opt.textwidth = 80

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 5

-- Emmet
vim.api.nvim_create_autocmd('Filetype', {
  pattern = {
      'html', 'css', 'javascript.jsx'
  },
  command = 'EmmetInstall'
})

vim.g.user_emmet_leader_key = {
    javascript = {
        extends = 'jsx',
        quote_char = "'",
    }
}

require('tokyonight').setup({  style = "night" })
vim.cmd [[ colorscheme tokyonight ]]
vim.g.airline_powerline_fonts = 1
vim.g.airline_section_z = ''
