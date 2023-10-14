

local kirigami = require("kirigami")


love.window.setMode(600, 400, {
    resizable = true
})


local WHITE = {1,1,1,1}

local function drawRect(region, color, fill)
    love.graphics.setLineWidth(4)
    love.graphics.setColor(color or WHITE)
    love.graphics.rectangle(fill and "fill" or "line", region:get())
end


local function drawTextIn(region, text)
    local cx, cy = region:getCenter()
    local font = love.graphics.getFont()
    local fw, fh = font:getWidth(text), font:getHeight()
    love.graphics.print(text,cx,cy,0,2,2,fw/2,fh/2)
end


local function drawImageIn(region, image)
    love.graphics.setColor(1,1,1)
    local w,h = image:getDimensions()
    local x,y, rw, rh = region:get()
    local sx, sy = rw/w, rh/h
    love.graphics.draw(image,x,y,0,sx,sy)
end


local RATIO = 2.5

local image = love.graphics.newImage("examples/scale/triangle.png")

local count = 1



function love.draw()
    local screen = kirigami.Region(0,0, love.graphics.getDimensions())

    local header, main = screen:splitVertical(0.15, 0.85)
    drawTextIn(header, "Press key for new region, click to delete region")

    local box, render = main, main

    for i=1, count do
        local odd = (i % 2) ~= 0
        if odd then
            render, box = box:splitHorizontal(1, RATIO)
        else
            box, render = box:splitVertical(RATIO, 1)
        end

        drawRect(render, {0,0,0.7})
    end
    
    local imgRegion = kirigami.Region(0,0, image:getDimensions())
        :scaleToFit(box)
        :center(box)
        :padRatio(0.05)

    drawImageIn(imgRegion, image)
    drawRect(imgRegion, {0,1,0})
end


function love.keypressed(_, scancode)
    count = count + 1
end


function love.mousepressed()
    count = math.max(0, count - 1)
end


