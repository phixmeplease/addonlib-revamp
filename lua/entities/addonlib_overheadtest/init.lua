AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_equipment/phone_booth.mdl")
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if (IsValid(phys)) then
        phys:Wake()
    end
    self:SetUseType(SIMPLE_USE)
end


function ENT:Use(ply)
    ply:ChatPrint("Hello, thanks for using addonlib :D")
end