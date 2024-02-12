
local kirigami = require("kirigami")


love.window.setMode(600, 400, {
    resizable = true
})

local function drawRegion(region)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", region:get())
end


function love.draw()
    love.graphics.setColor(1,1,1)

    local region = kirigami.Region(0,0, love.graphics.getDimensions())
        :pad(0.1)
    drawRegion(region)

    local left, right = region
        :splitHorizontal(0.6,0.4)

    drawRegion(left)

    --[[
        Example of a region with more complex properties.

        This region should have the following properties:
            (in order of precedence)

        - region can never be bigger than outer region
        - region can never be smaller than 40 units
        - region's height is 40% of the outer height
        - region is padded 20 units
    ]]
    local _,_,_,outerHeight = right:get()
    local complex = right
        :pad(0.1)
        :shrinkTo(math.huge, outerHeight * 0.4)
        :center(right)
        :union(kirigami.Region(0,0,40,40):center(right))
        :intersection(right)
        
    love.graphics.setColor(1,0,0)
    drawRegion(complex)
end



