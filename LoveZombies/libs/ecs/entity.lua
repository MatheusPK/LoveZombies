local path = string.match(..., "(.*%.).*$")
local utils = require(path .. 'utils')
local class = require(path .. 'class')

Entity = class('Entity')

function Entity:init()
    self.components = {}
    self.archetype = {}
end

function Entity:onAdd() --[[ implement some logic ]] end
function Entity:onRemove() --[[ implement some logic ]] end

function Entity:addComponent(component)
    self.components[component.type] = component
    self:addType(component.type)
end

function Entity:updateComponent(componentType, newValue)
    self.components[componentType].value = newValue
end

function Entity:removeComponent(componentType)
    self.components[componentType] = nil
    self:removeType(componentType)
end

function Entity:getComponent(componentType)
    return self.components[componentType]
end

-- MARK: - Private Functions
function Entity:addType(componentType)
    table.insert(self.archetype, componentType)
    self.archetype[componentType] = #self.archetype
end

function Entity:removeType(componentType)
    local lastTypeIndex = #self.archetype
    local lastType = self.archetype[lastTypeIndex]
    local typeToRemove = self.archetype[componentType]
    utils:swap(self.archetype, typeToRemove, lastType)
    table.remove(self.archetype, lastTypeIndex)
end

return Entity