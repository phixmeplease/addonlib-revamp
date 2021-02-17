-- Logging library, allows everyone to see errors lol

local function cl()
    addonlib_logs = {}

    function addonlib.addLog(_type, _title, _desc)
        table.insert(addonlib_logs, {
            type = _type,
            title = _title,
            desc = _desc,
        })
    end

    function addonlib.showLogs()
        local frame = vgui.Create("addonlib.frame")
        frame:SetSize(500, 600)
        frame:Center()
        frame:MakePopup()
        frame:SetTitle("Addonlib Logs")

        frame.scroll = frame:Add("addonlib.scrollpanel")
        frame.scroll:Dock(FILL)

        for k, v in pairs(addonlib_logs) do
            local pnl = frame.scroll:Add("DPanel")
            pnl:Dock(TOP)
            pnl:DockMargin(10, 10, 10, 0)
        end
    end

    concommand.Add("addonlib_logs", addonlib.showLogs)

    addonlib.addLog(1, "success", "_desc") -- Success
    addonlib.addLog(2, "error", "_desc") -- Error
    addonlib.addLog(3, "info", "_desc") -- Info
end

local function sv()

end

if (SERVER) then
    sv()
else
    cl()
end