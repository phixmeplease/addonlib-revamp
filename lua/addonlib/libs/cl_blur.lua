addonlib.blur = Material("pp/blurscreen")
addonlib.funcs = {}
addonlib.funcs.drawBlur = function(x, y, w, h, amount)
	local scrw, scrh = ScrW(), ScrH()
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(addonlib.blur)

	for i = 1, 5 do
		addonlib.blur:SetFloat("$blur", (i / 4) * (4))
		addonlib.blur:Recompute()
		render.UpdateScreenEffectTexture()
		render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(0 * -1, 0 * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end
end

addonlib.funcs.pnlBlur = function(pnl, after)
	pnl.Paint = function(s, w, h)
		local x, y = s:LocalToScreen(0, 0)
		local scrW, scrH = ScrW(), ScrH()

		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(addonlib.blur)

		for i = 1, 3 do
			addonlib.blur:SetFloat("$blur", (i / 3) * (amount or 8))
			addonlib.blur:Recompute()

			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
		end
		if (after) then
			after(s, w, h)
		end
	end
end