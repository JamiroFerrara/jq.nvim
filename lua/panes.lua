local M = {}

local Split = require("nui.split")
local Job = require("plenary.job")
local T = require("./table")

M.setup = function()
end

M.run = function()
    T.Table:init()
end

return M
