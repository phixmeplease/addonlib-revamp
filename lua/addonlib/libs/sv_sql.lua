// well welcome lmao
// dont mess with this or ill kill you :)
// not a threat I promise
// This was made for CookieCoin lmao
// So most of it might break, but dont scream at me if it does
addonlib.sql = {}

local _sql = addonlib.sql
local sql = sql

function _sql:MakeTable(name, ...)
    local pars = ""
    for k, v in pairs({...}) do
        pars = pars .. v
        if (k != #{...}) then
            pars = pars .. ", "
        end
    end
    sql.Query(("CREATE TABLE IF NOT EXISTS %s(" .. pars ..  ")"):format(name))
end

function _sql:AddValues(name, def_pars, ...)
    local pars = ""
    for k, v in pairs({...}) do
        pars = pars .. v
        if (k != #{...}) then
            pars = pars .. ", "
        end
    end

    sql.Query(("INSERT INTO %s( " .. def_pars .. " ) VALUES( %s )"):format(name, pars))
end

function _sql:DropTable(name)
    sql.Query("DROP TABLE " .. name)
end

function _sql:GetValues(name, what, ...)
    local wh = ""
    local pars = ""
    for k, v in pairs({...}) do
        pars = pars .. v
        if (k != #{...}) then
            pars = pars .. ", "
        end
    end

    local query = sql.Query((("SELECT %s FROM %s WHERE %s"):format(what, name, wh))) or false
    return query
end