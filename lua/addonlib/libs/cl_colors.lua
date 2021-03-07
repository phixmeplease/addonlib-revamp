--------------------------------------
-- hDecal                           --
-- Made and maintained by LionDaDev --
-- All rights reserved              --
--------------------------------------

-- This library can be used to cash colors, so new color objects aren't created every frame.

local savedColors = {}

local function getCachedColor(r, g, b)
    for k, v in pairs(savedColors) do
        if (v.r == r and v.g == g and v.b == b) then
            return v
        end
    end

    return false
end

local function saveCachedColor(r, g, b)
    table.insert(savedColors, Color(r, g, b))
end

-- DO NOT USE THIS FUNCTION, I am only keeping
-- this for backwards compatibility
function addonLibColor(r, g, b)
    if (!getCachedColor(r, g, b)) then
        saveCachedColor(r, g, b)
        return getCachedColor(r, g, b)
    else
        return getCachedColor(r, g, b)
    end
end

-- -- This is the V2 Library, it supports alpha
-- local newlib_savedcolors = {}

-- function addonlib.getCachedColor(r, g, b, a)
--     a = a or 255
--     for k, v in pairs(newlib_savedcolors) do
--         if (v.r == r and v.g == g and v.b == b and v.a = a) then
--             return v
--         end
--     end
-- end

-- function addonlib.saveCachedColor(r, g, b, a)
--     a = a or 255
--     table.insert(newlib_savedcolors, Color(r, g, b, a))
-- end

-- function addonlib.color(r, g, b, a)
--     a = a or 255
--     if (!addonlib.getCachedColor(r, g, b, a)) then
--         addonlib.saveCachedColor(r, g, b, a)
--     end

--     return addonlib.getCachedColor(r, g, b, a)
-- end