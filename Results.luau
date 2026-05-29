local player = game.Players.LocalPlayer
local PlayerGui = player.PlayerGui
local lobby = PlayerGui:WaitForChild("lobby")
local TweenService = game:GetService("TweenService")
local Questions = require(script.Parent.Questions)
local _animates = require(script.Parent.Parent._animates)
local questionReview = 1
local module = {}

function module.popup(corrects)
	script.Parent.questionarecome.Value = false
	local function show(inter, tohide)
		local track = TweenService:Create(inter, TweenInfo.new(0.2), tohide)
		track:Play()
		task.wait(0.08)
	end
	
	local results = lobby.Frame.Results
	local arrow = results.Arrow
	arrow.Rotation = (190 / 99) * ( ((corrects / 35) * 100) - 1)
	results.percent.Text = "You are " .. math.round((corrects / 35) * 100)  .. "% Rich!"
	

	for i,v in pairs(results.btns:GetChildren()) do
		task.spawn(function()
			for i=1,20 do
				v.Interactable = true
				task.wait(0.3)
			end
		end)
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

				if v.Name == "Retry" then
					local loader = require(script.Parent.Loader)
					loader.reload()
				else
					task.spawn(function()
						for i, inter in pairs(results:GetDescendants()) do
							task.spawn(function()
								if inter:IsA("TextLabel") then
									show(inter, {TextTransparency = 1})
								elseif inter:IsA("Frame") then
									if inter.Name ~= "Answers" then
										show(inter, {BackgroundTransparency = 1})
									end
								elseif inter:IsA("TextButton") then
									if inter.Name ~= "Answers" then
										show(inter, {BackgroundTransparency = 1, TextTransparency = 1})
										inter.Interactable = false
									end
								elseif inter:IsA("UIStroke") then
									if inter.Name ~= "Answers" then
										show(inter, {Transparency = 1})
									end
								elseif inter:IsA("ImageLabel") then
									if inter.Name ~= "Answers" then
										show(inter, {ImageTransparency = 1})
									end
								end	
								task.wait(0.03)
							end)
						end
					end)
					
					local review = require(script.Parent.Review)
					review.showUpQuest(questionReview)
				end
			end
		end)
	end
	
	lobby.Frame.Review.F.Activated:Connect(function()
		if questionReview < 35 then
			local review = require(script.Parent.Review)
			questionReview += 1
			review.showUpQuest(questionReview)
		end
	end)
	
	lobby.Frame.Review.B.Activated:Connect(function()
		if questionReview > 1 then
			local review = require(script.Parent.Review)
			questionReview -= 1
			review.showUpQuest(questionReview)
		end
	end)
	
	lobby.Frame.Review.X.Activated:Connect(function()
		local review = require(script.Parent.Review)
		review.returnup()
	end)
	
	task.spawn(function()
		for i, inter in pairs(lobby.Frame.FakeTimer:GetDescendants()) do
			if inter.Name ~= "Buttons" then
				if inter:IsA("TextLabel") then
					show(inter, {TextTransparency = 1})
				elseif inter:IsA("Frame") then
					if inter.Name ~= "Answers" then
						show(inter, {BackgroundTransparency = 1})
					end
				elseif inter:IsA("TextButton") then
					if inter.Name ~= "Answers" then
						show(inter, {BackgroundTransparency = 1, TextTransparency = 1})
						inter.Interactable = true
					end
				elseif inter:IsA("UIStroke") then
					if inter.Name ~= "Answers" then
						show(inter, {Transparency = 1})
					end
				end
			end
		end
	end)
	task.wait(2)
	task.spawn(function()
		for i, inter in pairs(results:GetDescendants()) do
			if inter:IsA("TextLabel") then
				show(inter, {TextTransparency = 0})
			elseif inter:IsA("Frame") then
				if inter.Name ~= "Answers" then
					show(inter, {BackgroundTransparency = 0})
				end
			elseif inter:IsA("TextButton") then
				if inter.Name ~= "Answers" then
					show(inter, {BackgroundTransparency = 0, TextTransparency = 0})
					inter.Interactable = false
				end
			elseif inter:IsA("UIStroke") then
				if inter.Name ~= "Answers" then
					show(inter, {Transparency = 0})
				end
			elseif inter:IsA("ImageLabel") then
				if inter.Name ~= "Answers" then
					show(inter, {ImageTransparency = 0})
				end
			end
		end
	end)
	
end

return module
