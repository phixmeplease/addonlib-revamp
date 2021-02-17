-- In Game configuration
-- Server side module
addonlib.defaultConfig = addonlib.defaultConfig or {}
addonlib.configFuncs = {} -- Make the functions table

----------------------------------------------
util.AddNetworkString("addonlib_SendConfig")
util.AddNetworkString("addonlib_PlayerRequestedConfig")
util.AddNetworkString("addonlib_PlayerUpdateConfig")
----------------------------------------------

-- Initalize default config
AddCSLuaFile("addonlib/config/sh_defaultconfig.lua")
include("addonlib/config/sh_defaultconfig.lua")

-- Run a hook to tell everyone the config was loaded!
hook.Run("addonlib_defaultConfigLoaded")

-- Copy the default config
addonlib.config = table.Copy(addonlib.defaultConfig)

-- Make the config table
addonlib.config = {}

-- Setup who can use the config
addonlib.configAccess ={}
addonlib.configAccess["superadmin"] = true

local meta = FindMetaTable("Player")
function meta:AddonLib_HasConfigAccess()
    return addonlib.configAccess[self:GetUserGroup()] or false
end

-- Base setup and functions
addonlib.isConfigLoaded = false
addonlib.configFuncs.initalizeConfig = function() -- Function for loading the config
    for k, v in pairs(file.Find("addonlib/in_game_config/*", "DATA")) do
        local data = util.JSONToTable(file.Read("addonlib/in_game_config/" .. v, "DATA"))
        if (data and istable(data)) then
            addonlib.config[string.upper(string.Replace(v, ".txt", ""))] = dataTable
        end
    end
end

addonlib.configFuncs.initalizeConfig()
addonlib.isConfigLoaded = true

-- Saving the data
addonlib.configFuncs.saveConfig = function(change)
    if (!addonlib.config == nil) then
        if (!istable(addonlib.config)) then
            addonlib.configFuncs.initalizeConfig()
            return
        end
    else
        addonlib.configFuncs.initalizeConfig()
        return
    end

    if (!file.Exists("addonlib/in_game_config", "DATA")) then
        file.CreateDir("addonlib/in_game_config")
    end

    for k, v in pairs(change or table.GetKeys(addonlib.config)) do
        local write = util.TableToJSON(addonlib.config[v] or {})
        file.Write("addonlib/in_game_config/" .. v .. ".txt", write)
    end
end

-- Send the config to someone
addonlib.configFuncs.sendConfig = function(ply, Cfgkeys)
    local compress = util.Compress(util.TableToJSON(addonlib.config))
    local split = 5000
    local length = #compressed
    local cfgParts = math.ceil(length/split)
    local cfgTable = {}

    for i = 1, cfgParts do
        local min
        local max
        if i == 1 then
            min = i
            max = split
        elseif i > 1 and i ~= cfgParts then
            min = ( i - 1 ) * split + 1
			max = min + split - 1
        elseif i > 1 and i == cfgParts then
			min = ( i - 1 ) * split + 1
			max = len
		end

        cfgTable[i] = string.sub(compress, min, max)
    end

    local str, key = "addonlib_sendconfig_" .. tostring(ply), 1
    local function sendConfigToPlayer()
        if (!cfgTable[key]) then return end
        net.Start("addonlib_SendConfig")
        net.WriteString(str)
        net.WriteUInt(key, 5)
        net.WriteUInt(#cfgTable, 5)
        net.WriteUInt(#cfgTable[key], 16)
        net.WriteUInt(cfgTable[key], #cfgTable[key])
        net.Send(ply)

        key = key + 1
    end

    if( #partsTable > 1 ) then
		timer.Create( str, 0.1, #cfgTable, sendConfigToPlayer )
	end
end

addonlib.configFuncs.updateConfigTable = function(ply, newCfg)
    if (istable(newCfg)) then
        for k, v in pairs(newCfg) do
            addonlib.config[k] = v
        end
        local keys = table.GetKeys(newCfg)
        addonlib.configFuncs.sendConfig(player.GetAll(), keys)
        addonlib.configFuncs.saveConfig(keys)
    end
end

net.Receive("addonlib_PlayerUpdateConfig", function(l, ply)
    if (!ply:AddonLib_HasConfigAccess()) then return end
    local compressed = net.ReadData(l)
    if (!compressed) then return end
    local unCompressed = util.Decompress(compressed)
    if (!unCompressed) then return end
    local cfg = util.JSONToTable(unCompressed)
    if (!cfg) then return end
    addonlib.configFuncs.updateConfigTable(ply, cfg)
end)

-- Allow users to request the config
net.Receive("addonlib_PlayerRequestedConfig", function(_, ply)
    if (ply.configCooldown or 0 > CurTime()) then return end
    ply.configCooldown = CurTime() + 2.5
    addonlib.configFuncs.sendConfig(ply)
end)

-- This sends the config to the player when they join :D
hook.Add("PlayerInitalSpawn", "addonlib_SendConfigOnSpawn", function(ply)
    if (!IsValid(ply)) then return end

    addonlib.configFuncs.sendConfig(ply)
end)