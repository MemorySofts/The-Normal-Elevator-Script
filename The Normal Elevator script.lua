--made by MemorySofts team

local plr = game:GetService("Players").LocalPlayer

function getRoot(char) return char:FindFirstChild('HumanoidRootPart') end

local cage

do
	local folder = Instance.new("Folder", workspace)
	folder.Name = "Клетка (MemorySofts)"

	cageModel = folder

	local offset = Vector3.new(math.random(-100000, 100000), math.random(-50,1500), math.random(-100000,100000))
	local floor = Instance.new("Part", folder)
	local wall1 = Instance.new("Part", folder)
	local wall2 = Instance.new("Part", folder)
	local wall3 = Instance.new("Part", folder)
	local wall4 = Instance.new("Part", folder)
	local ceiling = Instance.new("Part", folder)
	local light = Instance.new("PointLight", ceiling)

	local parts = {floor, wall1, wall2, wall3, wall4, ceiling}

	for _, part in ipairs(parts) do
		part.Anchored = true
		part.Transparency = 0.4
		part.Position = offset
		part.Color = Color3.fromRGB(79, 79, 79)
		part.Name = "t.me/MemorySofts"
	end

	floor.Position += Vector3.new(0, 0, 0)
	floor.Size = Vector3.new(10,1,10)

	wall1.Position += Vector3.new(5, 5, 0)
	wall1.Size = Vector3.new(1, 10, 10)

	wall2.Position += Vector3.new(-5, 5, 0)
	wall2.Size = Vector3.new(1, 10, 10)

	wall3.Position += Vector3.new(0, 5, -5)
	wall3.Size = Vector3.new(10, 10, 1)

	wall4.Position += Vector3.new(0, 5, 5)
	wall4.Size = Vector3.new(10, 10, 1)

	ceiling.Position += Vector3.new(0, 10, 0)
	ceiling.Size = Vector3.new(10,1,10)

	light.Range = 20
	light.Brightness = 10
	light.Shadows = false

	local frame = offset + Vector3.new(0,4,0)
	CagePosition = CFrame.new(frame)
end

local GC = getconnections or get_signal_cons
if GC then
	for _,v in pairs(GC(plr.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	plr.Idled:Connect(function()
		local VirtualUser = game:GetService("VirtualUser")
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end

local g = {}
local defaults = {autofarm = false}
if getgenv then
	getgenv().n7 = defaults
	g = getgenv()
else
	g.n7 = defaults
	task.spawn(function()
		local m=Instance.new("Message", workspace)
		local txt="MemorySofts | ПРЕДУПРЕЖДЕНИЕ\n\nВаш эксплойт НЕ поддерживает функцию getgenv!\nЭто может привести к риску бана (не в этой игре и не с этим скриптом)\nСкрипт MemorySofts будет загружен.\n\n"
		m.Text=txt
		for i=15,0,-1 do
			m.Text=txt..i
			task.wait(1)
		end
		m:Destroy()
	end)
end

local Fluent = loadstring(game:HttpGet("https://twix.cyou/Fluent.txt", true))()

local Window = Fluent:CreateWindow({
	Title = "MemorySofts",
	SubTitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
	TabWidth = 30,
	Size = UDim2.fromOffset(370, 280),
	Acrylic = false,
	Theme = "Dark"
})

local Tabs = {
	Main = Window:AddTab({ Title = "Главное", Icon = "factory" }),
	Settings = Window:AddTab({ Title = "Настройки", Icon = "settings" }),
	Credits = Window:AddTab({ Title = "Авторы", Icon = "person-standing" })
}

local autofarm = Tabs.Main:AddToggle("Autofarm", { Title = "(AFK) Автофарм", Default = false})
autofarm:OnChanged(function(Value)
	g.n7.autofarm = Value
	if g.n7.autofarm then
		local char = plr.Character
		do local _=plr.Character:WaitForChild("HumanoidRootPart") end
		if char and getRoot(char) then
			getRoot(char).CFrame = workspace.Lobby.Elevator.Trigger.CFrame
			task.wait(4)
		end
		while g.n7.autofarm do
			getRoot(char).CFrame = cage
			game:GetService("RunService").Heartbeat:Wait()
		end
	end
end)

local UISection = Tabs.Settings:AddSection("Интерфейс")
UISection:AddDropdown("InterfaceTheme", {
	Title = "Тема",
	Values = Fluent.Themes,
	Default = Fluent.Theme,
	Callback = function(Value)
		Fluent:SetTheme(Value)
	end
})

UISection:AddToggle("TransparentToggle", {
	Title = "Прозрачность",
	Description = "Делает интерфейс прозрачным",
	Default = Fluent.Transparency,
	Callback = function(Value)
		Fluent:ToggleTransparency(Value)
	end
})

UISection:AddKeybind("MinimizeKeybind", {
	Title = "Кнопка сворачивания",
	Description = "Изменить клавишу",
	Default = "RightShift"
})
Fluent.MinimizeKeybind = Fluent.Options.MinimizeKeybind

Tabs.Credits:AddParagraph({
	Title = "MemorySofts",
	Content = "Скрипт написан zepuxl"
})

Tabs.Credits:AddButton({
	Title = "Открыть Telegram канал",
	Description = "MemorySofts в Telegram",
	Callback = function()
		Fluent:Notify({
			Title = "t.me/MemorySofts",
			Content = "Наш Telegram-канал",
			Duration = 20
		})
	end
})

Window:SelectTab(1)

Fluent:Notify({
	Title = "MemorySofts | Загружено",
	Content = "Скрипт успешно загружен.",
	Duration = 8
})

repeat task.wait(0.5) until Fluent.Unloaded
g.n7 = nil
