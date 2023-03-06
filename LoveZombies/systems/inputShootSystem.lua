InputShootSystem = System({
    COMPONENT.INPUT,
    COMPONENT.GUN,
    COMPONENT.TRANSFORM
})

function InputShootSystem:process(dt, entity)
    local input = entity:getComponent(COMPONENT.INPUT).value
    local gun = entity:getComponent(COMPONENT.GUN).value
    local transform = entity:getComponent(COMPONENT.TRANSFORM).value
    local keys = input.keys

    gun.timeSinceLastShoot = gun.timeSinceLastShoot + dt

    if keys.space and 1/gun.fireRate <= gun.timeSinceLastShoot then
        gun.timeSinceLastShoot = 0

        local bullet = Entity()

        bullet:addComponent(
            Component(
                COMPONENT.TRANSFORM, {
                    x = transform.x,
                    y = transform.y,
                    w = 10,
                    h = 10,
                    sx = 0.5,
                    sy = 0.5,
                    rotation = transform.rotation,
                    texture = love.graphics.newImage('assets/bullet.png'),
                    speed = gun.speed
                }
            )
        )

        table.insert(gun.firedBullets, bullet)

        MyWorld:addEntity(bullet)
    end
end