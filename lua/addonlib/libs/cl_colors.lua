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

function addonLibColor(r, g, b)
    if (!getCachedColor(r, g, b)) then
        saveCachedColor(r, g, b)
        return getCachedColor(r, g, b)
    else
        return getCachedColor(r, g, b)
    end
end