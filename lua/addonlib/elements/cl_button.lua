surface.CreateFont("addonlib.fonts.buttonText", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})

local PANEL = {}

function PANEL:Init()
    self.shadowLerp = 0
    self:SetFont("addonlib.fonts.buttonText")
    self:SetTextColor(addonlib.bclr.white)
end

function PANEL:Paint(w, h)
    if (self:IsHovered()) then
        draw.RoundedBox(0, 0, 0, w, h, addonlib.theme.button.hover)
    else
        draw.RoundedBox(0, 0, 0, w, h, addonlib.theme.button.background)
    end
end

vgui.Register("addonlib.button", PANEL, "DButton")