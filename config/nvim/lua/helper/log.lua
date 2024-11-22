---@class Logger:Object
local _Logger = require("plenary.class"):extend()

---@enum LogLevel
local LOG_LEVEL = {
    INFO = "INFO",
    WARN = "WARN",
    ERROR = "ERROR",
}

---@private
function _Logger:_write_file(msg)
    local f = io.open(self.path, "a+")
    if f then
        f:write(msg .. "\n")
        f:close()
    end
end

function _Logger:info(msg)
    -- msg = ("[%s] %s: %s"):format(os.date("%Y-%m-%d_%X"), LOG_LEVEL.INFO, msg)
    self:_write_file(msg)
end

function _Logger:warn(msg)
    -- msg = ("[%s] %s: %s"):format(os.date("%Y-%m-%d_%X"), LOG_LEVEL.WARN, msg)
    self:_write_file(msg)
end

function _Logger:error(msg)
    -- msg = ("[%s] %s: %s"):format(os.date("%Y-%m-%d_%X"), LOG_LEVEL.ERROR, msg)
    self:_write_file(msg)
end

function _Logger:log(msg, level)
    msg = msg or ""
    level = level or self.level

    if level == LOG_LEVEL.INFO then
        self:info(msg)
    elseif level == LOG_LEVEL.WARN then
        self:warn(msg)
    else
        self:error(msg)
    end
end

---@param level LogLevel?
---@param path string?
function _Logger:new(level, path)
    self.level = level or LOG_LEVEL.INFO
    self.path = path or "/tmp/lmodem/lmodem.log"
    local dir = self.path:gsub("%/([%.%w]+)$", "")
    os.execute("mkdir -p " .. dir)
    return self
end

return _Logger
