love = require('love')
toolbarButtons = {}

local sceneManager = require "sceneManager"
local scene1 = require "map"
local scene2 = require "prout"
local preview = require "preview"
local character = require "character"
local music = require "music"
local game = require "game"


function love.load()
  sceneManager:addScene("scene1", scene1)
  sceneManager:addScene("scene2", scene2)
  sceneManager:addScene("preview",preview)
  sceneManager:addScene("character",character)
  sceneManager:addScene("music",music)
  sceneManager:addScene("game",game)
  sceneManager:setCurrentScene("scene1")

  addButton("Game", 10, 10, 100, 30, function()
    sceneManager:setCurrentScene("game")
  end)

  addButton("Map", 120, 10, 100, 30, function()
    sceneManager:setCurrentScene("scene1")
  end)
  
  addButton("Character", 230, 10, 100, 30, function()
    sceneManager:setCurrentScene("character")
  end)

  addButton("Music", 340, 10, 100, 30, function()
    sceneManager:setCurrentScene("music")
  end)

  addButton("Sprite", 450, 10, 100, 30, function()
    sceneManager:setCurrentScene("scene2")
  end)

  addButton("Preview", 560, 10, 100, 30, function()
    sceneManager:setCurrentScene("preview")
  end)

  addButton("Create", 670, 10, 100, 30, function()
    sceneManager:setCurrentScene("scene2")
  end)


end

function addButton(text, x, y, w, h, onClick)
  table.insert(toolbarButtons, {
    text = text,
    x = x,
    y = y,
    w = w,
    h = h,
    onClick = onClick
  })
end

function deleteButton(toolbarButtons, buttonText)
  for i, button in ipairs(toolbarButtons) do
    if button.text == buttonText then
      table.remove(toolbarButtons, i)
      break
    end
  end
  return toolbarButtons
end


function love.update(dt)
  sceneManager:update(dt)
end

function love.draw()
  sceneManager:draw()
  drawToolbar()
end

function drawToolbar()
  for i, button in ipairs(toolbarButtons) do
    love.graphics.rectangle("line", button.x, button.y, button.w, button.h)
    love.graphics.printf(button.text, button.x, button.y + 8, button.w, "center")
  end
end

function love.mousepressed(x, y, button)
  sceneManager:mousepressed(x,y,button)
  if button == 1 then
    for i, button in ipairs(toolbarButtons) do
      if x >= button.x and x <= button.x + button.w and y >= button.y and y <= button.y + button.h then
        button.onClick()
        break
      end
    end
  end
end