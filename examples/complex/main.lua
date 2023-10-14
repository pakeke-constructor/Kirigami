
local kirigami = require("kirigami")


love.window.setMode(600, 400, {
    resizable = true
})

local function drawRegion(region)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", region:get())
end


function love.draw()
    local region = kirigami.Region(0,0, love.graphics.getDimensions())
        :pad(24)
    drawRegion(region)

    local left, right = region
        :splitHorizontal(0.6,0.4)

    drawRegion(left)

    --[[
        Example of a region with more complex properties.

        This region should have the following properties:

        - region's height is 40% of the outer height
        - region's width is >= its height
    ]]
end


