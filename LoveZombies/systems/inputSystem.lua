InputSystem = System({
    COMPONENT.INPUT
})

function InputSystem:process(dt, components)
    local input = components[COMPONENT.INPUT].value
    local keys = input.keys
    for _, key in ipairs(keys) do
        keys[key] = love.keyboard.isDown(key)
    end
end