-- LOS GOIANOS HUB | PUBLIC VERSION
-- Brookhaven

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Proteção
if game:GetService("CoreGui"):FindFirstChild("LosGoianosHUB") then
	game:GetService("CoreGui").LosGoianosHUB:Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LosGoianosHUB"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromScale(0.4,0.5)
main.Position = UDim2.fromScale(0.3,0.25)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

-- RGB
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 0.6) % 360
	stroke.Color = Color3.fromHSV(hue/360,1,1)
end)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.12)
title.BackgroundTransparency = 1
title.Text = "LOS GOIANOS HUB"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)

-- Minimizar
local min = Instance.new("TextButton", main)
min.Size = UDim2.fromScale(0.12,0.08)
min.Position = UDim2.fromScale(0.85,0.02)
min.Text = "_"
min.Font = Enum.Font.GothamBold
min.TextScaled = true
min.BackgroundColor3 = Color3.fromRGB(40,40,40)
min.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", min)

-- Tabs
local tabs = Instance.new("Frame", main)
tabs.Size = UDim2.fromScale(1,0.1)
tabs.Position = UDim2.fromScale(0,0.12)
tabs.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout", tabs)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0,6)

local pages = {}

local function createTab(name)
	local b = Instance.new("TextButton", tabs)
	b.Size = UDim2.fromScale(0.3,1)
	b.Text = name
	b.Font = Enum.Font.Gotham
	b.TextScaled = true
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)

	local page = Instance.new("Frame", main)
	page.Size = UDim2.fromScale(1,0.78)
	page.Position = UDim2.fromScale(0,0.22)
	page.BackgroundTransparency = 1
	page.Visible = false
	pages[name] = page

	local layout = Instance.new("UIListLayout", page)
	layout.Padding = UDim.new(0,8)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	b.MouseButton1Click:Connect(function()
		for _,p in pairs(pages) do p.Visible = false end
		page.Visible = true
	end)

	return page
end

local function button(parent,text,callback)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.fromScale(0.9,0.12)
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextScaled = true
	b.BackgroundColor3 = Color3.fromRGB(30,30,30)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)
	b.MouseButton1Click:Connect(callback)
	return b
end

-- PLAYER
local playerPage = createTab("Player")
button(playerPage,"Speed +",function()
	LocalPlayer.Character.Humanoid.WalkSpeed = 50
end)
button(playerPage,"Jump +",function()
	LocalPlayer.Character.Humanoid.JumpPower = 100
end)

-- TELEPORTES BROOKHAVEN
local tpPage = createTab("Brookhaven")
local function tp(cf)
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character.HumanoidRootPart.CFrame = cf
	end
end

button(tpPage,"Hospital",function() tp(CFrame.new(300,50,-300)) end)
button(tpPage,"Polícia",function() tp(CFrame.new(500,50,-100)) end)
button(tpPage,"Banco",function() tp(CFrame.new(650,50,150)) end)
button(tpPage,"Escola",function() tp(CFrame.new(200,50,200)) end)
button(tpPage,"Prefeitura",function() tp(CFrame.new(100,50,-50)) end)

pages["Player"].Visible = true

min.MouseButton1Click:Connect(function()
	tabs.Visible = not tabs.Visible
	for _,p in pairs(pages) do p.Visible = tabs.Visible end
end)

print("LOS GOIANOS HUB | PUBLIC LOADED")
