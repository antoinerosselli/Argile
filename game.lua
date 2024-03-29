local scene = {}

function scene:init()
    menuButtons = deleteButton(menuButtons, "Collision")
    menuButtons = deleteButton(menuButtons, "Spawn")
    menuButtons = deleteButton(menuButtons, "Dead")
    menuButtons = deleteButton(menuButtons, "End")
    menuButtons = deleteButton(menuButtons, "None")
    menuButtons = deleteButton(menuButtons, "Erase")
    menuButtons = deleteButton(menuButtons, "Load")
    menuButtons = deleteButton(menuButtons, "Save")

    self.maps = {}  
    
    local files = love.filesystem.getDirectoryItems("maps")

    for i, file in ipairs(files) do
        table.insert(self.maps, {name = file, x = 30, y = 100 + (i-1)*20, width = 15, height = 15})
    end
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
