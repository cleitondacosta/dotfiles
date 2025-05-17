return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop"
        },
        ft = {
            "markdown"
        },
        build = 'cd app && yarn',
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        config = function()
            vim.keymap.set('n', '<leader>p', '<cmd>MarkdownPreviewToggle<CR>')
        end
    }
}
