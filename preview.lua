local scene = {}
local Player = require('player')
gameplay = {}

function scene:init()
    toolbarButtons = deleteButton(toolbarButtons, "Collision")
    toolbarButtons = deleteButton(toolbarButtons, "Spawn")
    toolbarButtons = deleteButton(toolbarButtons, "Dead")
    toolbarButtons = deleteButton(toolbarButtons, "End")
    toolbarButtons = deleteButton(toolbarButtons, "None")
    toolbarButtons = deleteButton(toolbarButtons, "Erase")
    toolbarButtons = deleteButton(toolbarButtons, "Load")
    toolbarButtons = deleteButton(toolbarButtons, "Save")

    local b = 1
    local mapData = love.filesystem.read("map.txt")
    local argsList = {}
    for arg in string.gmatch(mapData, "[^,]+") do
        print(arg)
        table.insert(argsList, arg)
    end
    gameplay = argsList
    local cell = 0
    for i = 1, 10 do
        for j = 1, 10 do
            cell = cell + 1
            if gameplay[cell] == "Spawn" then
                love.graphics.setColor(0, 0, 1) 
                self.me = Player:new(j *50,i *50)
            end
        end
    end
end

function scene:update(dt)
    self.me:update(dt);
end

function scene:unload()
end


function scene:draw()
    local cell = 0
    local cellSize = 50
    for i = 1, 10 do
        for j = 1, 10 do
            cell = cell + 1
            if gameplay[cell] == "None" then
                love.graphics.setColor(0, 0, 0) 
            elseif gameplay[cell] == "Collision" then
                love.graphics.setColor(0, 1, 0) 
            elseif gameplay[cell] == "Spawn" then
                love.graphics.setColor(0, 0, 1) 
            elseif gameplay[cell] == "End" then
                love.graphics.setColor(1, 1, 0) 
            elseif gameplay[cell] == "Dead" then
                love.graphics.setColor(1, 0, 1) 
            end
            love.graphics.rectangle("fill", (i-1)*cellSize + 100, (j-1)*cellSize, cellSize, cellSize)
            love.graphics.setColor(1, 1, 1)    
            end
        end
        self.me:draw()
end    


function scene:mousepressed(x, y, button)
end

return scene