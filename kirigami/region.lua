

local Region = {}
local Region_mt = {__index = Region}



local function newRegion(x,y,w,h)
    return setmetatable({
        x = x,
        y = y,
        w = w,
        h = h
    }, Region_mt)
end



local unpack = unpack or table.unpack
-- other lua version compat ^^^



local function average(a, b)
    return (a+b)/2
end


local function getRatios(...)
    -- gets ratios from a vararg-list of numbers
    local ratios = {}
    local sum = 0
    local len = select("#", ...)
    if len <= 0 then
        error("No numbers passed in!")
    end

	for i=1, len do
        -- collect ratios
		local v = select(i, ...)
        assert(type(v) == "number", "Arguments need to be numbers")
        sum = sum + v
        table.insert(ratios, v)
	end

    for i=1, len do
        -- normalize region ratios:
        ratios[i] = ratios[i] / sum
    end
    return ratios
end

function Region:splitVertical(...)
    --[[
        splits a region vertically.
        For example:  

        region:splitVertical(0.1, 0.9)

        This code ^^^ splits a region into two horizontally-lying
        rectangles; one at the top, taking up 10%, and one at bottom taking 90%.
    ]]
    local regions = getRatios(...)
    local accumY = self.y
    for i=1, #regions do
        local ratio = regions[i]
        local y, h = accumY, self.h*ratio
        regions[i] = newRegion(self.x, y, self.w, h)
        accumY = accumY + h
    end
    return unpack(regions)
end


function Region:splitHorizontal(...)
    --[[
        Same as vertical, but in other direction
    ]]
    local regions = getRatios(...)
    -- 0.1  0.8  0.1
    -- |.|........|.|
    local accumX = self.x
    for i=1, #regions do
        local ratio = regions[i]
        local x, w = accumX, self.w*ratio
        regions[i] = newRegion(x, self.y, w, self.h)
        accumX = accumX + w
    end
    return unpack(regions)
end




function Region:grid(rows, cols)
    local w, h = self.w/rows, self.h/cols
    local regions = {}

    for ix=0, rows-1 do
        for iy=0, cols-1 do
            local x = self.x + w*ix
            local y = self.y + h*iy
            local r = newRegion(x,y,w,h)
            table.insert(regions, r)
        end
    end

    return regions
end




-- FUTURE GOAL: Allow for custom regions.
-- local custom_region = region:pad(0.1, 0, 0.1 0)
-- same as above, but padding only on top and bottom.
-- (top, left, bottom, right) 

function Region:padRatio(ratio)
    --[[
        creates an inner region with percentage of padding,
        according to the width/height.
        If width-height is different, we
        pad by the AVERAGE of the width-height values
    ]]
    local v = ratio * average(self.w, self.h)
    return self:pad(v)
end


function Region:pad(v)
    --[[
        creates an inner region with `v` units of padding
    ]]
    local v2 = v*2
    return newRegion(
        self.x + v,
        self.y + v,
        self.w - v2,
        self.h - v2
    )
end



function Region:growTo(unitW, unitH)
    local w = math.max(unitW, self.w)
    local h = math.max(unitH, self.h)
    if w ~= self.w or h ~= self.h then
        return newRegion(self.x,self.y, w,h)
    end
    return self
end


function Region:shrinkTo(unitW, unitH)
    local w = math.min(unitW, self.w)
    local h = math.min(unitH, self.h)
    if w ~= self.w or h ~= self.h then
        return newRegion(self.x,self.y, w,h)
    end
    return self
end


function Region:centerX(other)
    --[[
        centers a region horizontally w.r.t other
    ]]
    local targX, _ = self:getCenter()
    local currX, _ = other:getCenter()
    local dx = currX - targX
    
    return newRegion(self.x+dx, self.y, self.w, self.h)
end


function Region:centerY(other)
    --[[
        centers a region vertically w.r.t other
    ]]
    local _, targY = self:getCenter()
    local _, currY = other:getCenter()
    local dy = currY - targY
    
    return newRegion(self.x, self.y+dy, self.w, self.h)
end


function Region:center(other)
    return self
        :centerX(other)
        :centerY(other)
end


local function isDifferent(self, x,y,w,h)
    -- check for efficiency reasons
    return self.x ~= x
        or self.y ~= y
        or self.w ~= w
        or self.h ~= h
end


local function getEnd(self)
    return self.x+self.w, self.y+self.h
end


function Region:chop(other)
    --[[
        chops a region such that it lies entirely inside `other`
    ]]
    local x,y,endX,endY
    x = math.max(other.x, self.x)
    y = math.max(other.y, self.y)
    endX, endY = getEnd(self)
    local endX2, endY2 = getEnd(other)
    endX = math.min(endX, endX2)
    endY = math.min(endY, endY2)
    local w, h = math.max(0,endX-x), math.max(endY-y,0)

    if isDifferent(self, x,y,w,h) then
        return newRegion(x,y,w,h)
    end
    return self
end


function Region:offset(ox, oy)
    ox = ox or 0
    oy = oy or 0
    if ox ~= 0 or oy ~= 0 then
        return newRegion(self.x+ox, self.y+oy, self.w, self.h)
    end
    return self
end






function Region:exists()
    -- returns true if a region exists
    -- (ie its height and width are > 0)
    return self.w > 0 and self.h > 0 
end



function Region:getCenter()
    -- returns (x,y) position of center of region
    return (self.x + self.w/2), (self.y + self.h/2)
end


function Region:get()
    return self.x,self.y, self.w,self.h
end


return newRegion
