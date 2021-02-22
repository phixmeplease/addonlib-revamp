addonlib.config = {}

net.Receive("AddonLib.Configuration.SendConfig", function()
    local uncompressed = net.ReadString()
    if (!uncompressed) then return end
    local tbl = util.JSONToTable(uncompressed)
    if (!tbl) then return end
    addonlib.config = tbl
end)

addonlib.openConfigMenu = function()
    local config_frame = vgui.Create("addonlib.frame")
    config_frame:SetSize(ScrW() * .75, ScrH() * .75)
    config_frame:Center()
    config_frame:SetTitle("AddonLib Configuration")
    config_frame:MakePopup()

    config_frame:Add("addonlib.configFrame")
        :Dock(FILL)
end

concommand.Add("addonlib", function()
    addonlib.openConfigMenu()
end)