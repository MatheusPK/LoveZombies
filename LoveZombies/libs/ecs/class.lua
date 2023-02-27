local class      = {}
local baseMt     = {}
local _instances = setmetatable({},{__mode = 'k'})
local _classes   = setmetatable({},{__mode = 'k'})

baseMt = {
    __call = function(self, ...) return self:new(...) end,
    __tostring = function(self)
        if self.isInstance then
            return string.format("Instance of '%s' (%s)", self.name or '?', _instances[self])
        else 
            return string.format("Class '%s' (%s)", self.name or '?', _classes[self])
        end
     end
}

local function instantiate(self, ...)
    assert(not self.isInstance, "Wrong method call. Expected class:new(...) or class(...)")
    local instance = {}
    _instances[instance] = tostring(instance)
    instance.__index = nil
    instance.isInstance = true
    if self.init then self.init(instance, ...) end
    return setmetatable(instance, self)
end

function class:new(name, attr)
    local o = attr or {}

    _classes[o] = tostring(o)

    o.name = name or o.name
    o.__index = o

    o.new = instantiate
    o.__call = baseMt.__call
    o.__tostring = baseMt.__tostring
    return setmetatable(o, baseMt)
end

return setmetatable(class, {__call = function(self, ...) return self:new(...) end})