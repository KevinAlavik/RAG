local logger = require("src.utils.logger")
local game = {}

local x, y, w, h, speed;

function game.setup()
    logger.info("Game Main", "RAG Loaded!");
    x, y, w, h = 20, 20, 60, 60;
    speed = 200;
end

function game.update(dt)
    if love.keyboard.isDown("up") then
        y = y - speed * dt;
    elseif love.keyboard.isDown("down") then
        y = y + speed * dt;
    end
    
    if love.keyboard.isDown("right") then
        x = x + speed * dt;
    elseif love.keyboard.isDown("left") then
        x = x - speed * dt;
    end
end

function game.draw()
    love.graphics.setBackgroundColor(0, 0, 0, 1);
    love.graphics.setColor(0, 0.4, 0.4);
    love.graphics.rectangle("fill", x, y, w, h);   
end

return game
