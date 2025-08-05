local M = {}
local U = require("./utils")
local Object = require("nui.object")
local Split = require("nui.split")
local Row = require("./rows")

---@class Table
M.Table = Object("Table")

local data = {
    { "ID", "Name", "Age", "Email", "Department", "Role", "Country", "Status", "Joined", "Last Login" },
    { "1", "Alice Smith", "30", "alice@example.com", "Engineering", "Developer", "USA", "Active", "2021-03-01", "2025-08-04" },
    { "2", "Bob Jones", "27", "bob@example.com", "Marketing", "Manager", "Canada", "Inactive", "2020-11-15", "2024-12-22" },
    { "3", "Charlie King", "35", "charlie@example.com", "Design", "Lead", "UK", "Active", "2019-07-23", "2025-07-29" },
    { "4", "Dana White", "29", "dana@example.com", "HR", "Recruiter", "Australia", "Active", "2022-01-05", "2025-08-01" },
    { "5", "Eli Black", "41", "eli@example.com", "Engineering", "Architect", "Germany", "On Leave", "2018-05-18", "2025-06-30" },
    { "6", "Fay Blue", "32", "fay@example.com", "Product", "Owner", "France", "Active", "2021-09-09", "2025-08-03" },
}

function M.Table:init()
    Row.TableView:init(data)
end

return M
