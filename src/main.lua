local splash_screen = require("src.boot.splash");
local game = require("src.core.game");
local state = "splash";

function love.load()
    splash_screen.load("assets/logo.png", 1);
    game.setup();
end

function love.update(dt)
    if state == "splash" then
        splash_screen.update(dt);
        if splash_screen.isDone() then
            state = "main";
        end
    elseif state == "main" then
        love.graphics.setBackgroundColor(0, 0, 0, 1);
        game.update();
    end
end

function love.draw()
    if state == "splash" then
        splash_screen.draw();
    elseif state == "main" then
        game.draw();
    end
end

