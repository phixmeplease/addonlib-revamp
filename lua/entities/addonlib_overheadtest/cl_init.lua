surface.CreateFont("addonlib.fonts.overheadTitle", {
    font = "Montserrat Medium",
    size = 80,
    weight = 500,
})
surface.CreateFont("addonlib.fonts.overheadDesc", {
    font = "Montserrat Medium",
    size = 40,
    weight = 500,
})

include("shared.lua")

-- Draw the entity and overhead
function ENT:DrawTranslucent()
    self:DrawModel()
    cam.Start3D2D(self:GetPos() + self:GetUp() * 100, Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
        addonlib.overhead("Addonlib is the best addon ever, change my mind. This text is really long")
    cam.End3D2D()
    cam.Start3D2D(self:GetPos() + self:GetUp() * 115, Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
        addonlib.overhead("POG")
    cam.End3D2D()
end