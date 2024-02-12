

local kirigami = require("kirigami")


love.window.setMode(600, 400, {
    resizable = true
})


local WHITE = {1,1,1,1}


local function drawTextIn(region, text)
    --[[
        dont worry about this function, it just draws 
        text inside the region.
    ]]
    local cx, cy = region:getCenter()
    local font = love.graphics.getFont()
    local fw, fh = font:getWidth(text), font:getHeight()
    local textRegion = kirigami.Region(0,0,fw,fh)
    local scale = textRegion:getScaleToFit(region:pad(0.2))
    -- useful idiom when we want to scale image/text ^^^^
    love.graphics.print(text,cx,cy,0,scale,scale,fw/2,fh/2)
end


local function drawRegion(region)
    love.graphics.setLineWidth(6)
    love.graphics.setColor(WHITE)
    love.graphics.rectangle(fill and "fill" or "line", region:get())
end


local function namedRegion(name, region)
    drawTextIn(region, name)
    drawRegion(region)
end


function love.draw()
    local screen = kirigami.Region(0,0, love.graphics.getDimensions())
    drawRegion(screen)

    local header, main = screen:splitVertical(0.2, 0.8)
    namedRegion("header", header)

    local left, right = main:splitHorizontal(0.4, 0.6)
    namedRegion("left", left)

    local padded_right = right:padPixels(20)
    namedRegion("padded_right", padded_right)
end



