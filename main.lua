love = require('love')
menuButtons = {}
filename = ""
mapeditor = false

sceneManager = require "sceneManager"
local map = require "map"
local sprite = require "sprite"
local preview = require "preview"
local character = require "character"
local music = require "music"
local game = require "game"


function love.load()
  love.window.setMode(1000, 800)

  sceneManager:addScene("map", map)
  sceneManager:addScene("sprite", sprite)
  sceneManager:addScene("preview",preview)
  sceneManager:addScene("character",character)
  sceneManager:setCurrentScene("map")
  
  addButton("Map", 10, 10, 100, 30, function()
    sceneManager:setCurrentScene("map")
  end)
  
  addButton("Character", 120, 10, 100, 30, function()
    sceneManager:setCurrentScene("character")
  end)

  addButton("Preview", 230, 10, 100, 30, function()
    sceneManager:setCurrentScene("preview")
  end)

end

function mapExists(fl)
  print(fl)
  local fileInfo = love.filesystem.getInfo("maps/" .. filename, "file")
  return fileInfo ~= nil
end


function love.textinput(t)
  if edit == true then
    filename = filename .. t
  end
end

function love.keypressed(key)
  if edit == true then
    if key == "backspace" then
      filename = ""
    end  
  end
end


function addButton(text, x, y, w, h, onClick)
  for _,button in ipairs(menuButtons) do
    if button.text == text then
      return
    end
  end
  
  table.insert(menuButtons, {
    text = text,
    x = x,
    y = y,
    w = w,
    h = h,
    onClick = onClick
  })
end


function addSubButton(list,text, x, y, w, h, onClick)
  for _,button in ipairs(list) do
    if button.text == text then
      return
    end
  end

  table.insert(list, {
    text = text,
    x = x,
    y = y,
    w = w,
    h = h,
    onClick = onClick
  })
end

function deleteSubMenu(list)
    while #list > 0 do
      table.remove(list)
    end
end


function deleteButton(menuButtons, buttonText)
  for i, button in ipairs(menuButtons) do
    if button.text == buttonText then
      table.remove(menuButtons, i)
      break
    end
  end
  return menuButtons
end


function love.update(dt)
  sceneManager:update(dt)
end

function love.draw()
  sceneManager:draw()
  drawToolbar()
end

function drawToolbar()
  for i, button in ipairs(menuButtons) do
    love.graphics.rectangle("line", button.x, button.y, button.w, button.h)
    love.graphics.printf(button.text, button.x, button.y + 8, button.w, "center")
  end
  for i, button in ipairs(menuMapButtons) do
    love.graphics.rectangle("line", button.x, button.y, button.w, button.h)
    love.graphics.printf(button.text, button.x, button.y + 8, button.w, "center")
  end
end


function love.mousepressed(x, y, button)
  sceneManager:mousepressed(x,y,button)
  if button == 1 then
    for i, button in ipairs(menuButtons) do
      if x >= button.x and x <= button.x + button.w and y >= button.y and y <= button.y + button.h then
        button.onClick()
        break
      end
    end
  end
end