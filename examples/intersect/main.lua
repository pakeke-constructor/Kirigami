

local kirigami = require("kirigami")


love.window.setMode(500, 500, {
    resizable = true
})


local WHITE = {1,1,1}

local function drawRect(region, color, fill)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(color or WHITE)
    love.graphics.rectangle(fill and "fill" or "line", region:get())
end

local sin, cos = math.sin, math.cos
local pi = math.pi


function love.draw()
    local W,H = love.graphics.getDimensions()
    local AMP = W/11 -- amplitude of sin/cos
    local screen = kirigami.Region(0,0, W,H)

    local tick = love.timer.getTime()

    local regionA = kirigami.Region(0,0,W/3,H/1.8)
        :center(screen)
        :offset(AMP * sin(tick), AMP * cos(tick))
    drawRect(regionA)

    local regionB = kirigami.Region(0,0,W/3,H/1.8)
        :center(screen)
        :offset(AMP * sin(tick+pi), AMP * cos(tick+pi))
    drawRect(regionB)

    local intersected = regionA
        :intersection(regionB)
        :pad(10)
    if intersected:exists() then
        drawRect(intersected, {1,0,0, 0.5}, true)
        drawRect(intersected, {1,0,0})
    end
end



