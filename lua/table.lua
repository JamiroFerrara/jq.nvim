local M = {}
local U = require("./utils")
local Object = require("nui.object")
local Split = require("nui.split")
local Row = require("./rows")

---@class Table
M.Table = Object("Table")

function M.Table:init()
    local file = M.read_json_file("./test.json")
    local res = vim.fn.system("jc ls -l ./")
    Row.TableView:init(file)
end

--- Read a JSON file and decode to Lua table
---@param filepath string
---@return table|nil
function M.read_json_file(filepath)
    local ok, content = pcall(vim.fn.readfile, filepath)
    if not ok then
        vim.notify("Failed to read file: " .. filepath, vim.log.levels.ERROR)
        return nil
    end

    local json_str = table.concat(content, "\n")

    local ok2, result = pcall(vim.fn.json_decode, json_str)
    if not ok2 then
        vim.notify("Failed to decode JSON in file: " .. filepath, vim.log.levels.ERROR)
        return nil
    end

    return result
end

return M
