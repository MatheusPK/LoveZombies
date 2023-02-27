MouseRotationSystem = System({
    COMPONENT.TRANSFORM
})

function MouseRotationSystem:process(dt, components)
    local transform = components[COMPONENT.TRANSFORM].value
    transform.rotation = math.atan2(love.mouse.getY() - transform.y, love.mouse.getX() - transform.x)
end