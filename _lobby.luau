local player = game.Players.LocalPlayer
local PlayerGui = player.PlayerGui
local lobby = PlayerGui:WaitForChild("lobby")
local TweenService = game:GetService("TweenService")
local emojis = {
	"rbxassetid://96723443"
}
local module = {}

function module.loadEmojirain()
	task.spawn(function()
		while task.wait(0.85) do
			local randX = math.random(0, 100) 
			local ranMoji = math.random(1, #emojis)
			local sped = math.random(7,10)
			local emoji = script.emoji:Clone()
			emoji.Parent = lobby.Frame
			emoji.Position = UDim2.new(randX / 100 - 0.1,0,-0.1,0)
			emoji.Image = emojis[ranMoji]
			local track = TweenService:Create(emoji, TweenInfo.new(sped, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Position = UDim2.new(randX / 100 - 0.1,0,1.1,0)})
			task.spawn(function() track:Play() end)
		end
	end)
end

return module
