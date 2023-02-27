InputMovementSystem = System({
    COMPONENT.INPUT,
    COMPONENT.TRANSFORM
})

function InputMovementSystem:process(dt, components)
    local transform = components[COMPONENT.TRANSFORM].value
    local input = components[COMPONENT.INPUT].value
    local keys = input.keys

    if (keys.w or keys.up) then transform.y = transform.y - transform.speed * dt end
    if (keys.a or keys.left) then transform.x = transform.x - transform.speed * dt end
    if (keys.s or keys.down) then transform.y = transform.y + transform.speed * dt end
    if (keys.d or keys.right) then transform.x = transform.x + transform.speed * dt end
end