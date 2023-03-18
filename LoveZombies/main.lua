ECS = require('libs/ecs')
World, Entity, Component, System, Event, Class = ECS.world, ECS.entity, ECS.component, ECS.system, ECS.event, ECS.class
require('shared.imports')

function love.load()
    MyWorld = World()

    local player = Player:factory()

    MyWorld:addEntity(player)

    MyWorld:addSystem(InputSystem)
    MyWorld:addSystem(InputMovementSystem)
    MyWorld:addSystem(MouseRotationSystem)
    MyWorld:addSystem(RenderSystem)
    MyWorld:addSystem(InputShootSystem)
    MyWorld:addSystem(BulletMovementSystem)
end

function love.update(dt)
    MyWorld:update(dt)
end

function love.draw()
    MyWorld:draw()
end