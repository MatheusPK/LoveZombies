Bullet = Entity:extend("Bullet")

function Bullet:factory(transform, gun)
    local bullet = Bullet()

    local transformComponent = Component(COMPONENT.TRANSFORM, {
            x = transform.x,
            y = transform.y,
            w = 10,
            h = 10,
            sx = 0.5,
            sy = 0.5,
            rotation = transform.rotation,
            texture = love.graphics.newImage('assets/bullet.png'),
            speed = gun.speed
    })

    bullet:addComponent(transformComponent)

    return bullet
end
