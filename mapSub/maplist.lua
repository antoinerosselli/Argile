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
    
    for i, map in ipairs(self.maps) do
        love.graphics.print(map.name, map.x + map.width + 5, map.y)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("line", map.x, map.y, map.width, map.height)
        love.graphics.line(map.x, map.y, map.x + map.width, map.y + map.height)
        love.graphics.line(map.x + map.width, map.y, map.x, map.y + map.height)
        love.graphics.setColor(1, 1, 1)
    end
end

function scene:mousepressed(x, y, button)
    for i, button in ipairs(menuMapButtons) do
        if x >= button.x and x <= button.x + button.w and y >= button.y and y <= button.y + button.h then
          button.onClick()
          break
        end
      end      
    for i, map in ipairs(self.maps) do
        if x > map.x and x < map.x + map.width and y > map.y and y < map.y + map.height then
            love.filesystem.remove("maps/"..map.name)
            table.remove(self.maps, i)
            break
        end
    end
end

return scene
