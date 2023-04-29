local scene = {}

function scene:init()
    toolbarButtons = deleteButton(toolbarButtons, "Collision")
    toolbarButtons = deleteButton(toolbarButtons, "Spawn")
    toolbarButtons = deleteButton(toolbarButtons, "Dead")
    toolbarButtons = deleteButton(toolbarButtons, "End")

end

function scene:unload()
end

function scene:update(dt)
end

function scene:draw()
end

function scene:mousepressed(x, y, button)
end


return scene