addonlib.sql = {}
addonlib.sql.config = {}

addonlib.sql.error = function(rea)
    print("AddonLib SQL Error:\n" .. rea)
end

-- Seperate function incase I add mysqlo support later and I dont have to change everything
addonlib.sql.query = function(q)
    if (!q) then
        addonlib.sql.error("Attempted to query without specifying query.")
    end
    local q = sql.Query(q)
    if (!q) then
        addonlib.sql.error(sql.LastError())
    end

    sql.Query(q)
end

addonlib.sql.config.checkForTable = function()
    if (!sql.TableExists("addonlib_config")) then
        addonlib.sql.query("CREATE TABLE addonlib_config( id TEXT, cat TEXT , value TEXT) ")
    end
end

addonlib.sql.config.get = function(id)
    addonlib.sql.config.checkForTable()
    local t = sql.Query("SELECT * FROM addonlib_config")
    if (!t) then return {} end
    return t
end

addonlib.sql.config.registerDefault = function(id, cat, def)
    addonlib.sql.config.checkForTable()
    local ndef = tostring(def)
    addonlib.sql.query("INSERT INTO addonlib_config( id , cat , value ) VALUES(" .. tostring(id) .. " , " .. tostring(cat) .. " , " .. tostring(def) .. " )")
end

addonlib.sql.query("DROP TABLE addonlib_config")

addonlib.sql.config.registerDefault("addonlib_enable_shadows", "AddonLib", true)

PrintTable(addonlib.sql.config.get())
