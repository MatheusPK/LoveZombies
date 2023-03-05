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
end