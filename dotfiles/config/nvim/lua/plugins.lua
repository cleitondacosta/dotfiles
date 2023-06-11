return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'michaeljsmith/vim-indent-object'
    use 'nvim-lua/plenary.nvim'
    use 'tpope/vim-surround'
    use 'wellle/targets.vim'
    use 'mattn/emmet-vim'
    use 'numToStr/Comment.nvim'
    use 'folke/tokyonight.nvim'
    use 'vim-airline/vim-airline'
    use 'ryanoasis/vim-devicons'
    use 'tpope/vim-fugitive'
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            {'neovim/nvim-lspconfig'},
            {
                'williamboman/mason.nvim',
                run = function() pcall(vim.cmd, 'MasonUpdate') end,
            },
            {'williamboman/mason-lspconfig.nvim'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {
            {'nvim-lua/plenary.nvim'},
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install')
            .update({ with_sync = true })

            ts_update()
        end,
    }
end)
