return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'angular', 'bash', 'c', 'c_sharp', 'css', 'dockerfile',
                    'fish', 'html', 'javascript', 'json', 'lua', 'markdown',
                    'python', 'query', 'rust', 'scss', 'sql', 'ssh_config',
                    'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 'xml',
                    'yaml', 'yuck'
                },
                sync_install = false,
                ignore_install = {},
                modules = {},
                auto_install = true,
                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                },
            }
        end,
    }
}
