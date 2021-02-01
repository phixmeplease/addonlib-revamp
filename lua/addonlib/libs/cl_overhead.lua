surface.CreateFont("addonlib.overhead.text", {
    font = "Montserrat Medium",
    size = 60,
    weight = 500,
})

local barh = 15

addonlib.overhead = function(text)
    surface.SetFont("addonlib.overhead.text")
    local tw, th = surface.GetTextSize(text)
    tw = tw + 32
    th = th + 20

    draw.RoundedBoxEx(7, -tw / 2, -th / 2, tw, th, addonlib.theme.overhead.background, true, true, false, false)
    draw.RoundedBoxEx(7, -tw / 2, th / 2, tw, barh, addonlib.theme.overhead.bar, false, false, true, true)

    draw.SimpleText(text, "addonlib.overhead.text", 0, 0, addonlib.bclr.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end