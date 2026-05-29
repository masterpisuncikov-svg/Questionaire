local player = game.Players.LocalPlayer
local PlayerGui = player.PlayerGui
local lobby = PlayerGui:WaitForChild("lobby")
local loader = require(script.Parent.MainQuestionare.Loader)
local module = {}
local _animates = require(script.Parent._animates)

for i, v in pairs(lobby.Frame.Buttins:GetChildren()) do
	if v:IsA("TextButton") then
		local endSize = v.Size
		local sizeup = endSize + UDim2.new(0.03, 0, 0.03, 0)
		local sizedown = endSize
		v.MouseEnter:Connect(function()
			_animates.resizeUp(v, sizeup)
		end)
		
		v.MouseLeave:Connect(function()
			_animates.resizeDown(v, sizedown)
		end)
		
		v.InputBegan:Connect(function(inp)
			if inp.UserInputType == Enum.UserInputType.MouseButton1 then
				_animates.resizeDown(v, sizedown)
			end
		end)
		
		v.InputEnded:Connect(function(inp)
			if inp.UserInputType == Enum.UserInputType.MouseButton1 then
				_animates.resizeUp(v, sizeup)
				
				loader.load()
			end
		end)
	end
end



return module
