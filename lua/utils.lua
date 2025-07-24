local M = {}

---Creates a new scratch buffer.
---@param horizontal boolean
---@return integer
M.new_scratch = function()
    local buf = vim.api.nvim_create_buf(false, true) -- Create a new scratch buffer
    vim.bo[buf].buftype = "nofile" -- set buffer type to nofile
    vim.bo[buf].buflisted = false -- do not list this buffer in the buffer list
    vim.bo[buf].swapfile = false -- disable swap file for this buffer

    vim.api.nvim_set_current_buf(buf) -- switch to the new buffer
    return buf
end

M.split = function(horizontal)
    if horizontal then
        vim.api.nvim_command("split") -- Create a horizontal split
    else
        vim.api.nvim_command("vsplit") -- Create a vertical split
    end
end

M.nmap = function(key, func, buf)
    vim.keymap.set("n", key, func, { buffer = buf, noremap = true, silent = true })
end

M.imap = function(key, func, buf)
    vim.keymap.set("i", key, func, { buffer = buf, noremap = true, silent = true })
end

M.vmap = function(key, func, buf)
    vim.keymap.set("v", key, func, { buffer = buf, noremap = true, silent = true })
end

M.visual_selection = function()
    local mode = vim.api.nvim_get_mode().mode
    local opts = {}
    -- \22 is an escaped version of <c-v>
    if mode == "v" or mode == "V" or mode == "\22" then
        opts.type = mode
    end

    -- Get the selected region
    local region = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), opts)

    -- Concatenate the selected lines into a single string
    local concatenated_string = table.concat(region, "\n") -- Use "\n" to join lines

    return concatenated_string
end

M.put_text = function(buffer, text)
    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, vim.split(text, "\n"))
end

return M
