local scene = {}
speed = 30
jump = 0

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
    love.graphics.print("speed: " .. speed, 100, 100)
    love.graphics.print("+", 200, 100)
    love.graphics.print("-", 240, 100)  

    love.graphics.print("jump: " .. jump, 100, 200)
    love.graphics.print("+", 200, 200)
    love.graphics.print("-", 240, 200)  

    love.graphics.setColor(1, 1, 1) 
end

function scene:mousepressed(x, y, button)
    if button == 1 then 
        if x >= 200 and x <= 220 and y >= 100 and y <= 124 then 
            speed = speed + 1
        elseif x >= 240 and x <= 260 and y >= 100 and y <= 124 then 
            if speed ~= 0 then
                speed = speed - 1
            end
        end
        if x >= 200 and x <= 220 and y >= 200 and y <= 224 then
            jump = jump + 1
        elseif x >= 240 and x <= 260 and y >= 200 and y <= 224 then 
            if jump ~= 0 then
                jump = jump - 1
            end
        end
      end    
end

return scene