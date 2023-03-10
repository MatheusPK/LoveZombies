RenderSystem = System({
    COMPONENT.TRANSFORM
}, {}, 'drawer')

function RenderSystem:process(dt, entity)
    local transform = entity:getComponent(COMPONENT.TRANSFORM).value
    love.graphics.draw(transform.texture, transform.x, transform.y, transform.rotation, transform.sx, transform.sy, transform.texture:getWidth()/2, transform.texture:getHeight()/2)
end