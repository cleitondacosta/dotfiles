local M = {
    is_angular_project = vim.fs.dirname(vim.fs.find({"angular.json"}, { upward = true })[1]) ~= nil,
    openHtml = function() end,
    openStyle = function() end,
    openTs = function() end,
}

if M.is_angular_project then
    -- Open corresponding typescript file
    M.openTs = function()
        local file_extension = vim.fn.expand('%:e')

        if file_extension ~= 'ts' then
            local ts_file = vim.fn.expand('%:r') .. '.ts'
            local ts_file_exists = vim.fn.filereadable(ts_file) == 1

            if ts_file_exists then
                vim.cmd('edit ' .. ts_file)
            end
        end
    end

    -- Open corresponding style file (css/scss)
    M.openStyle = function()
        local file_extension = vim.fn.expand('%:e')

        if file_extension ~= 'css' and file_extension ~= 'scss' then
            local css_file = vim.fn.expand('%:r') .. '.css'
            local scss_file = vim.fn.expand('%:r') .. '.scss'
            local css_file_exists = vim.fn.filereadable(css_file) == 1
            local scss_file_exists = vim.fn.filereadable(scss_file) == 1

            if css_file_exists then
                vim.cmd('edit ' .. css_file)
            elseif scss_file_exists then
                vim.cmd('edit ' .. scss_file)
            end
        end
    end

    -- Open corresponding html file
    M.openHtml = function()
        local file_extension = vim.fn.expand('%:e')

        if file_extension ~= 'html' then
            local html_file = vim.fn.expand('%:r') .. '.html'
            local html_file_exists = vim.fn.filereadable(html_file) == 1

            if html_file_exists then
                vim.cmd('edit ' .. html_file)
            end
        end
    end
end

return M
