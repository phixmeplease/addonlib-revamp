-- Fancy Panel Scale library
-- Scales to full screen size then back down

local panelMeta = FindMetaTable("Panel")

function panelMeta:addonlib_fancyScale(timeUp, timeBack, scaleW, scaleH)
    local scrh, scrw = ScrH(), ScrH()
    self:SetSize(0, 0)
    self:Center()
    self:SizeTo(scrw, scrh, timeUp, 0, -1, function()
        self:SizeTo(scaleW, scaleH, timeBack, 0, -1, function() end)
    end)
    self.onSizeChanged = function(s)
        s:Center()
    end
end

concommand.Add("addonlib_fancyscaledemo", function()
    local frame = vgui.Create("addonlib.frame")
    frame:SetTitle("FancyScale Test")
    frame:addonlib_fancyScale(0.2, 0.2, ScrW() * .75, ScrH() * .75)
    frame:MakePopup()
end)