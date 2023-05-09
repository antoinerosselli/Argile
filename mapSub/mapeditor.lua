local scene = {}
map = {}
current = "Collision"
menuMapButtons = {}
  

function scene:init()
    edit = true

    addButton("Collision", 10, 100, 100, 30, function()changeCurrent("Collision")end)  
    addButton("Spawn", 10, 150, 100, 30, function()changeCurrent("Spawn")end)
    addButton("End", 10, 200, 100, 30, function()changeCurrent("End")end)
    addButton("Dead", 10, 250, 100, 30, function()changeCurrent("Dead")end)
    addButton("Erase", 10, 300, 100, 30, function()changeCurrent("None")end)

    addButton("Save", 10, 500, 100, 30, function()scene:saveMap()end)
    addButton("Load", 10, 550, 100, 30, function()scene:loadMap()end)

    self.gridSize = 10 
    self.cellSize = love.graphics.getHeight() / (self.gridSize + 2) 
    self.gridOffsetX = (love.graphics.getWidth() - self.cellSize * self.gridSize) / 2
    self.gridOffsetY = (love.graphics.getHeight() - self.cellSize * self.gridSize) / 2 + 30

    self.grid = {}
    for i = 1, self.gridSize do
        self.grid[i] = {}
        for j = 1, self.gridSize do
            self.grid[i][j] = "None"
        end
    end
    if next(map) == nil then
        for i = 1, self.gridSize do
            map[i] = {}
            for j = 1, self.gridSize do
                map[i][j] = "None"
            end
        end    
    else 
        self.grid = map
    end
end
    

function scene:saveMap()
    local data = {}
    local hasSpawn, hasEnd = false, false
    
    for i = 1, 10 do
        for j = 1, 10 do
            data[(i-1)*10 + j] = map[i][j]
            if map[i][j] == "Spawn" then
                hasSpawn = true
            elseif map[i][j] == "End" then
                hasEnd = true
            end
        end
    end
    
    if hasSpawn and hasEnd then
        local tmp = table.concat(data, ",")
        print(tmp)
        
        local dir = "maps"
        if not love.filesystem.getInfo(dir, "directory") then
            love.filesystem.createDirectory(dir)
        end

        love.filesystem.write(dir .. "/" .. filename, tmp)
        local message = string.format("map %s is save", filename)
        love.window.showMessageBox("SUCCES", message)
    else
        local message = string.format("Need one spawn and one end")
        love.window.showMessageBox("WARNING", message)
    end
end


function scene:loadMap()
    local b = 1
    if mapExists(filename) then
        local mapData = love.filesystem.read("maps/" .. filename)
        local argsList = {}
        for arg in string.gmatch(mapData, "[^,]+") do
            table.insert(argsList, arg)
        end
        for i = 1, 10 do
            for j = 1, 10 do
                map[i][j] = argsList[b]
                print(map[i][j])
                b = b + 1
            end
        end
        self.grid = map
    else
        local message = string.format("File %s not find", filename)
        love.window.showMessageBox("WARNING", message)
    end
end


function changeCurrent(newCurrent)
    current = newCurrent
end

function scene:unload()
end


function scene:update(dt)
end

function scene:draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setColor(1, 1, 1)

    -- Afficher le texte "Nom du fichier : "
    love.graphics.print("Map name : ", 10, 450)

    -- Afficher le nom de fichier par défaut dans une zone de texte
    local font = love.graphics.newFont(12)
    local defaultFileText = love.graphics.newText(font, filename)
    love.graphics.draw(defaultFileText, 10, 470)

    for x = 1, self.gridSize do
        for y = 1, self.gridSize do
            if self.grid[x][y] then
                map[x][y] = self.grid[x][y]
                if map[x][y] == "Collision" then
                    love.graphics.setColor(1, 0, 0)
                    love.graphics.rectangle("fill", self.gridOffsetX + (x-1) * self.cellSize, self.gridOffsetY + (y-1) * self.cellSize, self.cellSize, self.cellSize)
                end
                if map[x][y] == "Spawn" then
                    love.graphics.setColor(0, 1, 0)
                    love.graphics.rectangle("fill", self.gridOffsetX + (x-1) * self.cellSize, self.gridOffsetY + (y-1) * self.cellSize, self.cellSize, self.cellSize)
                end
                if map[x][y] == "End" then
                    love.graphics.setColor(0, 1, 1)
                    love.graphics.rectangle("fill", self.gridOffsetX + (x-1) * self.cellSize, self.gridOffsetY + (y-1) * self.cellSize, self.cellSize, self.cellSize)
                end
                if map[x][y] == "Dead" then
                    love.graphics.setColor(0, 0, 1)
                    love.graphics.rectangle("fill", self.gridOffsetX + (x-1) * self.cellSize, self.gridOffsetY + (y-1) * self.cellSize, self.cellSize, self.cellSize)

                end
                if map[x][y] == "None" then
                    love.graphics.rectangle("line", self.gridOffsetX + (x-1) * self.cellSize, self.gridOffsetY + (y-1) * self.cellSize, self.cellSize, self.cellSize)
                    love.graphics.setColor(1, 1, 1)
                end
            end
            love.graphics.setColor(1, 1, 1)
        end
    end

end

function scene:mousepressed(x, y, button)
    if button == 1 then 
        for i, button in ipairs(menuMapButtons) do
            if x >= button.x and x <= button.x + button.w and y >= button.y and y <= button.y + button.h then
              button.onClick()
              break
            end
          end      
        for i = 1, self.gridSize do
            for j = 1, self.gridSize do
                if x > self.gridOffsetX + (i-1) * self.cellSize and x < self.gridOffsetX + i * self.cellSize and
                    y > self.gridOffsetY + (j-1) * self.cellSize and y < self.gridOffsetY + j * self.cellSize then
                        if current == "Collision" then
                            self.grid[i][j] = "Collision"
                        end
                        if current == "Spawn" then
                            self.grid[i][j] = "Spawn"
                        end
                        if current == "End" then
                            self.grid[i][j] = "End"
                        end
                        if current == "Dead" then
                            self.grid[i][j] = "Dead"
                        end
                        if current == "None" then
                            self.grid[i][j] = "None"
                        end
                end
            end
        end
    end
end

return scene
