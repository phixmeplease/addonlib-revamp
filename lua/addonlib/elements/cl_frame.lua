-- Basic Frame Functions
--     SetTitle(text) - Sets the title of the frame
--     ShowCloseButton(show) - Should I show the close button?
--     SetHelp (text) - What should the help text be

surface.CreateFont("addonlib.fonts.frameTitle", {
    font = "Montserrat Medium",
    size = 30,
    weight = 500,
})

surface.CreateFont("addonlib.fonts.frameTitle", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})

local PANEL = {}

function PANEL:Init()
    self.text = "Poggers, looks like the addon author messed somthing up, don't blame lion unless lion made the addon lol :D"
    self.title = "addonlib"

    self.header = self:Add("DPanel")
    self.header:Dock(TOP)
    self.header:SetTall(50)

    self.header.Paint = function(s, w, h)
        draw.RoundedBoxEx(10, 0, 0, w, h, addonlib.theme.frame.header, true, true, false, false)
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

    self.header.cbtn.margin = 18

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

    self.header.question = self.header:Add("DButton")
    self.header.question:Dock(RIGHT)
    self.header.question:SetWide(self.header:GetTall())
    self.header.question:SetText("")
    self.header.question.margin = 10
    self.header.question.marginH = 12

    self.header.question.lerpR = 255
    self.header.question.lerpG = 255
    self.header.question.lerpB = 255

    self.header.question.margin = 18

    self.header.question.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.lerpR = Lerp(7 * FrameTime(), s.lerpR, addonlib.theme.frame.maximse.r)
            s.lerpG = Lerp(7 * FrameTime(), s.lerpG, addonlib.theme.frame.maximse.g)
            s.lerpB = Lerp(7 * FrameTime(), s.lerpB, addonlib.theme.frame.maximse.b)
        else
            s.lerpR = Lerp(7 * FrameTime(), s.lerpR, 255)
            s.lerpG = Lerp(7 * FrameTime(), s.lerpG, 255)
            s.lerpB = Lerp(7 * FrameTime(), s.lerpB, 255)
        end
        
        s.color = Color(s.lerpR, s.lerpG, s.lerpB)
        addonlib.WebImage( "https://i.imgur.com/FuQMlV2.png", s.margin, s.margin, w - s.margin * 2, h - s.margin * 2, s.color, 0, 0 )
    end

    self.header.question.DoClick = function(s)
        if (IsValid(CUR_ADDON_HELP)) then
            CUR_ADDON_HELP:Remove()
        end 
        CUR_ADDON_HELP = vgui.Create("addonlib.frame")
        CUR_ADDON_HELP:SetSize(ScrW() * .3, ScrH() * .3)
        CUR_ADDON_HELP:Center()
        CUR_ADDON_HELP:MakePopup()
        CUR_ADDON_HELP:SetTitle("Help (" .. self.title .. ")")

        CUR_ADDON_HELP.helptext = CUR_ADDON_HELP:Add("DLabel")
        CUR_ADDON_HELP.helptext:Dock(FILL)
        CUR_ADDON_HELP.helptext:SetContentAlignment(7)
        CUR_ADDON_HELP.helptext:SetWrap(true)
        CUR_ADDON_HELP.helptext:SetText(self.text)
        CUR_ADDON_HELP.helptext:DockMargin(5, 5, 5, 5)
        CUR_ADDON_HELP.helptext:SetFont("addonlib.fonts.frameTitle")
    end
    self.header.question:SetVisible(false)

end

function PANEL:Paint(w, h)
    local aX, aY = self:LocalToScreen()
    BSHADOWS.BeginShadow()
    draw.RoundedBox(10, aX, aY, w, h, addonlib.theme.frame.background)
    BSHADOWS.EndShadow(3, 2, 2)
end

function PANEL:SetHelp(text)
    self.text = text
    self.header.question:SetVisible(true)
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
    f:SetHelp("Didn't Ask")

    
    -- local c = f:Add("addonlib.navbar")
    -- c:Dock(TOP)
    -- c:Center()
    -- c:SetBody(f)

    -- c:AddTab("Cool People", "DPanel")
    -- c:AddTab("Bad People", "DButton")
    -- c:AddTab("Ok People", "DHTML", function(s)
    --     s:OpenURL("https://www.google.com/")
    -- end)

    local c = f:Add("addonlib.combobox")
    c:SetSize(500, 50)
    c:Center()

    for i = 1, 100 do
        c:AddChoice(i)
    end
    

    -- local c = f:Add("addonlib.textentry")
    -- c:SetSize(500, 50)
    -- c:Center()
end)