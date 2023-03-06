local path = string.match(..., "(.*%.).*$")
local utils = require(path .. 'utils')
local class = require(path .. 'class')

World = class('World', {
    entities = {},
    entitiesToAdd = {},
    entitiesToRemove = {},
    entityCount = 0,
    systems = {},
    systemsToAdd = {},
    systemsToRemove = {},
    drawSystems = {},
    archetypes = {},
    ecosystems = {},
    eventQueue = {}
})

-- MARK: - Entities Management
function World:addEntity(entity)
    table.insert(self.entitiesToAdd, entity)
end

function World:removeEntity(entity)
    table.insert(self.entitiesToRemove, entity)
end

function World:manageEntities()
    for _, entityToAdd in ipairs(self.entitiesToAdd) do
        table.insert(self.entities, entityToAdd)
        self.entities[entityToAdd] = #self.entities
        self.entityCount = self.entityCount + 1
        self:manageArchetype(entityToAdd)
        entityToAdd:onAdd()
    end

    for _, entityToRemove in ipairs(self.entitiesToRemove) do
        local lastEntityIndex = #self.entities
        local lastEntity = self.entities[lastEntityIndex]

        utils:swap(self.entities, entityToRemove, lastEntity)
        table.remove(self.entities, lastEntityIndex)
        self.entities[entityToRemove] = nil
        self.entityCount = self.entityCount - 1
        self:unregisterArchetypeForEntity(entityToRemove)
        entityToRemove:onRemove()
    end

    self.entitiesToAdd = {}
    self.entitiesToRemove = {}
end

-- MARK: - Systems Management
function World:addSystem(system)
    system.world = self
    table.insert(self.systemsToAdd, system)
end

function World:removeSystem(system)
    table.insert(self.systemsToRemove, system)
end

function World:manageSystems()
    for _, systemToAdd in ipairs(self.systemsToAdd) do
        local systems = systemToAdd.type == 'drawer' and  self.drawSystems or self.systems
        table.insert(systems, systemToAdd)
        self.systemsToAdd[systemToAdd] = #systems
        self:registerArchetype(systemToAdd.archetype)
        systemToAdd:onAdd()
    end

    for _, systemToRemove in ipairs(self.systemsToRemove) do
        local systems = systemToRemove.isDrawSystem == true and self.drawSystems or self.systems
        local lastSystemIndex = #systems
        local lastSystem = systems[lastSystemIndex]

        utils:swap(systems, systemToRemove, lastSystem)
        table.remove(systems, lastSystemIndex)
        systems[systemToRemove] = nil
        systemToRemove:onRemove()
    end

    self.systemsToAdd = {}
    self.systemsToRemove = {}
end

-- MARK: - Ecosystem Management
function World:addEcosystem(name, ecosystem)
    self.ecosystems[name] = ecosystem
end

function World:getEcosystem(name)
    return self.ecosystems[name]
end

-- MARK: - Events Management
function World:enqueueEvent(event)
    if self.eventQueue[event.type] == nil then self.eventQueue[event.type] = {} end
    table.insert(self.eventQueue[event.type], event)
end

function World:dequeueEvent(eventType)
    local events = self.eventQueue[eventType]
    self.eventQueue[eventType] = nil
    return events
end

-- MARK: - World Life Cycle
function World:load() end

function World:update(dt)
    self:manageSystems()
    self:manageEntities()

    for _, system in ipairs(self.systems) do
        system:update(dt)
    end
end

function World:draw()
    for _, system in ipairs(self.drawSystems) do
        system:update(nil)
    end
end

-- MARK: - Private Functions
function World:manageArchetype(entity)
    table.sort(entity.archetype)
    local entityArchetypePattern = table.concat(entity.archetype, '.*')
    for _, archetype in ipairs(self.archetypes) do
        if utils:matchArchetypePattern(entityArchetypePattern, archetype) then
            local archetypeTable = self.archetypes[archetype]
            table.insert(archetypeTable, entity.components)
        end
    end
end

function World:registerArchetype(archetype)
    table.sort(archetype)
    local archetypePattern = table.concat(archetype, '.*')
    table.insert(self.archetypes, archetypePattern)
    self.archetypes[archetypePattern] = {}
end

function World:unregisterArchetypeForEntity(entity)
    table.sort(entity.archetype)
    local entityArchetypePattern = table.concat(entity.archetype, '.*')
    local archetypeTable = self.archetypes[entityArchetypePattern]
    for i = #archetypeTable, 1, -1 do
        if entity.components == archetypeTable[i] then
            table.remove(archetypeTable, i)
        end
    end
end

return World



