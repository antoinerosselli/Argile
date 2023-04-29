local Player = {}
function Player:new(x, y)
    local object = {
        x = x,
        y = y,
    }
    setmetatable(object, {__index = Player})
    return object
end

function Player:update(dt)
    if love.keyboard.isDown("s") then
        self.y = self.y + speed * dt
    end

    if love.keyboard.isDown("q") then
        self.x = self.x - speed * dt
    end

    if love.keyboard.isDown("d") then
        self.x = self.x + speed * dt
    end

    if love.keyboard.isDown("z") then
        self.y = self.y - speed * dt
    end
end

function Player:draw()
    love.graphics.setColor(1, 0, 1) 
    love.graphics.rectangle("fill", self.x, self.y,50,50)
    love.graphics.setColor(1, 1, 1) 
end



return Player