Player = Entity:extend('Player')

function Player:factory()
    local player = Player()

    local transformComponent = Component(COMPONENT.TRANSFORM, {
        x = love.graphics.getWidth()/2,
        y = love.graphics.getHeight()/2,
        w = 30,
        h = 30,
        rotation = math.pi/2,
        texture = love.graphics.newImage('assets/player.png'),
        speed = 150
    })

    local gunComponent = Component(COMPONENT.GUN, {
        name = 'Pistol',
        ammo = 30,
        damage = 10,
        speed = 300,
        fireRate = 5,
        timeSinceLastShoot = 0,
        firedBullets = {}
    })

    local inputComponent = Component(COMPONENT.INPUT, {
        keys = {'w', 'a', 's', 'd', 'space'}
    })

    local rotateComponent = Component(COMPONENT.ROTATE, {
        rotate = true
    })

    player:addComponent(transformComponent)
    player:addComponent(gunComponent)
    player:addComponent(inputComponent)
    player:addComponent(rotateComponent)

    return player
end

