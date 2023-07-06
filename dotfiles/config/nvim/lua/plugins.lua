return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'michaeljsmith/vim-indent-object'
    use 'nvim-lua/plenary.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'wellle/targets.vim'
    use 'mattn/emmet-vim'
    use 'numToStr/Comment.nvim'
    use 'folke/tokyonight.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'
    use 'rgroli/other.nvim'
    use 'L3MON4D3/LuaSnip'
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'ThePrimeagen/harpoon'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
        }
    }

    use {
        'neovim/nvim-lspconfig',
        requires = {
            { 'williamboman/mason.nvim', run = ':MasonUpdate' },
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            'folke/neodev.nvim',
        }
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            }
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        run = function()
            local ts_update = require('nvim-treesitter.install')
            .update({ with_sync = true })

            ts_update()
        end,
    }
end)
