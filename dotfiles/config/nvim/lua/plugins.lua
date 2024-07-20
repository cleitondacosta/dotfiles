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
    { 'elkowar/yuck.vim' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-repeat' },
    { 'wellle/targets.vim' },
    { 'mattn/emmet-vim' },
    { 'ThePrimeagen/harpoon' },
    { 'numToStr/Comment.nvim' },
    { "rebelot/kanagawa.nvim" },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-lualine/lualine.nvim' },
    { 'tpope/vim-fugitive' },
    { 'lewis6991/gitsigns.nvim' },
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
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
    }
}

-- Plugins configurations
require 'kanagawa'.load('dragon')

--- Telescope
local telescope = require 'telescope'

telescope.setup {
    defaults = {
        file_ignore_patterns = { ".git/" },
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
    view = {
        adaptive_size = true,
    }
})

-- Git signs
require('gitsigns').setup {
    on_attach = require('keymaps').on_gitsigngs_attach,
    signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
    },
    signs_staged = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
        follow_files = true
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 500,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
}

-- lualine
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- trouble
require('trouble').setup {
    keys = require('keymaps').trouble
}

-- Comment
require('Comment').setup()

-- Smart Splits (thanks https://github.com/mrjones2014/smart-splits.nvim)
local Direction = { left = 'left', right = 'right', up = 'up', down = 'down' }
local WinPosition = { first = 0, middle = 1, last = 2 }
local resizeApi = {}

local function win_position(direction)
  if direction == Direction.left or direction == Direction.right then
    if vim.fn.winnr() == vim.fn.winnr('h') then return WinPosition.first end
    if vim.fn.winnr() == vim.fn.winnr('l') then return WinPosition.last end
    return WinPosition.middle
  end

  if vim.fn.winnr() == vim.fn.winnr('k') then return WinPosition.first end
  if vim.fn.winnr() == vim.fn.winnr('j') then return WinPosition.last end

  return WinPosition.middle
end

local function resize(direction, amount)
  local isHorizontalResize = direction == Direction.up or direction == Direction.down
  local resizeOperation
  local orientation = ''
  local current_pos = win_position(direction)

  if isHorizontalResize then
      if current_pos == WinPosition.first or current_pos == WinPosition.middle then
          resizeOperation = direction == Direction.up and '-' or '+'
      else
          resizeOperation = direction == Direction.down and '-' or '+'
      end
  else
      orientation = 'vertical '

      if current_pos == WinPosition.first or current_pos == WinPosition.middle then
          resizeOperation = direction == Direction.right and '+' or '-'
      else
          resizeOperation = direction == Direction.left and '+' or '-'
      end
  end

  local resizeCommand = string.format('%sresize %s%s', orientation, resizeOperation, amount)
  vim.cmd(resizeCommand)
end

vim.tbl_map(
    function(direction)
        resizeApi[string.format('resize_%s', direction)] = function()
            resize(direction, 3)
        end
    end,
    {
        Direction.left,
        Direction.right,
        Direction.up,
        Direction.down,
    }
)

vim.keymap.set('n', '<C-h>', resizeApi.resize_left)
vim.keymap.set('n', '<C-j>', resizeApi.resize_down)
vim.keymap.set('n', '<C-k>', resizeApi.resize_up)
vim.keymap.set('n', '<C-l>', resizeApi.resize_right)
