local logger = require("src.utils.logger")
local game = {}

local x, y, w, h;

function game.setup()
    logger.info("Game Main", "RAG Loaded!")
    x, y, w, h = 20, 20, 60, 20;
end

function game.update()
    w = w + 1;
    h = h + 1;
end

function game.draw()
    love.graphics.setColor(0, 0.4, 0.4);
    love.graphics.rectangle("fill", x, y, w, h);   
end

return game
