local logger = require("src.utils.logger")
local game = {}

local player = {
    x = 100,
    y = 100,
    size = 20,
    speedFactor = 0.5,
    body = {},
    direction = "right"
}

local food = {
    x = 0,
    y = 0,
    size = 20
}

local gridSize = 20
local gameOver = false
local stats = {
    length = 1
}
local moveTimer = 0

function game.setup()
    player.x = 100
    player.y = 100
    player.direction = "right"
    player.body = {}

    food.x = math.random(0, (love.graphics.getWidth() - food.size) / gridSize) * gridSize
    food.y = math.random(0, (love.graphics.getHeight() - food.size) / gridSize) * gridSize

    gameOver = false
    stats.length = 1
    moveTimer = 0
end

function check_collision(a, b)
    return a.x < b.x + b.size and
           a.x + a.size > b.x and
           a.y < b.y + b.size and
           a.y + a.size > b.y
end

function game.update(dt)
    if gameOver then
        if love.keyboard.isDown("r") then
            game.setup()
            return
        elseif love.keyboard.isDown("q") then
            love.event.quit()
        end
        return
    end

    moveTimer = moveTimer + dt
    local moveInterval = 0.1 * (2 - player.speedFactor)

    if moveTimer >= moveInterval then
        moveTimer = moveTimer - moveInterval

        local oldX, oldY = player.x, player.y
        if player.direction == "up" then
            player.y = player.y - player.size
        elseif player.direction == "down" then
            player.y = player.y + player.size
        elseif player.direction == "left" then
            player.x = player.x - player.size
        elseif player.direction == "right" then
            player.x = player.x + player.size
        end

        if player.x < 0 or player.x >= love.graphics.getWidth() or
           player.y < 0 or player.y >= love.graphics.getHeight() then
            gameOver = true
            logger.warning("Game", "Snake collided with the wall.")
            return
        end

        for _, segment in ipairs(player.body) do
            if check_collision(player, segment) then
                gameOver = true
                logger.warning("Game", "Snake collided with itself.")
                return
            end
        end

        if check_collision(player, food) then
            stats.length = stats.length + 1
            player.body[#player.body + 1] = {x = oldX, y = oldY, size = player.size}
            food.x = math.random(0, (love.graphics.getWidth() - food.size) / gridSize) * gridSize
            food.y = math.random(0, (love.graphics.getHeight() - food.size) / gridSize) * gridSize
        end

        table.insert(player.body, 1, {x = oldX, y = oldY, size = player.size})
        if #player.body > stats.length then
            table.remove(player.body)
        end
    end

    if love.keyboard.isDown("up") and player.direction ~= "down" then
        player.direction = "up"
    elseif love.keyboard.isDown("down") and player.direction ~= "up" then
        player.direction = "down"
    elseif love.keyboard.isDown("left") and player.direction ~= "right" then
        player.direction = "left"
    elseif love.keyboard.isDown("right") and player.direction ~= "left" then
        player.direction = "right"
    end
end

function game.draw()
    if gameOver then
        love.graphics.setBackgroundColor(0, 0, 0, 1)
        local logo = love.graphics.newImage("assets/logo.png")
        local logoX = (love.graphics.getWidth() - logo:getWidth()) / 2
        local logoY = (love.graphics.getHeight() - logo:getHeight()) / 2 - 100

        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(logo, logoX, logoY)

        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Game Over", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
        love.graphics.printf(string.format("Length: %d", stats.length), 0, love.graphics.getHeight() / 2 + 50, love.graphics.getWidth(), "center")
        love.graphics.printf("Press R to Restart or Q to Quit", 0, love.graphics.getHeight() / 2 + 100, love.graphics.getWidth(), "center")
    else
        love.graphics.setColor(0.2, 0.2, 0.2)
        for x = 0, love.graphics.getWidth(), gridSize do
            love.graphics.line(x, 0, x, love.graphics.getHeight())
        end
        for y = 0, love.graphics.getHeight(), gridSize do
            love.graphics.line(0, y, love.graphics.getWidth(), y)
        end

        love.graphics.setBackgroundColor(0, 0, 0, 1)

        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)

        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", food.x, food.y, food.size, food.size)

        love.graphics.setColor(0, 0.5, 0)
        for _, segment in ipairs(player.body) do
            love.graphics.rectangle("fill", segment.x, segment.y, segment.size, segment.size)
        end

        love.graphics.setColor(1, 1, 1)
        love.graphics.print(string.format("Length: %d", stats.length), 10, 10)
    end
end

return game
