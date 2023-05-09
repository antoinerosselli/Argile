local scene = {}
musicPath = "None"

function scene:init()
    menuButtons = deleteButton(menuButtons, "Collision")
    menuButtons = deleteButton(menuButtons, "Spawn")
    menuButtons = deleteButton(menuButtons, "Dead")
    menuButtons = deleteButton(menuButtons, "End")
    menuButtons = deleteButton(menuButtons, "None")
    menuButtons = deleteButton(menuButtons, "Erase")
    menuButtons = deleteButton(menuButtons, "Load")
    menuButtons = deleteButton(menuButtons, "Save")

    deleteSubMenu(menuMapButtons)
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