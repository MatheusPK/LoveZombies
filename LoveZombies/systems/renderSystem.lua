RenderSystem = System({
    COMPONENT.TRANSFORM
}, {}, 'drawer')

function RenderSystem:process(dt, components)
    local transform = components[COMPONENT.TRANSFORM].value
    love.graphics.draw(transform.texture, transform.x, transform.y, transform.rotation, 1, 1, transform.texture:getWidth()/2, transform.texture:getHeight()/2)
end