local player = game.Players.LocalPlayer
local PlayerGui = player.PlayerGui
local lobby = PlayerGui:WaitForChild("lobby")
local TweenService = game:GetService("TweenService")
local Questions = require(script.Parent.Questions)
local _animates = require(script.Parent.Parent._animates)
local FakeTimer = require(script.Parent.FakeTimer)
local transit
local module = {}

function module.showUpQuest(question)
	local mainInterface = lobby.Frame.Review

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
					elseif inter:IsA("TextButton") then
						if inter.Name ~= "Answers" then
							show(inter, {BackgroundTransparency = 0, TextTransparency = 0})
						end
					end
				end 
			end
		end
	end)

	for i, tas in pairs(lobby.Frame.Review.Answers:GetChildren()) do
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

		template.Parent = lobby.Frame.Review.Answers
		template.Text = i
		template.Name = i

		if qustionTempl == true then
			template.BackgroundColor3 = Color3.new(0.27, 1, 0.47)
		end

	end

end

function module.returnup()
	local results = lobby.Frame.Results
	local function show(inter, tohide)
		local track = TweenService:Create(inter, TweenInfo.new(0.2), tohide)
		track:Play()
		task.wait(0.08)
	end
	
	task.spawn(function()
		for i, inter in pairs(lobby.Frame.Review:GetDescendants()) do
			task.spawn(function()
				if inter.Parent then
					if inter.Parent.Name ~= "Transition" then
						if inter:IsA("TextLabel") then
							show(inter, {TextTransparency = 1})
						elseif inter:IsA("Frame") then
							if inter.Name ~= "Answers" then
								show(inter, {BackgroundTransparency = 1})
							end
						elseif inter:IsA("TextButton") then
							if inter.Name ~= "Answers" then
								inter.Interactable = true
								show(inter, {BackgroundTransparency = 1, TextTransparency = 1})
							end
						elseif inter:IsA("UIStroke") then
							if inter.Name ~= "Answers" then
								show(inter, {Transparency = 1})
							end
						end
					end 
				end
				task.wait(0.03)
			end)
		end
	end)
	task.wait(1)
	
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
					inter.Interactable = true
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
