local scene = {}
local Player = require('player')
gameplay = {}

--game or map choice
--if game so just run the game and if map so choice a map

function scene:init()

    mapeditor = false

    menuButtons = deleteButton(menuButtons, "Collision")
    menuButtons = deleteButton(menuButtons, "Spawn")
    menuButtons = deleteButton(menuButtons, "Dead")
    menuButtons = deleteButton(menuButtons, "End")
    menuButtons = deleteButton(menuButtons, "None")
    menuButtons = deleteButton(menuButtons, "Erase")
    menuButtons = deleteButton(menuButtons, "Load")
    menuButtons = deleteButton(menuButtons, "Save")

    local spawnX = 0
    local spawnY = 0
    local collision = {}
    local dead_list = {}
    local endPos = {}
    local b = 1
    local mapData = love.filesystem.read("maps/" .. filename)
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
                -- 15 = player size / 2
                spawnY = (j - 1) * 50 + 15
                spawnX = (i - 1) * 50 + 100 + 15
            end
            if gameplay[cell] == "Collision" then
                local x = (i - 1) * 50 + 100
                local y = (j - 1) * 50
                table.insert(collision,{x,y})
            end
            if gameplay[cell] == "End" then
                local end_x = (i - 1) * 50 + 100
                local end_y = (j - 1) * 50
                endPos = {end_x,end_y}
            end
            if gameplay[cell] == "Dead" then
                local x = (i - 1) * 50 + 100
                local y = (j - 1) * 50
                table.insert(dead_list,{x,y})
            end
        end
    end
    print(endPos[1])
    self.me = Player:new(spawnX, spawnY, collision, endPos,dead_list)
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