

# Kirigami: A UI Layout library
API Idea for Regions:

```lua

local region = kirigami.Region(X,Y,W,H)



local left, right = region:splitHorizontal(0.4, 0.6)
-- 40%, 60% split horizontal.
-- (where left, right are regions)

local left_top, left_bot = left:splitVertical(0.5, 0.5)
-- 50%,50% split vertical
-- (left_top, left_bot are regions)


-- we can split more than 2 times:
local left, middle, right = region:splitHorizontal(0.1, 0.8, 0.1)
-- 10%, 80%, 10% horizontal split




local right_regions = right:grid(rows, cols)
for _, r in ipairs(right_regions) do
    -- iterate over grid squares
end


local inner_region = region:pad(10)
-- creates an inner region with 10 units padding around edges

local inner_region = region:padRatio(0.1)
-- creates an inner region with 10% padding around edges


local r2 = region:offset(ox, oy)
-- offset a region. Useful for scrolling / offscreen content


local shrunk = region:shrinkTo(unitW, unitH)
-- shrinks to fit the size

local growed = region:growTo(unitW, unitH)
-- grows to fit the size


local cx = region:centerX(otherRegion)
-- centers `region` horizontally with respect to otherRegion

local cy = region:centerY(otherRegion)
-- centers `region` vertically with respect to otherRegion

local centered = region:center(otherRegion)
-- centers `region` with respect to otherRegion


local intersect = region:intersection(otherRegion)

local union = region:union(otherRegion)



local cx,cy = region:getCenter() -- gets center of region

local x,y,w,h = region:get()


```


