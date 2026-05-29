local player = game.Players.LocalPlayer
local PlayerGui = player.PlayerGui
local lobby = PlayerGui:WaitForChild("lobby")
local TweenService = game:GetService("TweenService")
local Questions = require(script.Parent.Questions)
local _animates = require(script.Parent.Parent._animates)
local FakeTimer = require(script.Parent.FakeTimer)
local question = 0
local transit
local module = {}

function module.TransitionBetween(answer)
	transit = 3
	local mainInterface = lobby.Frame.Questionare

	local function show(inter, tohide)
		local track = TweenService:Create(inter, TweenInfo.new(0.2), tohide)
		track:Play()
		task.wait(0.08)
	end


	local Transition = lobby.Frame.Questionare.Transition
	Transition.Timer.Text = "3"
	task.spawn(function()
		for i, inter in pairs(mainInterface:GetDescendants()) do
			if inter:IsA("TextLabel") then
				show(inter, {TextTransparency = 1})
			elseif inter:IsA("Frame") then
				if inter.Name ~= "Answers" then
					show(inter, {BackgroundTransparency = 1})
				end
			elseif inter:IsA("TextButton") then
				if inter.Name ~= "Answers" then
					show(inter, {BackgroundTransparency = 1, TextTransparency = 1})
				end
			elseif inter:IsA("UIStroke") then
				if inter.Name ~= "Answers" then
					show(inter, {Transparency = 1})
				end
			end
		end
		task.wait(0.08)
		for i, inter in pairs(Transition:GetDescendants()) do
			if inter:IsA("TextLabel") then
				show(inter, {TextTransparency = 0})
			end
		end
		task.wait(0.1)
		for i=1,3 do
			Transition.Timer.Text = transit
			transit -= 1
			task.wait(1)
		end
		
		if answer == true then
			Transition.Timer.Text = "✅ Correct answer!"
			script.Parent.Corrects.Value += 1
		else
			Transition.Timer.Text = "❌ Wrong answer"
		end
		task.wait(1)
		task.spawn(function()
			for i, inter in pairs(Transition:GetDescendants()) do
				if inter:IsA("TextLabel") then
					show(inter, {TextTransparency = 1})
				end
			end
		end)
		module.showUpQuest()
		
	end)
end

function module.showUpQuest()
	question += 1
	local mainInterface = lobby.Frame.Questionare

	local function show(inter, tohide)
		local track = TweenService:Create(inter, TweenInfo.new(0.2), tohide)
		track:Play()
		task.wait(0.08)
	end

	task.spawn(function()
		for i, inter in pairs(mainInterface:GetDescendants()) do
			if inter.Parent then
				if inter.Parent.Name ~= "Transition" then
					if inter:IsA("TextLabel") then
						show(inter, {TextTransparency = 0})
					elseif inter:IsA("Frame") then
						if inter.Name ~= "Answers" then
							show(inter, {BackgroundTransparency = 0})
						end
					end
				end 
			end
		end
	end)
	
	for i, tas in pairs(lobby.Frame.Questionare.Answers:GetChildren()) do
		if tas:IsA("TextButton") then
			tas:Destroy()
		end
	end
	
	mainInterface.Questions.Text = "Question " .. question .. "/35"
	mainInterface.Title.Text = Questions[question].Title
	task.spawn(function()
		local track2 = TweenService:Create(mainInterface.Bar.Fill, TweenInfo.new(0.5), {Size = UDim2.new(question / 35,0,1,0)})
		track2:Play()
	end)
	
	for i, qustionTempl in pairs(Questions[question].Answers) do
		local template = script.Template:Clone()
		local endSize = template.Size
		local sizeup = endSize + UDim2.new(0.02, 0, 0.02, 0)
		local sizedown = endSize
		
		template.Parent = lobby.Frame.Questionare.Answers
		template.Text = i
		template.Name = i
		
		template.MouseEnter:Connect(function()
			_animates.resizeUp(template, sizeup)
			game.SoundService.hover:Play()
		end)
		
		template.MouseLeave:Connect(function()
			_animates.resizeDown(template, sizedown)
		end)
		
		template.InputBegan:Connect(function(inp)
			if inp.UserInputType == Enum.UserInputType.MouseButton1 then
				_animates.resizeDown(template, sizedown)
			end
		end)

		template.InputEnded:Connect(function(inp)
			if inp.UserInputType == Enum.UserInputType.MouseButton1 then
				_animates.resizeUp(template, sizeup)
				print("gel;op")
				game.SoundService.click:Play()
				for _, btns in pairs(lobby.Frame.Questionare.Answers:GetChildren()) do
					if btns:IsA("TextButton") then
						btns.Interactable = false
						if btns.Name == i then
							local track = TweenService:Create(btns, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.337255, 0.25098, 1), BackgroundTransparency = 0.7})
							track:Play()
							btns.Size = btns.Size + UDim2.new(0.2,0,0.2,0)
						else
							local track = TweenService:Create(btns, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.8})
							track:Play()
						end
					end
				end
				
				if question == 3 then
					FakeTimer.launch()

					task.spawn(function()
						for i, inter in pairs(lobby.Frame.FakeTimer:GetDescendants()) do
							if inter.Name ~= "Buttons" then
								if inter:IsA("TextLabel") then
									show(inter, {TextTransparency = 0})
								elseif inter:IsA("Frame") then
									if inter.Name ~= "Answers" then
										show(inter, {BackgroundTransparency = 0})
									end
								elseif inter:IsA("TextButton") then
									if inter.Name ~= "Answers" then
										show(inter, {BackgroundTransparency = 0, TextTransparency = 0})
										inter.Interactable = true
									end
								elseif inter:IsA("UIStroke") then
									if inter.Name ~= "Answers" then
										show(inter, {Transparency = 0})
									end
								end
							end
						end
					end)

					task.spawn(function()
						for i, inter in pairs(mainInterface:GetDescendants()) do
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
							end
						end
					end)
				else
					task.spawn(function()
						task.wait(0.09)
						module.TransitionBetween(qustionTempl)
					end)
				end
				
			end
		end)
		
	end
	
end

function module.load()
	script.Parent.questionarecome.Value = true
	local lobbyInterface = lobby.Frame.Lobby
	
	local function hide(inter, tohide)
		local track = TweenService:Create(inter, TweenInfo.new(0.2), tohide)
		track:Play()
		task.wait(0.08)
	end
	
	task.spawn(function()
		for i, inter in pairs(lobbyInterface:GetChildren()) do
			hide(inter, {TextTransparency = 1})
		end
	end)
	
	hide(lobby.Frame.Buttins.Start, {TextTransparency = 1, BackgroundTransparency = 1})
	lobby.Frame.Buttins.Start.Interactable = false
	
	task.wait(0.2)
	
	module.showUpQuest()
end

function module.reload()
	local function show(inter, tohide)
		local track = TweenService:Create(inter, TweenInfo.new(0.2), tohide)
		track:Play()
		task.wait(0.08)
	end
	question = 0
	script.Parent.Corrects.Value = 0
	task.spawn(function()
		for i, inter in pairs(lobby.Frame.Results:GetDescendants()) do
			if inter:IsA("TextLabel") then
				show(inter, {TextTransparency =1})
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
		end
	end)
	module.load()
end

return module
