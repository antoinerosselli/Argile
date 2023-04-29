local scene = {}
musicPath = "None"

function scene:init()
    toolbarButtons = deleteButton(toolbarButtons, "Collision")
    toolbarButtons = deleteButton(toolbarButtons, "Spawn")
    toolbarButtons = deleteButton(toolbarButtons, "Dead")
    toolbarButtons = deleteButton(toolbarButtons, "End")
    toolbarButtons = deleteButton(toolbarButtons, "None")
    toolbarButtons = deleteButton(toolbarButtons, "Erase")
    toolbarButtons = deleteButton(toolbarButtons, "Load")
    toolbarButtons = deleteButton(toolbarButtons, "Save")

    addButton("add music", 100, 250, 100, 30, function()addMusic()end)
end

function addMusic()
    love.system.openURL("file://" .. love.filesystem.getSaveDirectory())
    local files = love.filesystem.getDirectoryItems("")
    for _, file in ipairs(files) do
        if file:sub(-4) == ".mp3" then
            musicPath = love.filesystem.getRealDirectory(file)
            print("Musique importée: " .. musicPath)
            break
        end
    end

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