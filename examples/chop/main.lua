

local kirigami = require("kirigami")


love.window.setMode(500, 500, {
    resizable = true
})


local WHITE = {1,1,1}

local function drawRect(region, color)
    love.graphics.setColor(color or WHITE)
    love.graphics.rectangle("line", region:get())
end

local sin, cos = math.sin, math.cos
local pi = math.pi


function love.draw()
    local W,H = love.graphics.getDimensions()
    local AMP = W/8 -- amplitude of sin/cos
    local screen = kirigami.Region(0,0, W,H)

    local tick = love.timer.getTime()

    local regionA = kirigami.Region(0,0,W/3,H/3)
        :center(screen)
        :offset(AMP * sin(tick), AMP * cos(tick))
    drawRect(regionA)

    local regionB = kirigami.Region(0,0,W/3,H/3)
        :center(screen)
        :offset(AMP * sin(tick+pi), AMP * cos(tick+pi))
    drawRect(regionB)

    local chopped = regionA
        :chop(regionB)
        :pad(10)
    if chopped:exists() then
        drawRect(chopped, {1,0,0})
    end
end



