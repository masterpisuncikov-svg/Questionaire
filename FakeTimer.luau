local player = game.Players.LocalPlayer
local PlayerGui = player.PlayerGui
local lobby = PlayerGui:WaitForChild("lobby")
local TweenService = game:GetService("TweenService")
local Questions = require(script.Parent.Questions)
local _animates = require(script.Parent.Parent._animates)
local seconds = 15 * 60
local speed = 1
local Results = require(script.Parent.Results)
local AES = game:GetService("AvatarEditorService")
local canwatch = Instance.new("BoolValue")
local SocialService = game:GetService("SocialService")
local boost = 1.0
local listedPlrs = {}
local module = {}

function module.launch()
	script.Parent.questionarecome.Value = false
	seconds = 15 * 60
	task.spawn(function()
		while task.wait(speed / boost) do
			seconds -= 1
			lobby.Frame.FakeTimer.Bar.Time.Text = string.format("%02d:%02d", seconds/60%60, seconds%60)
			lobby.Frame.FakeTimer.Bar.Fill.Size = UDim2.new(seconds / (15 * 60), 0, 1, 0)
			if seconds == 0 then
				for i, v in pairs(lobby.Frame.FakeTimer.Buttons:GetChildren()) do
					if v:IsA("TextButton") then
						v.Interactable = false
					end
				end
				Results.popup(script.Parent.Corrects.Value)
			end
		end
	end)
	
	local success, result = nil
	
	for i, v in pairs(lobby.Frame.FakeTimer.Buttons:GetChildren()) do
		if v:IsA("TextButton") then
			local sizedown = v.Size
			local sizeup = sizedown + UDim2.new(0.04, 0, 0.04, 0)
			
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
					
					if v.Name == "Skip" then
						game.MarketplaceService:PromptProductPurchase(player, 3577643005)
					elseif v.Name == "x2" then
						game.MarketplaceService:PromptProductPurchase(player, 3577643379)
					elseif v.Name == "Scare" then
						game.MarketplaceService:PromptProductPurchase(player, 3577643223)
					elseif v.Name == "Favorite" then
						game:GetService("AvatarEditorService"):PromptSetFavorite(game.PlaceId, 1, true)
					elseif v.Name == "Join" then
						success, result = pcall(function()
							return 	game:GetService("GroupService"):PromptJoinAsync(276262856)
						end)
						canwatch.Value = true
					elseif v.Name == "Invite" then
						SocialService:PromptGameInvite(player)
					elseif v.Name == "Add" then
						local ran = math.random(1, #game.Players:GetChildren())
						local plr:Player = game.Players:GetChildren()[ran]
						if plr ~= player then
							game:GetService("StarterGui"):SetCore("PromptSendFriendRequest",plr)
						end
					end
					
				end
			end)
		end
	end
	
	canwatch.Changed:Connect(function(val)
		if val == true then
			if success then
				if result == Enum.GroupMembershipStatus.Joined then
					seconds -= 120
				end
			end
		end
	end)
end

function module.escPrize()
	seconds -= 3 * 60
end

game.ReplicatedStorage.succeed.OnClientEvent:Connect(function(id) 
	if id == 3577643379 then
		speed /= 2
	elseif  id == 3577643005 then
		seconds -= (3 * 60)
	elseif  id == 3577643223 then

	end
end)

AES.PromptSetFavoriteCompleted:Connect(function()
	seconds -= 60
end)

game.Players.PlayerAdded:Connect(function(plr)
	if plr:IsFriendsWithAsync(player.UserId) then
		seconds -= 60
	end
end)

task.spawn(function()
	while task.wait(1) do
		for i, plr in pairs(game.Players:GetChildren()) do
			if plr:IsFriendsWithAsync(player.UserId) then
				if not listedPlrs[plr] then
					boost += 0.5
					table.insert(listedPlrs, plr)
				end
			end
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	if listedPlrs[plr] then
		boost -= 0.5
		table.remove(listedPlrs, table.find(listedPlrs, plr))
	end
end)

return module
