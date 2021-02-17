local PANEL = {}

surface.CreateFont("addonlib.fonts.urlLoading", {
    font = "Montserrat Medium",
    size = 45,
    weight = 500,
})

function PANEL:Init()
    -- Base variables
    self.loadingText = "Loading Url..."

    self.url = self:Add("DHTML")
    self.url:Dock(FILL)

    self.click = self.url:Add("DButton")
    self.click:SetSize(25, 25)
    self.click:AlignTop(10)
    self.click:AlignLeft(10)
    self.click:SetText("")
    self.click.curAl = 0
    self.click.lerpR = 0
    self.click.lerpG = 0
    self.click.lerpB = 0
    self.click.margin = 0

    self.click.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.lerpR = Lerp(7 * FrameTime(), s.lerpR, addonlib.theme.url.urlhover.r)
            s.lerpG = Lerp(7 * FrameTime(), s.lerpG, addonlib.theme.url.urlhover.g)
            s.lerpB = Lerp(7 * FrameTime(), s.lerpB, addonlib.theme.url.urlhover.b)
        else
            s.lerpR = Lerp(7 * FrameTime(), s.lerpR, addonlib.theme.url.urlnormal.r)
            s.lerpG = Lerp(7 * FrameTime(), s.lerpG, addonlib.theme.url.urlnormal.g)
            s.lerpB = Lerp(7 * FrameTime(), s.lerpB, addonlib.theme.url.urlnormal.b)
        end
        
        s.color = Color(s.lerpR, s.lerpG, s.lerpB)
        addonlib.WebImage( "https://i.imgur.com/FuQMlV2.png", s.margin, s.margin, w - s.margin * 2, h - s.margin * 2, s.color, 0, 0 )
    end
end

function PANEL:OpenURL(u)
    self.url:OpenURL(u)
end

function PANEL:Paint(w, h)
    draw.SimpleText(self.loadingText, "addonlib.fonts.urlLoading", w / 2, h / 2, addonLibColor(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

vgui.Register("addonlib.url", PANEL, "DPanel")

concommand.Add("addonlib_urltest", function()
    local f = vgui.Create("addonlib.frame")
    f:SetSize(ScrW() * .75, ScrH() * .75)
    f:Center()
    f:SetTitle("Url Test")
    f:MakePopup()

    local x = f:Add("addonlib.url")
    x:Dock(FILL)
    x:OpenURL("https://www.google.com/")
end)