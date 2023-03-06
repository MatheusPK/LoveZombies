InputSystem = System({
    COMPONENT.INPUT
})

function InputSystem:process(dt, entity)
    local input = entity:getComponent(COMPONENT.INPUT).value
    local keys = input.keys
    for _, key in ipairs(keys) do
        keys[key] = love.keyboard.isDown(key)
    end
end