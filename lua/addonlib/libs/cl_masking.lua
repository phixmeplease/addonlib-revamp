addonlib.simpleMask = function(maskFunc, drawFunc)
	render.ClearStencil()
	render.SetStencilEnable(true)
	render.SetStencilWriteMask(1)
	render.SetStencilTestMask(1)
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_ZERO)
	render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
	render.SetStencilReferenceValue(1)
	maskFunc()
	render.SetStencilFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	render.SetStencilReferenceValue(1)
	drawFunc()
	render.SetStencilEnable(false)
	render.ClearStencil()
end

-- function PANEL:Paint(w, h)
-- 	if(ArionUI.BlurEnabled) then
-- 		Threebow.Mask(function()
-- 			self:DrawBounds(w, h) -- draw background (must be white box)
-- 		end, function()
-- 			self:DrawBlur() -- normal blur drawing
-- 		end)
-- 	end

-- 	self:DrawBounds(w, h, ColorAlpha(ArionUI.Colors.BackgroundLight, ArionUI.BlurEnabled && 240 || 255)) -- now draw normal background
-- end
