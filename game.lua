local scene = {}

function scene:init()
    toolbarButtons = deleteButton(toolbarButtons, "Collision")
    toolbarButtons = deleteButton(toolbarButtons, "Spawn")
    toolbarButtons = deleteButton(toolbarButtons, "Dead")
    toolbarButtons = deleteButton(toolbarButtons, "End")
    toolbarButtons = deleteButton(toolbarButtons, "None")
    toolbarButtons = deleteButton(toolbarButtons, "Erase")
    toolbarButtons = deleteButton(toolbarButtons, "Load")
    toolbarButtons = deleteButton(toolbarButtons, "Save")
end

function scene:update(dt)
end

function scene:unload()
end

function scene:draw()
    love.graphics.setColor(1, 0, 0) 
    love.graphics.print("Game", 200, 200)
    love.graphics.setColor(1, 1, 1)
end

function scene:mousepressed(x, y, button)
end

return scene
