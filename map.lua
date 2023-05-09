local scene = {}
map = {}
current = "Collision"
menuMapButtons = {}
  

function scene:init()
    -- Sub menu
    local maplist = require "mapSub/maplist"
    sceneManager:addScene("maplist", maplist)
    local mapeditor = require "mapSub/mapeditor"
    sceneManager:addScene("mapeditor",mapeditor)
    
    addSubButton(menuMapButtons,"list",10,50,80,30,function()sceneManager:setCurrentScene("maplist")end)
    addSubButton(menuMapButtons,"editor",100,50,80,30,function()sceneManager:setCurrentScene("mapeditor")end)
end

function scene:unload()
end

function scene:update(dt)
end

function scene:draw()
end

function scene:mousepressed(x, y, button)
    if button == 1 then 
        for i, button in ipairs(menuMapButtons) do
            if x >= button.x and x <= button.x + button.w and y >= button.y and y <= button.y + button.h then
              button.onClick()
              break
            end
          end      
    end
end

return scene
