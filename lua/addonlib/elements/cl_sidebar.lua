surface.CreateFont("addonlib.fonts.buttonFont", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})

local PANEL = {}

AccessorFunc(PANEL, "body_element", "Body")

function PANEL:Init()
    self.buttons = {}
    self.pnls = {}

    self.active = 0

    self:SetWide(200)

    self.canvas = self:Add("DPanel")
    self.canvas:Dock(FILL)
    self.canvas:DockMargin(0, 0, 0, 0)

    self.canvas.Paint = function(s, w, h)
        draw.RoundedBoxEx(10, 0, 0, w, h, addonlib.theme.navbar.background, false, false, true, false)
    end

    self.color = addonlib.theme.navbar.acent
end

function PANEL:SetColor(clr)
    self.color = clr
end

function PANEL:AddTab(name, panel, panelFunc, ico)
    ico = ico or ""

    local i = table.Count(self.buttons) + 1
    self.buttons[i] = self.canvas:Add("DButton")
    local btn = self.buttons[i]
    btn.id = i
    btn:Dock(TOP)
    btn:SetText(name)
    btn:SetFont("addonlib.fonts.buttonFont")
    btn:SetColor(addonlib.theme.navbar.text)
    btn:SetTall(50)
    btn:DockMargin(0, 0, 0, 0)
    btn:SizeToContentsX(32)
    btn:SetText("")
    btn:SetContentAlignment(4)
    btn:SetTextInset(0, 0)
    btn.lerpW = 0
    btn.marH = 5
    btn.Paint = function(s, w, h)
        if (self.active == s.id) then
            draw.RoundedBoxEx(6, 0, 0, 6, h, self.color, false, true, false, true)
        end

        draw.SimpleText(name, "addonlib.fonts.buttonFont", w / 2, h / 2, addonlib.bclr.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    btn.DoClick = function(s)
        self:SetActive(s.id)
    end

    self.pnls[i] = self:GetBody():Add(panel)
    local pnl = self.pnls[i]
    pnl:Dock(FILL)
    pnl:SetVisible(false)

    if (panelFunc) then
        panelFunc(pnl)
    end

    return btn
end

function PANEL:SetActive(id)
    local activeBtn = self.buttons[self.active]
    if (activeBtn) then
        activeBtn:SetColor(addonlib.theme.navbar.text)
    end

    local activePnl = self.pnls[self.active]
    if (activePnl) then
        activePnl:SetVisible(false)
    end

    self.active = id

    local activeBtn = self.buttons[id]
    if (activeBtn) then
        activeBtn:SetColor(addonlib.theme.navbar.acent)
    end

    local activePnl = self.pnls[id]
    if (activePnl) then
        activePnl:SetVisible(true)
    end
end

function PANEL:Paint(w, h) end

function PANEL:Think()
    local w = self:GetWide()
    for k, v in pairs(self.buttons) do
        if (v:GetWide() > w) then
            w = v:GetWide()
        end
    end
    self:SetWide(w)
end

vgui.Register("addonlib.sidebar", PANEL, "EditablePanel")