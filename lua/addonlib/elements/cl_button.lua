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

    self.color = addonlib.theme.button.hover
    self.enablegrad = false
end

function PANEL:EnableGrad(en)
    self.enablegrad = en
end

function PANEL:SetColor(clr)
    self.color = clr
end

function PANEL:Paint(w, h)
    if (self:IsHovered()) then
        draw.RoundedBox(5, 0, 0, w, h, self.color)
        -- if (self.enablegrad) then
        --     surface.SetDrawColor(255, 255, 255, 20)
        --     surface.SetMaterial(addonlib.grad)
        --     surface.DrawTexturedRect(0, 0, w, h)
        -- end
    else
        draw.RoundedBox(5, 0, 0, w, h, addonlib.theme.button.background)
    end
end

vgui.Register("addonlib.button", PANEL, "DButton")