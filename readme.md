
# Kirigami

Kirigami is a rectangle-layout library for lua,
but mainly for use with [love2d.](https://love2d.org)<br/>
It is named after [Japanese kirigami.](https://en.wikipedia.org/wiki/Kirigami)

Kirigami was inspired by [NLay](https://github.com/MikuAuahDark/NPad93#nlay) by [MikuAuahDark](https://github.com/MikuAuahDark/).

It works great with [Inky!](https://github.com/Keyslam/Inky)

----------------

![basic](gifs/basic.gif)

----------------

Code for the above example:
```lua
local kirigami = require("kirigami")

love.window.setMode(600, 400, {
    resizable = true
})


local function drawRect(region)
    love.graphics.rectangle("line", region:get())
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

```

------------------

![looping](gifs/looping.gif)

----------------

# API Reference:
See `API.md` for a basic API reference.<br/>
Or just look through the source code :)

----------------


