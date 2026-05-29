local TweenService = game:GetService("TweenService")
local TweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local module = {}

function module.resizeUp(btn, newSize)
	local tween = TweenService:Create(btn, TweenInfo, {Size = newSize})
	tween:Play()
end

function module.resizeDown(btn, newSize)
	local tween = TweenService:Create(btn, TweenInfo, {Size = newSize})
	tween:Play()
end

return module
