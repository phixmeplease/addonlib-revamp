surface.CreateFont("addonlib.fonts.config.title", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})

local PANEL = {}

function PANEL:Init()
    if (!LocalPlayer():GetUserGroup() == "superadmin") then return end

    self.savep = self:Add("Panel")
    self.savep:Dock(TOP)
    self.savep:SetTall(70)
    self.savep:DockMargin(10, 0, 10, 0)
    self.savep.Paint = function(s, w, h)
        draw.RoundedBoxEx(6, 0, 0, w, h, addonlib.theme.frame.header, false, false, true, true)
    end

    self.save = self.savep:Add("addonlib.button")
    self.save:Dock(FILL)
    self.save:SetColor(Color(75, 200, 75))
    self.save:SetText("Save Config")
    self.save:DockMargin(10, 10, 10, 10)

    self.scroll = self:Add("addonlib.scrollpanel")
    self.scroll:Dock(FILL)

    for k, v in pairs(addonlib.config) do
        local pnl = self.scroll:Add("DPanel")
        pnl:Dock(TOP)
        pnl:SetTall(100)
        pnl:DockMargin(10, 10, 10, 10)
        pnl.Paint = function(s, w, h)
            draw.RoundedBox(6, 0, 0, w, h, addonlib.theme.frame.header)
        end

        pnl.sel = pnl:Add("addonlib.button")
        pnl.sel:Dock(BOTTOM)
        pnl.sel:SetTall(30)
        pnl.sel:SetText("Edit")
        pnl.sel:SetColor(Color(75, 200, 75))
        pnl.sel:DockMargin(10, 0, 10, 10)

        pnl.t = pnl:Add("Panel")
        pnl.t:Dock(FILL)
        pnl.t.Paint = function(s, w, h)
            draw.SimpleText(k, "addonlib.fonts.config.title", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end

vgui.Register("addonlib.configFrame", PANEL, "Panel")