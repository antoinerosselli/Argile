local sceneManager = {
    currentScene = nil,
    scenes = {}
  }
  
  function sceneManager:addScene(name, scene)
    self.scenes[name] = scene
  end
  
  function sceneManager:setCurrentScene(name)
    if self.currentScene then
      self.currentScene:unload()
    end
    self.currentScene = self.scenes[name]
    self.currentScene:init()
  end
  
  function sceneManager:update(dt)
    if self.currentScene then
      self.currentScene:update(dt)
    end
  end
  
  function sceneManager:draw()
    if self.currentScene then
      self.currentScene:draw()
    end
  end
  
  function sceneManager:mousepressed(x, y, button)
    if self.currentScene then
      self.currentScene:mousepressed(x, y, button)
    end
  end
  
  return sceneManager
  