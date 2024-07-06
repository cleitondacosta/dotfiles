---@type integer | nil
local auto_run_buf_nr = nil

---@type boolean
local is_auto_run_enabled = false

---@type table
local module = {}

vim.api.nvim_create_user_command('EnableAutoSave', function(opts)
    local bufnumber = opts.fargs[1]

    if bufnumber then
        is_auto_run_enabled = true
        auto_run_buf_nr = bufnumber
    end
end, { nargs = 1})

local function write_command_output(_, data)
    if auto_run_buf_nr and data and type(data[1]) == 'string' and string.len(data[1]) > 0 then
        vim.api.nvim_buf_set_option(auto_run_buf_nr, "modifiable", true)
        vim.api.nvim_buf_set_lines(auto_run_buf_nr, 0, -1, false, data)
        vim.api.nvim_buf_set_option(auto_run_buf_nr, "modifiable", false)
        vim.api.nvim_buf_set_option(auto_run_buf_nr, "modified", false)
    end
end

local function run()
    local filePath = vim.api.nvim_buf_get_name(0)

    if not is_auto_run_enabled or not vim.fn.filereadable(filePath) then
        return
    end

    if auto_run_buf_nr == nil then
        vim.cmd [[botright vnew]]
        vim.cmd [[vertical resize 70]]
        auto_run_buf_nr = vim.api.nvim_get_current_buf()
    end

    vim.fn.jobstart({'luajit', filePath}, {
        stdout_buffered = true,
        on_stdout = write_command_output,
        on_stderr = write_command_output,
    })
end

vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('MyAutoRunGroup', { clear = true }),
    pattern = '*.lua',
    callback = run,
})

module.toggle_auto_save = function()
    is_auto_run_enabled = not is_auto_run_enabled

    if not is_auto_run_enabled and auto_run_buf_nr ~= nil then
       vim.api.nvim_buf_delete(auto_run_buf_nr, {})
       auto_run_buf_nr = nil
    end

    run()
end

return module
