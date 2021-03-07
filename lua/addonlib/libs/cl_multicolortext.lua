-- Made originally by https://github.com/EmperorSuper/
-- Edited slightly by me to follow some of the practices
-- I use in the rest of my code

addonlib.multiColorText = function(font, x, y, xall, yall, ...)
    surface.SetFont(font)
    local curX = x
    local curClr = nil
    local allText = ""
    for k, v in pairs(...) do
        if (!IsColor(v)) then continue end
        allText = allText .. tostring(v)
    end
    local textW, textH = surface.GetTextSize(allText)
    if (xall == TEXT_ALIGN_CENTER) then
        curX = x - textW / 2
    elseif (xall == TEXT_ALIGN_RIGHT) then
        curX = x - w
    end
    if (yall == TEXT_ALIGN_CENTER) then
        y = y - textH / 2
    elseif (yall == TEXT_ALIGN_BOTTOM) then
        y = y - textH
    end
    for k, v in pairs{...} do
        if (IsColor(v)) then
            curClr = v
            continue
        elseif (curClr == nil) then
            curClr = addonlib.bclr.white
        end
        local s = tostring(v)
        surface.SetTextColor(curClr)
        surface.SetTextPos(curX, y)
        surface.DrawText(s)
        curX = curX + surface.GetTextSize(s)
    end
end