local M = {}
local U = require("utils")
M.is_open = false
M.content = ""

M.setup = function()
    vim.api.nvim_create_user_command("JqVisual", M.run_visual, {})
    vim.api.nvim_create_user_command("JqFile", M.run_file, {})
end

M.reset = function()
    vim.api.nvim_buf_set_lines(M.buf_scratch, 0, -1, false, vim.split(M.content, "\n"))
end

M.run_command = function()
    local command = vim.api.nvim_buf_get_lines(M.buf_commands, 0, 1, false)
    if command == nil or command[1] == "" then
        M.reset()
        return
    end

    -- Write JSON content to a temporary file
    local tmpfile = vim.fn.tempname()
    vim.fn.writefile(vim.split(M.content, "\n"), tmpfile)

    local cmd = string.format("jq '%s' %s", command[1], tmpfile)
    print("Running command: " .. cmd)

    local res = vim.fn.system(cmd)
    vim.fn.delete(tmpfile) -- clean up

    vim.api.nvim_buf_set_lines(M.buf_scratch, 0, -1, false, vim.split(res, "\n"))
end

M.run_file = function()
    local buf = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(buf)
    M.filepath = filename

    local line_count = vim.api.nvim_buf_line_count(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, line_count, false)
    local all_text = table.concat(lines, "\n")
    M.content = all_text
    M.run()
end

M.run_visual = function()
    M.content = U.visual_selection()
    M.run()
end

M.run = function()
    if M.is_open then
        -- Close the existing buffers
        vim.api.nvim_buf_delete(M.buf_scratch, { force = true })
        vim.api.nvim_buf_delete(M.buf_commands, { force = true })
        M.is_open = false
        return
    end
    M.is_open = true

    U.split(false)
    M.buf_scratch = U.new_scratch()

    U.split(true)
    M.buf_commands = U.new_scratch()

    U.nmap("<cr>", M.run_command, M.buf_commands)
    U.imap("<cr>", M.run_command, M.buf_commands)
    M.reset()

    -- vim.api.nvim_command("startinsert")

    vim.api.nvim_create_autocmd("WinClosed", {
        buffer = M.buf_commands,
        callback = function()
            if M.is_open then
                M.is_open = false
                pcall(vim.api.nvim_buf_delete, M.buf_scratch, { force = true })
            end
        end,
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
        buffer = M.buf_commands,
        once = true,
        callback = function()
            require("cmp").setup.buffer({
                sources = {
                    {
                        name = "buffer",
                        option = {
                            get_bufnrs = function()
                                return { M.buf_scratch }
                            end,
                        },
                    },
                },
            })
        end,
    })
end

return M
