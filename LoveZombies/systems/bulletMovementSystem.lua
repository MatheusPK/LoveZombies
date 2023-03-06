BulletMovementSystem = System({
    COMPONENT.GUN
})

function BulletMovementSystem:process(dt, components)
    local gun = components[COMPONENT.GUN].value
    for _, bullet in pairs(gun.firedBullets) do
        local bulletTransform = bullet:getComponent(COMPONENT.TRANSFORM).value
        bulletTransform.x = bulletTransform.x + (math.cos(bulletTransform.rotation) * bulletTransform.speed * dt)
        bulletTransform.y = bulletTransform.y + (math.sin(bulletTransform.rotation) * bulletTransform.speed * dt)
    end

    for i = #gun.firedBullets, 1, -1 do
        local bullet = gun.firedBullets[i]
        local bulletTransform = bullet:getComponent(COMPONENT.TRANSFORM).value
        if bulletTransform.x < 0 or bulletTransform.x >love.graphics:getWidth() or bulletTransform.y < 0  or bulletTransform.y > love.graphics:getHeight() then
            table.remove(gun.firedBullets, i)
            MyWorld:removeEntity(bullet)
        end
    end

end