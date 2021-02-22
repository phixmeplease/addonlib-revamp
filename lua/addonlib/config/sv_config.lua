---------------------------------------------------------
-- AddonLib In-Game Configuration Library              --
-- Please dont copy this, but I wont get mad if you do --
-- At least credit me                               :) --
---------------------------------------------------------

util.AddNetworkString("AddonLib.Configuration.SendConfig")

addonlib.config = {}
addonlib.configFuncs = {}
addonlib.configDir = "addonlib_cfg/"

ADDONLIB_CONFIGPRINT_NORMAL = 0
ADDONLIB_CONFIGPRINT_ERROR = 1
ADDONLIB_CONFIGPRINT_SUCCESS = 2

addonlib.configFuncs.fancyPrint = function(text, type)
    local clr = color_white
    if (type == 0) then clr = Color(75, 75, 255) end
    if (type == 1) then clr = Color(255, 75, 75) end
    if (type == 2) then clr = Color(75, 255, 75) end

    local prefix = "[Addonlib Configuration - Unknown Type] "
    if (type == 0) then prefix = "[Addonlib Configuration] " end
    if (type == 1) then prefix = "[Addonlib Configuration - Error] " end
    if (type == 2) then prefix = "[Addonlib Configuration - Success] " end

    MsgC(clr, prefix, color_white, text .. "\n")
end

addonlib.configFuncs.checkAndMakeConfigStuff = function()
	if (!file.Exists(addonlib.configDir, "DATA")) then
		file.CreateDir(addonlib.configDir)
		addonlib.configFuncs.fancyPrint("Created config folder!", ADDONLIB_CONFIGPRINT_SUCCESS)
	end
end

addonlib.configFuncs.getConfigTable = function()
    addonlib.configFuncs.checkAndMakeConfigStuff()
    local t = {}

    local oT = file.Read(addonlib.configDir .. "cfg.txt")
    if (!oT) then return {} end

    oT = util.JSONToTable(oT)
    if (!oT) then return {} end

    return oT
end

addonlib.configFuncs.getConfigVariable = function(valid)
    addonlib.configFuncs.checkAndMakeConfigStuff()
    local tbl = addonlib.configFuncs.getConfigTable()
    if (!tbl) then return "Unknown" end

    local value = tbl[valid]
    if (!value) then return "Unknown" end

    addonlib.config = table.Copy(addonlib.configFuncs.getConfigTable())

    return value
end

addonlib.configFuncs.saveConfigVariable = function(id, def)
    addonlib.configFuncs.checkAndMakeConfigStuff()
    local t = addonlib.configFuncs.getConfigTable()
    if (!t) then return end

    t[id] = def

    file.Write(addonlib.configDir .. "cfg.txt", util.TableToJSON(t))

    addonlib.config = table.Copy(addonlib.configFuncs.getConfigTable())
end

addonlib.configFuncs.registerConfigVariable = function(id, default)
    addonlib.configFuncs.checkAndMakeConfigStuff()
    if (addonlib.configFuncs.getConfigVariable(id) == "Unknown") then
        addonlib.configFuncs.saveConfigVariable(id, default)
    end
    addonlib.config = table.Copy(addonlib.configFuncs.getConfigTable())
end

addonlib.configFuncs.registerConfigVariable("LOVELY_TEST", 3423)

addonlib.configFuncs.syncConfig = function(tbl)
    addonlib.configFuncs.checkAndMakeConfigStuff()

    local compressed = util.TableToJSON(addonlib.config)
    if (!compressed) then return end

    net.Start("AddonLib.Configuration.SendConfig")
    net.WriteString(compressed)
    net.Send(tbl)
end

timer.Create("addonlib_configsync", 5, 0, function()
    addonlib.configFuncs.syncConfig(player.GetAll())
end)