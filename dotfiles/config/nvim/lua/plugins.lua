local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require "lazy".setup {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        }
    },
    { 'michaeljsmith/vim-indent-object' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-repeat' },
    { 'wellle/targets.vim' },
    { 'mattn/emmet-vim' },
    { 'numToStr/Comment.nvim' },
    { "rebelot/kanagawa.nvim" },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-lualine/lualine.nvim' },
    { 'tpope/vim-fugitive' },
    { 'lewis6991/gitsigns.nvim' },
    { 'rgroli/other.nvim' },
    { 'L3MON4D3/LuaSnip' },
    { 'windwp/nvim-autopairs' },
    { 'windwp/nvim-ts-autotag' },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
        }
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'j-hui/fidget.nvim',
        }
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },
    {
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },
        { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
        {
            "hrsh7th/nvim-cmp",
            opts = function(_, opts)
                opts.sources = opts.sources or {}
                table.insert(opts.sources, {
                    name = "lazydev",
                    group_index = 0,
                })
            end,
        },
    },
}

-- Plugins configurations
require 'kanagawa'.load('dragon')

--- Telescope

local telescope = require 'telescope'

telescope.setup {
    defaults = {
        file_ignore_patterns = { "^.git/" },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}

telescope.load_extension('fzf')

--- Treesitter

require('nvim-treesitter.configs').setup { auto_install = true, }

--- Oil

require("oil").setup()

--- LSP config
require('mason').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.diagnostic.config({virtual_text = false})

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {}
mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = require('keymaps').on_lsp_attach,
        }
    end,
}

---- cmp (auto complete)
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert(require('keymaps').cmp),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

-- nvim tree
require('nvim-tree').setup({
    update_focused_file = { enable = true },
    git = { ignore = false },
})

