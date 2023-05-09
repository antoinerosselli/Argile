local Player = {}

function Player:new(x, y, collision, endPos,dead_list)
    local object = {
        startX = x,
        startY = y,
        x = x,
        y = y,
        size = 30,
        collision = collision,
        endPos = endPos,
        dead_list = dead_list,
        vy = 0, 
    }
    setmetatable(object, { __index = Player })
    return object
end

function Player:update(dt)
    local move_x = self.x
    local move_y = self.y

    local has_ground_collision = false
    for i, v in ipairs(self.collision) do
        if move_x < v[1] + 50 and move_x + self.size > v[1] and move_y + 1 < v[2] + 50 and move_y + self.size + 1 > v[2] then
            has_ground_collision = true
            break
        end
    end

    if not has_ground_collision then
        self.vy = self.vy + 10 * dt
    else
        self.vy = 0
    end

    if love.keyboard.isDown("q") then 
        move_x = self.x - speed * dt
        if self:checkCollision(move_x, self.y) then
            self.x = move_x
        end
    end

    if love.keyboard.isDown("d") then
        move_x = self.x + speed * dt
        if self:checkCollision(move_x, self.y) then
            self.x = move_x
        end
    end

    if love.keyboard.isDown("s") then
        move_y = self.y + speed * dt
        if self:checkCollision(self.x, move_y) then
            self.y = move_y
        end
    elseif love.keyboard.isDown("z") then
        move_y = self.y - jump * dt
        if self:checkCollision(self.x, move_y) then
            self.y = move_y
        end
    end

    move_y = self.y + self.vy * dt

    if self:checkCollision(self.x, move_y) then
        self.y = move_y
    end
end

function Player:checkCollision(move_x, move_y)
    local collided = false

    for i, v in ipairs(self.collision) do
        if move_x < v[1] + 50 and move_x + self.size > v[1] and move_y < v[2] + 50 and move_y + self.size > v[2] then
            collided = true
            break
        end
    end

    if move_x < self.endPos[1] + 50 and move_x + self.size > self.endPos[1] and move_y < self.endPos[2] + 50 and move_y + self.size > self.endPos[2] then
        print("terminate")
    end

    for i, v in ipairs(self.dead_list) do
        if move_x < v[1] + 50 and move_x + self.size > v[1] and move_y < v[2] + 50 and move_y + self.size > v[2] then
            self.x = self.startX
            self.y = self.startY
        end
    end

    return not collided
end

function Player:draw()
    love.graphics.setColor(1, 0, 1) 
    love.graphics.rectangle("fill", self.x, self.y, 30, 30)
    love.graphics.setColor(1, 1, 1) 
end

return Player
