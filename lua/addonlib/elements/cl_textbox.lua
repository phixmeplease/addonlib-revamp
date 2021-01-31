surface.CreateFont("addonlib.textentry", {
    font = "Montserrat Medium",
    size = 20,
    weight = 500,
})

local PANEL = {}

function PANEL:Init()
    self:SetFont("addonlib.textentry")
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, addonlib.theme.textbox.background)
    self:DrawTextEntryText(addonlib.bclr.white, addonlib.theme.textbox.sel, addonlib.bclr.white)
end

vgui.Register("addonlib.textentry", PANEL, "DTextEntry")