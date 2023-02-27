local path = ... .. '.'
local _world     = require(path .. 'world')
local _entity    = require(path .. 'entity')
local _component = require(path .. 'component')
local _system    = require(path .. 'system')
local _event     = require(path .. 'event')
local _class     = require(path .. 'class')


local ecs = {
    world     = _world,
    entity    = _entity,
    component = _component,
    system    = _system,
    event     = _event,
    class     = _class
}

return ecs