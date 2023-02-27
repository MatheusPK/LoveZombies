local path = string.match(..., "(.*%.).*$")
local class = require(path .. 'class')

System = class('System')

--[[
Creates new system
-> archetype = Set of componentes. ex: {COMPONENTS.TRANSLATION, COMPONENTS.COLLIDER}
-> type      = Type of systems. ex: ('drawer' or 'processor') 'drawer' is a processor thats handles renderization
]]
function System:init(archetype, observablesEvents, type)
    self.archetype = archetype or {}
    self.observablesEvents = observablesEvents or {}
    self.type = type or 'processor'
end

-- MARK: - System Life Cycle
function System:onAdd() end

function System:handleEvent(event, dt) end

function System:update(dt)
    self:processEvents(dt)
    self:processComponents(dt)
end

function System:process(dt, components) end

function System:onRemove() end

-- MARK: - Private Functions

function System:processEvents(dt)
    local events = self:getEvents()
    for _, eventType in pairs(events) do
        for _, event in ipairs(eventType) do self:handleEvent(event, dt) end
    end
end

function System:processComponents(dt)
    local componentSet = self:getComponentSet()
    if componentSet == nil then return end
    for _, components in ipairs(componentSet) do
        self:process(dt, components)
    end
end

function System:getComponentSet()
    local archetypePattern = table.concat(self.archetype, ".*")
    return self.world.archetypes[archetypePattern]
end

function System:getEvents()
    local events = {}
    for _, eventType in ipairs(self.observablesEvents) do
        events[eventType] = self.world:dequeueEvent(eventType)
    end
    return events
end

return System