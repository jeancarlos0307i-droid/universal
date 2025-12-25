--==================================================
-- CARLIN HUB | UNIVERSAL VERSION (FULL)
--==================================================

local ok, err = pcall(function()

--================ SERVICES =================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LP = Players.LocalPlayer

--================ KEY SYSTEM =================
local KEY_LINK = "https://link-hub.net/2522978/BpUM7NTn9gxm"
local VALID_KEYS = {
	uhdkaklwa=true, waoadlaw=true, waodlmka=true, waljnsakld=true,
	wandlkas=true, waionamrg=true, piaefnmk=true, keyvip=true
}

--================ CLEAN GUI =================
pcall(function()
	if game.CoreGui:FindFirstChild("CarlinKey") then
		game.CoreGui.CarlinKey:Destroy()
	end
end)

--================ KEY GUI =================
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "CarlinKey"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = game.CoreGui

local Main = Instance.new("Frame", KeyGui)
Main.Size = UDim2.fromScale(0.32,0.38)
Main.Position = UDim2.fromScale(0.34,0.3)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.BorderSizePixel = 0
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(0,255,140)
stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.fromScale(1,0.18)
Title.BackgroundTransparency = 1
Title.Text = "🟢 Carlin Hub | Key System"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(0,255,140)

--================ DRAG MODERNO =================
local dragging=false
local dragStart, startPos
local function updateDrag(input)
	local delta = input.Position - dragStart
	Main.Position = UDim2.new(
		startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y
	)
end
Title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		updateDrag(input)
	end
end)

--================ KEY INPUT =================
local Box = Instance.new("TextBox", Main)
Box.Size = UDim2.fromScale(0.85,0.15)
Box.Position = UDim2.fromScale(0.075,0.35)
Box.PlaceholderText = "Cole sua key"
Box.Font = Enum.Font.Gotham
Box.TextSize = 16
Box.TextColor3 = Color3.new(1,1,1)
Box.BackgroundColor3 = Color3.fromRGB(30,30,30)
Box.BorderSizePixel = 0
Instance.new("UICorner", Box)

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.fromScale(1,0.1)
Status.Position = UDim2.fromScale(0,0.8)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.GothamBold
Status.TextSize = 15
Status.Text = ""

local function Button(text,pos,cb)
	local b = Instance.new("TextButton", Main)
	b.Size = UDim2.fromScale(0.38,0.14)
	b.Position = pos
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 15
	b.TextColor3 = Color3.new(0,0,0)
	b.BackgroundColor3 = Color3.fromRGB(0,255,140)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b)
	b.MouseButton1Click:Connect(cb)
end

Button("Pegar Key", UDim2.fromScale(0.08,0.55), function()
	if setclipboard then setclipboard(KEY_LINK) end
	Status.Text = "Link copiado!"
	Status.TextColor3 = Color3.fromRGB(0,255,140)
end)

Button("Verificar", UDim2.fromScale(0.54,0.55), function()
	local k = Box.Text:lower():gsub("%s","")
	if not VALID_KEYS[k] then
		Status.Text = "Key inválida!"
		Status.TextColor3 = Color3.fromRGB(255,0,0)
		return
	end

	Status.Text = "Key válida!"
	Status.TextColor3 = Color3.fromRGB(0,255,140)
	task.wait(0.5)
	KeyGui:Destroy()

	--================ RAYFIELD =================
	local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()
	local Window = Rayfield:CreateWindow({
		Name="🟢 Carlin Hub",
		LoadingTitle="Carlin Hub",
		LoadingSubtitle="Universal Version",
		ConfigurationSaving={Enabled=false}
	})

	--================ PLAYER TAB =================
	local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
	PlayerTab:CreateSlider({
		Name="WalkSpeed", Range={16,200}, CurrentValue=16,
		Callback=function(v)
			local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
			if h then h.WalkSpeed=v end
		end
	})
	PlayerTab:CreateSlider({
		Name="JumpPower", Range={50,300}, CurrentValue=50,
		Callback=function(v)
			local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
			if h then h.JumpPower=v end
		end
	})
	PlayerTab:CreateSlider({
		Name="Gravity", Range={0,196}, CurrentValue=workspace.Gravity,
		Callback=function(v) workspace.Gravity=v end
	})

	--================ MOVEMENT TAB =================
	local MoveTab = Window:CreateTab("🏃 Movement", 4483362458)

	local Noclip=false
	MoveTab:CreateToggle({
		Name="Noclip", CurrentValue=false,
		Callback=function(v) Noclip=v end
	})
	RunService.Stepped:Connect(function()
		if Noclip and LP.Character then
			for _,p in ipairs(LP.Character:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide=false end
			end
		end
	end)

	local ClickTP=false
	MoveTab:CreateToggle({
		Name="Click TP", CurrentValue=false,
		Callback=function(v) ClickTP=v end
	})
	UIS.InputBegan:Connect(function(i,gp)
		if gp then return end
		if ClickTP and i.UserInputType==Enum.UserInputType.MouseButton1 then
			local m=LP:GetMouse()
			if m.Hit and LP.Character then LP.Character:MoveTo(m.Hit.p) end
		end
	end)

	local Fly=false
	local BV
	MoveTab:CreateToggle({
		Name="Fly", CurrentValue=false,
		Callback=function(v)
			Fly=v
			if not v and BV then BV:Destroy(); BV=nil end
		end
	})
	RunService.RenderStepped:Connect(function()
		if Fly and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
			local hrp=LP.Character.HumanoidRootPart
			if not BV then
				BV=Instance.new("BodyVelocity",hrp)
				BV.MaxForce=Vector3.new(1e9,1e9,1e9)
			end
			BV.Velocity=Camera.CFrame.LookVector*60
		end
	end)

	--================ HACK MOD TAB =================
	local HackTab = Window:CreateTab("💀 Hack Mod", 4483362458)

	-- Aimbot
	local Aimbot=false
	local AimbotKey=Enum.KeyCode.E
	local AimbotToggle = HackTab:CreateToggle({
		Name="Aimbot (Closest)", CurrentValue=false,
		Callback=function(v) Aimbot=v end
	})
	HackTab:CreateInput({
		Name="Aimbot Key (letra)", PlaceholderText="Ex: E",
		RemoveTextAfterFocusLost=true,
		Callback=function(txt)
			txt=txt:upper()
			if Enum.KeyCode[txt] then AimbotKey=Enum.KeyCode[txt] end
		end
	})
	UIS.InputBegan:Connect(function(input,gp)
		if gp then return end
		if input.KeyCode==AimbotKey then
			Aimbot=not Aimbot
			AimbotToggle:Set(Aimbot)
		end
	end)
	local function ClosestTarget()
		local hrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local c,d=nil,math.huge
		for _,p in ipairs(Players:GetPlayers()) do
			if p~=LP and p.Character and p.Character:FindFirstChild("Head") then
				local dist=(p.Character.Head.Position-hrp.Position).Magnitude
				if dist<d then d=dist; c=p.Character.Head end
			end
		end
		return c
	end
	RunService.RenderStepped:Connect(function()
		if Aimbot then
			local t=ClosestTarget()
			if t then Camera.CFrame=CFrame.new(Camera.CFrame.Position,t.Position) end
		end
	end)

	--================ ESP TAB =================
	local ESP=false
	local Tracer=false
	local ESPColor=Color3.fromRGB(255,0,0)
	local Cache={}
	local Bones={
		{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
		{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
		{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
		{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
		{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}
	}
	HackTab:CreateToggle({Name="ESP Skeleton",CurrentValue=false,Callback=function(v) ESP=v end})
	HackTab:CreateToggle({Name="Tracers",CurrentValue=false,Callback=function(v) Tracer=v end})
	HackTab:CreateColorPicker({Name="ESP Color",Color=ESPColor,Callback=function(c) ESPColor=c end})

	RunService.RenderStepped:Connect(function()
		local myHRP=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		for _,plr in ipairs(Players:GetPlayers()) do
			if plr~=LP and plr.Character and myHRP then
				if not Cache[plr] then
					Cache[plr]={lines={},name=Drawing.new("Text"),tracer=Drawing.new("Line")}
					for i=1,#Bones do
						local l=Drawing.new("Line"); l.Thickness=2; Cache[plr].lines[i]=l
					end
					Cache[plr].name.Center=true
					Cache[plr].name.Outline=true
					Cache[plr].name.Size=14
					Cache[plr].tracer.Thickness=1.5
				end
				local char=plr.Character
				local data=Cache[plr]

				local head=char:FindFirstChild("Head")
				if head then
					local p,v=Camera:WorldToViewportPoint(head.Position+Vector3.new(0,1.6,0))
					data.name.Visible=ESP and v
					data.name.Text=plr.Name
					data.name.Position=Vector2.new(p.X,p.Y)
					data.name.Color=ESPColor
				end

				for i,b in ipairs(Bones) do
					local p1=char:FindFirstChild(b[1])
					local p2=char:FindFirstChild(b[2])
					local l=data.lines[i]
					if p1 and p2 then
						local s1,v1=Camera:WorldToViewportPoint(p1.Position)
						local s2,v2=Camera:WorldToViewportPoint(p2.Position)
						l.Visible=ESP and v1 and v2
						l.From=Vector2.new(s1.X,s1.Y)
						l.To=Vector2.new(s2.X,s2.Y)
						l.Color=ESPColor
					else
						l.Visible=false
					end
				end

				local hrp=char:FindFirstChild("HumanoidRootPart")
				if hrp then
					local f,v1=Camera:WorldToViewportPoint(myHRP.Position)
					local t,v2=Camera:WorldToViewportPoint(hrp.Position)
					data.tracer.Visible=Tracer and v1 and v2
					data.tracer.From=Vector2.new(f.X,f.Y)
					data.tracer.To=Vector2.new(t.X,t.Y)
					data.tracer.Color=ESPColor
				else
					data.tracer.Visible=false
				end
			end
		end
	end)
end)

print("CARLIN HUB CARREGADO COM SUCESSO")

end)

if not ok then
	warn("ERRO NO CARLIN HUB:", err)
end

end)

	end
end)
