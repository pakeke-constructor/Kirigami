

local kirigami = require("kirigami")


love.window.setMode(600, 400, {
    resizable = true
})


local function drawTextIn(region, text)
    local cx, cy = region:getCenter()
    local font = love.graphics.getFont()
    local fw, fh = font:getWidth(text), font:getHeight()
    local _, scale = region:scaleToFit(fw,fh)
    love.graphics.print(text,cx,cy,0,scale,scale,fw/2,fh/2)
end

local function drawRect(name, region)
    love.graphics.rectangle("line", region:get())
    love.graphics.print()
end


function love.draw()
    local screen = kirigami.Region(0,0, love.graphics.getDimensions())

    local region = screen:pad(12)
    drawRect(region)

    local left, right = region:splitHorizontal(0.4, 0.6)
    drawRect(left)
    drawRect(right)

    local top, middle, bot = left:splitVertical(0.3, 0.4, 0.1)
    drawRect(top)
    drawRect(middle)
    drawRect(bot)

    local padded = right:pad(20)
    drawRect(padded)

    local padtop, padbot = padded:splitVertical(0.2, 0.8)
    drawRect(padbot)
    local cols, rows = 3, 2

    local grids = padtop:pad(8):grid(cols, rows)
    for _, r in ipairs(grids) do
        drawRect(r:pad(3))
    end
end


