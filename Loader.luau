require(script.Parent.Library._lobby).loadEmojirain()
require(script.Parent.Library.Handler)
require(script.Parent.Library.MainQuestionare.FakeTimer)
local _animates = require(script.Parent.Library._animates)
local player = game.Players.LocalPlayer
local PlayerGui = player.PlayerGui
local lobby = PlayerGui:WaitForChild("lobby")
local getPrize = false

local v = lobby.Frame.TROLL
local sizedown = v.Size
local sizeup = sizedown + UDim2.new(0.01, 0, 0.01, 0)

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

		v.Frame.Visible = not v.Frame.Visible

	end
end)

for i,g in pairs(v.Frame:GetChildren()) do
	if g:IsA("TextButton") then
		local sizedown = g.Size
		local sizeup = sizedown + UDim2.new(0.03, 0, 0.03, 0)

		g.MouseEnter:Connect(function()
			_animates.resizeUp(g, sizeup)
		end)

		g.MouseLeave:Connect(function()
			_animates.resizeDown(g, sizedown)
		end)

		g.InputBegan:Connect(function(inp)
			if inp.UserInputType == Enum.UserInputType.MouseButton1 then
				_animates.resizeDown(g, sizedown)
			end
		end)

		g.InputEnded:Connect(function(inp)
			if inp.UserInputType == Enum.UserInputType.MouseButton1 then
				_animates.resizeUp(g, sizeup)
				
				if g.Name == "RESET" then
					game.MarketplaceService:PromptProductPurchase(player, 3577651311)
				elseif g.Name == "BLACKOUT" then
					game.MarketplaceService:PromptProductPurchase(player, 3577651173)
				elseif g.Name == "SCARE" then
					game.MarketplaceService:PromptProductPurchase(player, 3577651028)
				elseif g.Name == "SLOW" then
					game.MarketplaceService:PromptProductPurchase(player, 3577656922)
				end
				
			end
		end)

	end
end

game.ReplicatedStorage.troll.OnClientEvent:Connect(function(id, plr)
	print(id)
	if id == 3577651311 then
		if script.Parent.Library.MainQuestionare.questionarecome.Value == true then
			local loader = require(script.Parent.Library.MainQuestionare.Loader)
			loader.reload()
			local template = script.Template:Clone()
			template.Parent = lobby.Frame.Messages
			template.Text = plr .. " 📜 Reseted Your Quiz!"
			task.wait(4)
			template:Destroy()
		end
	elseif id == 3577651173 then
		player:Kick("You was Kicked By " .. plr)
	elseif id == 3577651028 then
		lobby.Frame.Scare.Visible = true
		game.SoundService.Jumpscare:Play()
		task.wait(3.088)
		lobby.Frame.Scare.Visible = false
	elseif id == 3577656922 then
		local template = script.Template:Clone()
		template.Parent = lobby.Frame.Messages
		template.Text = "⏳ Your Time Has Been Slowed By " .. plr
		task.wait(4)
		template:Destroy()
	end
end)

game.GuiService.MenuOpened:Connect(function()
	if getPrize == false then
		game.SoundService.Sirene:Play()
		lobby.Frame.esc.Visible = true
		lobby.Frame.esc.TextButton.Activated:Connect(function()
			local ft = require(script.Parent.Library.MainQuestionare.FakeTimer)
			ft.escPrize()
			lobby.Frame.esc:Destroy()
			getPrize = true
		end)
	end
end)

game.GuiService.MenuClosed:Connect(function()
	game.SoundService.Sirene:Stop()
end)
