local path = string.match(..., "(.*%.).*$")
local class = require(path .. 'class')

Event = class('Event')

function Event:init(type, data)
    self.type = type or nil
    self.data = data or nil
end

return Event