local splash_screen = {}
local alpha = 0
local fade_speed = 0.5
local logo, width, height
local state = "fadein"
local done = false

function splash_screen.load(logo_path, optional_fade_speed)
    logo = love.graphics.newImage(logo_path)
    width, height = love.graphics.getWidth(), love.graphics.getHeight()
    
    if optional_fade_speed then
        fade_speed = optional_fade_speed
    end

    done = false
    alpha = 0
    state = "fadein"
end

function splash_screen.update(dt)
    if state == "fadein" then
        alpha = alpha + (fade_speed * 1.5) * dt
        if alpha >= 1 then
            alpha = 1
            state = "hold"
        end
    elseif state == "hold" then
        state = "fadeout"
    elseif state == "fadeout" then
        alpha = alpha - fade_speed * dt
        if alpha <= 0 then
            alpha = 0
            done = true
        end
    end
end

function splash_screen.draw()
    love.graphics.setColor(1, 1, 1, alpha)
    love.graphics.draw(logo, (width / 2) - (logo:getWidth() / 2), (height / 2) - (logo:getHeight() / 2))
    love.graphics.setColor(1, 1, 1, 1)
end

function splash_screen.isDone()
    return done
end

return splash_screen
