-- Basic Frame Functions
--     SetTitle(text) - Sets the title of the frame
--     ShowCloseButton(show) - Should I show the close button?

surface.CreateFont("addonlib.fonts.frameTitle", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})

local PANEL = {}

function PANEL:Init()
    self.title = "AddonLib Default Frame"

    self.header = self:Add("DPanel")
    self.header:Dock(TOP)
    self.header:SetTall(30)

    self.header.Paint = function(s, w, h)
        draw.RoundedBoxEx(0, 0, 0, w, h, addonlib.theme.frame.header, true, true, false, false)
        draw.SimpleText(self.title, "addonlib.fonts.frameTitle", 5, h / 2, addonlib.bclr.white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.header.cbtn = self.header:Add("DButton")
    self.header.cbtn:Dock(RIGHT)
    self.header.cbtn:SetWide(self.header:GetTall())
    self.header.cbtn:SetText("")
    self.header.cbtn.margin = 10
    self.header.cbtn.marginH = 12

    self.header.cbtn.lerpR = 255
    self.header.cbtn.lerpG = 255
    self.header.cbtn.lerpB = 255

    self.header.cbtn.margin = 5

    -- https://i.imgur.com/qEIG9YT.png

    self.header.cbtn.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.lerpR = Lerp(7 * FrameTime(), s.lerpR, addonlib.theme.frame.close.r)
            s.lerpG = Lerp(7 * FrameTime(), s.lerpG, addonlib.theme.frame.close.g)
            s.lerpB = Lerp(7 * FrameTime(), s.lerpB, addonlib.theme.frame.close.b)
        else
            s.lerpR = Lerp(7 * FrameTime(), s.lerpR, 255)
            s.lerpG = Lerp(7 * FrameTime(), s.lerpG, 255)
            s.lerpB = Lerp(7 * FrameTime(), s.lerpB, 255)
        end
        
        s.color = Color(s.lerpR, s.lerpG, s.lerpB)
        addonlib.WebImage( "https://i.imgur.com/qEIG9YT.png", s.margin, s.margin, w - s.margin * 2, h - s.margin * 2, s.color, 0, 0 )
    end

    self.header.cbtn.DoClick = function()
        self:SetTitle("Closed")
        self:Remove()
    end
end

function PANEL:Paint(w, h)
    --local aX, aY = self:LocalToScreen()
    --BSHADOWS.BeginShadow()
    draw.RoundedBox(0, 0, 0, w, h, addonlib.theme.frame.background)
    --BSHADOWS.EndShadow(3, 2, 2)
end

function PANEL:SetTitle(title)
    self.title = title
end

function PANEL:ShowCloseButton(show)
    self.header.cbtn:SetVisible(show)
end

vgui.Register("addonlib.frame", PANEL, "EditablePanel")

concommand.Add("addonlib_frame", function()
    local f = vgui.Create("addonlib.frame")
    f:SetSize(ScrW() * .75, ScrH() * .75)
    f:Center()
    f:MakePopup(true)
    f:SetTitle("AddonLib - Testing Frame (by lion)")

    --[[
    local c = f:Add("addonlib.navbar")
    c:Dock(TOP)
    c:Center()
    c:SetBody(f)

    c:AddTab("Cool People", "DPanel")
    c:AddTab("Bad People", "DButton")
    c:AddTab("Ok People", "DHTML", function(s)
        s:OpenURL("https://www.google.com/")
    end)
    ]]

    local c = f:Add("addonlib.button")
    c:SetSize(500, 50)
    c:Center()
    c:SetText("Big Bain")
end)