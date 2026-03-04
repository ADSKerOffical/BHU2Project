local ishk, isfhk = clonefunction(ishooked), clonefunction(isfunctionhooked)
getgenv().ishooked = newcclosure(function() return false end)
getgenv().isfunctionhooked = newcclosure(function() return false end)
local currentEnvironment = getfenv(0).script

local randomstring = newcclosure(function()
local chars = "abcdefjguiopqkltywszxvnmh1234567890ABCDEFJILPOYTRWQSGHKZXVNM"
  local text = ""
  for _ = 1, 100 do
    local random = math.random(1, string.len(chars))
    local char = string.sub(chars, random, random)
    text = text .. char 
  end
  return text
end)

coroutine.wrap(newcclosure(function()
local HttpSpy = cloneref(Instance.new("ScreenGui"))
HttpSpy.Name = randomstring()
HttpSpy.Parent = (gethui and cloneref(gethui())) or cloneref(game:GetService("CoreGui"))
HttpSpy.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HttpSpy.ResetOnSpawn = false

local hook; hook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
  if compareinstances(self, game) and (getnamecallmethod() == "Destroy" or getnamecallmethod() == "Remove") and not compareinstances(getfenv(0).script, currentEnvironment) then
    return nil
  end
  return hook(self, ...)
end))

local hook; hook = hookfunction((restorefunction or restorefunc), newcclosure(function(func)
  if not compareinstances(getfenv(0).script, currentEnvironment) then
    if func == getrawmetatable(game)["__namecall"] or func == ishooked or func == isfunctionhooked then
      return
    end 
  end
  return hook(func)
end))

HttpSpy.DescendantAdded:Connect(function(class)
  class.Name = randomstring()
end)

HttpSpy.Destroying:Connect(function()
  getgenv().ishooked = ishk
  getgenv().isfunctionhooked = isfhk
end)

local Background = cloneref(Instance.new("Frame"))
Background.Name = "Background"
Background.Parent = HttpSpy
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.140
Background.BorderColor3 = Color3.fromRGB(139, 139, 139)
Background.BorderSizePixel = 0
Background.Position = UDim2.new(0.506695807, 0, 0.56610918, 0)
Background.Size = UDim2.new(0, 402, 0, 262)
Background.Active = true
Background.Draggable = true

local Topbar = cloneref(Instance.new("Frame"))
Topbar.Name = "Topbar"
Topbar.Parent = Background
Topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Topbar.BackgroundTransparency = 1.000
Topbar.Size = UDim2.new(1, 0, 0, 25)

local Icon = cloneref(Instance.new("ImageLabel"))
Icon.Name = "Icon"
Icon.Parent = Topbar
Icon.AnchorPoint = Vector2.new(0, 0.5)
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1.000
Icon.Position = UDim2.new(0, 10, 0.5, 0)
Icon.Size = UDim2.new(0, 13, 0, 13)
Icon.Image = "rbxgameasset://Images/menuIcon"

local Exit = cloneref(Instance.new("TextButton"))
Exit.Name = "Exit"
Exit.Parent = Topbar
Exit.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
Exit.BackgroundTransparency = 0.180
Exit.BorderSizePixel = 0
Exit.Position = UDim2.new(0.870000005, 0, 0, 0)
Exit.Size = UDim2.new(-0.00899999961, 40, 1.04299998, -10)
Exit.Font = Enum.Font.Gotham
Exit.Text = "X"
Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
Exit.TextSize = 13.000

Exit.MouseButton1Click:Connect(function()
  HttpSpy:Destroy()
end)

local Close = cloneref(Exit:Clone())
Close.Parent = Topbar
Close.Text = "-"
Close.Position = UDim2.new(0.73, 0, 0, 0)
Close.TextSize = 18.000

local Men = cloneref(Instance.new("TextButton", HttpSpy))
Men.Visible = false
Men.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
Men.BackgroundTransparency = 0.18
Men.Font = Enum.Font.Gotham
Men.Text = "+"
Men.Position = UDim2.new(0.8, 0, 0, 0)
Men.Size = UDim2.new(0.1, 0, 0.1, 0)
Men.Active = true
Men.TextScaled = true
Men.Draggable = true
Men.TextColor3 = Color3.new(1, 1, 1)

Men.MouseButton1Click:Connect(function()
  Background.Visible = true
  Men.Visible = false
end)

Close.MouseButton1Click:Connect(function()
  Background.Visible = false
  Men.Visible = true
end)

local ImageLabel = cloneref(Instance.new("ImageLabel"))
ImageLabel.Parent = Exit
ImageLabel.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Position = UDim2.new(0.999998331, 0, 0, 0)
ImageLabel.Size = UDim2.new(0, 9, 0, 16)
ImageLabel.Image = "http://www.roblox.com/asset/?id=8650484523"
ImageLabel.ImageColor3 = Color3.fromRGB(12, 4, 20)
ImageLabel.ImageTransparency = 0.180

local MainContainer = cloneref(Instance.new("ScrollingFrame"))
MainContainer.Name = "MainContainer"
MainContainer.Parent = Background
MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
MainContainer.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
MainContainer.BackgroundTransparency = 0.180
MainContainer.BorderColor3 = Color3.fromRGB(16, 16, 16)
MainContainer.BorderSizePixel = 0
MainContainer.Position = UDim2.new(0.5, 0, 0.540076315, 0)
MainContainer.Size = UDim2.new(1, -10, 0.91984731, -10)
MainContainer.BottomImage = "rbxgameasset://Images/scrollBottom (1)"
MainContainer.MidImage = "rbxgameasset://Images/scrollMid"
MainContainer.ScrollBarThickness = 4
MainContainer.TopImage = "rbxgameasset://Images/scrollTop"
MainContainer.AutomaticCanvasSize = "XY"

local Minimize = cloneref(Instance.new("ImageButton"))
Minimize.Name = "Minimize"
Minimize.Parent = Topbar
Minimize.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
Minimize.BackgroundTransparency = 0.180
Minimize.BorderSizePixel = 0
Minimize.Position = UDim2.new(0.804174006, 0, 0, 0)
Minimize.Size = UDim2.new(0.00100000005, 27, 1.04299998, -10)
Minimize.Image = "rbxassetid://110016091132925"

Minimize.MouseButton1Click:Connect(function()
 for _, object in ipairs(MainContainer:GetDescendants()) do
  if object:IsA("TextButton") then
    object:Destroy()
  end
 end
end)

local ImageLabel_2 = cloneref(Instance.new("ImageLabel"))
ImageLabel_2.Parent = Minimize
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_2.BackgroundTransparency = 1.000
ImageLabel_2.Position = UDim2.new(-0.455000013, 1, 0, 0)
ImageLabel_2.Size = UDim2.new(0, 12, 0, 16)
ImageLabel_2.Image = "http://www.roblox.com/asset/?id=10555881849"
ImageLabel_2.ImageColor3 = Color3.fromRGB(12, 4, 20)
ImageLabel_2.ImageTransparency = 0.180

local TopBar = cloneref(Instance.new("Frame"))
TopBar.Name = "TopBar"
TopBar.Parent = Topbar
TopBar.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
TopBar.BackgroundTransparency = 0.180
TopBar.BorderSizePixel = 0
TopBar.Position = UDim2.new(0.268202901, 0, -0.00052294743, 0)
TopBar.Size = UDim2.new(0, 186, 0, 16)

local ImageLabel_3 = cloneref(Instance.new("ImageLabel"))
ImageLabel_3.Parent = TopBar
ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_3.BackgroundTransparency = 1.000
ImageLabel_3.Position = UDim2.new(0.999999642, 0, -0.00046946716, 0)
ImageLabel_3.Size = UDim2.new(0, 14, 0, 16)
ImageLabel_3.Image = "http://www.roblox.com/asset/?id=8650484523"
ImageLabel_3.ImageColor3 = Color3.fromRGB(12, 4, 20)
ImageLabel_3.ImageTransparency = 0.180

local ImageLabel_4 = cloneref(Instance.new("ImageLabel"))
ImageLabel_4.Parent = TopBar
ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_4.BackgroundTransparency = 1.000
ImageLabel_4.Position = UDim2.new(-0.0817726701, 0, 0, 0)
ImageLabel_4.Size = UDim2.new(0, 16, 0, 16)
ImageLabel_4.Image = "http://www.roblox.com/asset/?id=10555881849"
ImageLabel_4.ImageColor3 = Color3.fromRGB(12, 4, 20)
ImageLabel_4.ImageTransparency = 0.180

local Title = cloneref(Instance.new("TextLabel"))
Title.Name = "Title"
Title.Parent = TopBar
Title.AnchorPoint = Vector2.new(0, 0.5)
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderSizePixel = 0
Title.Position = UDim2.new(-0.150533721, 32, 0.415876389, 0)
Title.Size = UDim2.new(0.522161067, 80, 1.11675644, -7)
Title.Font = Enum.Font.SourceSansLight
Title.Text = "Http Spy by ADSKer"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 17.000
Title.TextWrapped = true

local UICorner = cloneref(Instance.new("UICorner"))
UICorner.CornerRadius = UDim.new(0, 9)
UICorner.Parent = Background

local UIListLayout = cloneref(Instance.new("UIListLayout"))
UIListLayout.Parent = MainContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)

local UICorner_2 = cloneref(Instance.new("UICorner"))
UICorner_2.Parent = MainContainer

MainContainer.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
  MainContainer.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end)

local Log = newcclosure(function(text, headers)
  local TemplateText = cloneref(Instance.new("TextButton", MainContainer))
  TemplateText.Name = "TemplateText"
  TemplateText.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  TemplateText.BackgroundTransparency = 0.7
  TemplateText.BorderSizePixel = 0
  TemplateText.Text = text
  TemplateText.Position = UDim2.new(3.75832236e-08, 0, 0, 0)
  TemplateText.Size = UDim2.new(1.00000012, 0, 0, 20)
  TemplateText.Font = Enum.Font.SourceSansSemibold
  TemplateText.TextColor3 = Color3.fromRGB(255, 255, 255)
  TemplateText.TextScaled = true
  TemplateText.TextSize = 14.000
  TemplateText.TextWrapped = true
  TemplateText.TextXAlignment = Enum.TextXAlignment.Center
  TemplateText.TextYAlignment = Enum.TextYAlignment.Center
    if headers and type(headers) == "table" then 
     TemplateText.Text = TemplateText.Text .. " (HEADERS:"
     for Index, Value in next, headers do 
       TemplateText.Text = TemplateText.Text.. tostring(Index).. ": "..tostring(Value)
     end
     TemplateText.Text = TemplateText.Text .. ")"
   end
  TemplateText.MouseButton1Click:Connect(function()
    setclipboard(TemplateText.Text)
  end)
end)

local hook; hook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
  if self == game and table.find({"HttpGet", "HttpGetAsync"}, getnamecallmethod()) then
    local args = {...}
    Log(getnamecallmethod() .. ":" .. args[1])
  end
  return hook(self, ...)
end))

for _, func in next, {game.HttpGet, game.HttpGetAsync} do
  local hook; hook = hookfunction(func, newcclosure(function(...)
    local args = {...}
    Log(`{getinfo(func).name}: {args[2]}`)
    return hook(...)
  end))
end

for _, func in {request, http and http.request} do
  local hook1; hook1 = hookfunction(request, function(dat)
    Log("request from: "..dat.Url.." ("..dat.Method..")",dat.Headers)
    return hook1(dat)
  end)
end
end))()
