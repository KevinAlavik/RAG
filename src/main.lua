local splash_screen = require("src.boot.splash")
local game = require("src.core.game")
local logger = require("src.utils.logger")

local state = "splash"
local game_setup = false

function love.load()
    logger.debug("Pre-Game", "Loading splash screen")
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1, 1)
    splash_screen.load("assets/logo.png", 0.75)
    logger.debug("Pre-Game", "Successfully setup game")
end

function love.update(dt)
    if state == "splash" then
        splash_screen.update(dt)
        if splash_screen.isDone() then
            state = "main"
        end
    elseif state == "main" then
        if game_setup == false then
            game.setup()
            game_setup = true
        end
        game.update(dt)
    end
end

function love.draw()
    if state == "splash" then
        splash_screen.draw()
    elseif state == "main" then
        if game_setup == false then
            game.setup()
            game_setup = true
        end
        game.draw()
    end
end

