local path = string.match(..., "(.*%.).*$")
local class = require(path .. 'class')

Component = class('Component')

function Component:init(type, value)
    self.type = type or "UNDEFINED"
    self.value = value
end

return Component