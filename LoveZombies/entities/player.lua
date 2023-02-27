Player = Entity()

Player:addComponent(
    Component(
        COMPONENT.TRANSFORM, {
            x = love.graphics.getWidth()/2,
            y = love.graphics.getHeight()/2,
            w = 30,
            h = 30,
            rotation = math.pi/2,
            texture = love.graphics.newImage('assets/player.png'),
            speed = 150
        }
    )
)

Player:addComponent(
    Component(
        COMPONENT.INPUT, {
            keys = {'w', 'a', 's', 'd', 'space'}
        }
    )
)