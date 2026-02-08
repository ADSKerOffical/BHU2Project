local BudgieHub = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
BudgieHub:ToggleTransparency(false)

local Window = BudgieHub:CreateWindow({
    Title = "Budgie Hub Universal 2 Alpha",
    SubTitle = "by ADSKer",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local BHU2_Icon = Instance.new("ImageButton", BHU2 or Instance.new("ScreenGui", game.CoreGui))
BHU2_Icon.Size = UDim2.new(0, math.floor(math.max(32, math.min(game.Players.LocalPlayer:GetMouse().ViewSizeX, game.Players.LocalPlayer:GetMouse().ViewSizeY) * 0.15)), 0, math.floor(math.max(32, math.min(game.Players.LocalPlayer:GetMouse().ViewSizeX, game.Players.LocalPlayer:GetMouse().ViewSizeY) * 0.15)))
BHU2_Icon.BackgroundColor3 = Color3.new(0.075, 0.075, 0.075)
BHU2_Icon.Image = "rbxassetid://126371842393375"
BHU2_Icon.BorderSizePixel = 0
BHU2_Icon.Draggable = true

BHU2_Icon_Corner = Instance.new("UICorner", BHU2_Icon)
BHU2_Icon_Corner.CornerRadius = UDim.new(0.2, 0)

BHU2_Icon:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
  local SSx, SSy = game.Players.LocalPlayer:GetMouse().ViewSizeX, game.Players.LocalPlayer:GetMouse().ViewSizeY * 1.1
  local xval, yval = BHU2_Icon.AbsolutePosition.X, BHU2_Icon.AbsolutePosition.Y
  if (xval + BHU2_Icon.AbsoluteSize.X) >= SSx then
    xval = SSx - BHU2_Icon.AbsoluteSize.X
  elseif (yval + BHU2_Icon.AbsoluteSize.Y) >= SSy then
    yval = SSy - BHU2_Icon.AbsoluteSize.Y
  end
  
  xval = (xval < 0 and 0) or xval
  yval = (yval < 0 and 0) or yval
  
  BHU2_Icon.Position = UDim2.new(0, math.floor(xval), 0, math.floor(yval))
end)

BHU2_Icon.MouseButton1Click:Connect(function()
  Window.Root.Visible = not Window.Root.Visible
end)

Window.Root.Parent.Destroying:Connect(function()
  BHU2_Icon:Destroy()
end)

getgenv().isnetworkowner = newcclosure(function(part: BasePart)
  return (part.ReceiveAge == 0 and gethiddenproperty(part, "NetworkIsSleeping") == false)
end)

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "rbxassetid://6523858394" }),
    Finders = Window:AddTab({Title = "Dev Tools", Icon = "rbxassetid://12392897830"}),
    Extra = Window:AddTab({Title = "Extra", Icon = "rbxassetid://71023809654860"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local ToolControl = Tabs.Main:AddSection("Tool Control")

local search
for _, w in next, Window.Root:GetDescendants() do
  if w:IsA("TextLabel") and w.Text == "Tool Control" then
     search = Instance.new("TextBox", w.Parent.Parent)
     search.Size = UDim2.new(1, 0, 0, 50)
     search.Position = UDim2.new(0.4, 0, 0.2, 0)
     search.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
     search.Text = ""
     search.TextSize *= 1.35
     search.BackgroundTransparency = 0.2
     search.TextColor3 = Color3.new(1, 1, 1)
     search.PlaceholderColor3 = Color3.new(0.75, 0.75, 0.75)
     search.ClearTextOnFocus = false
     search.PlaceholderText = "Search section or functions"
     
     search.FocusLost:Connect(function(enterPress)
       if string.len(search.Text) >= 75 then 
         search.Text = "" 
       end
       if enterPress then
         for _, ke in search.Parent:GetDescendants() do
           if ke:IsA("TextLabel") then
             ke.Parent.Parent.Visible = true
           end
         end
         
         for _, textl in next, search.Parent:GetDescendants() do
           if textl:IsA("TextLabel") and not string.find(textl.Text:lower(), search.Text:lower()) and textl.Parent:IsA("Frame") and textl.Parent.Parent:IsA("TextButton") then
             textl.Parent.Parent.Visible = false
          end
        end
         
         if search.Text == "" then
           for _, ke in next, search.Parent:GetDescendants() do
             if ke:IsA("TextLabel") then
               ke.Parent.Parent.Visible = true
             end
           end
         end
         Window:SelectTab(1)
       end
     end)
     break
  end
end

local Toggle = ToolControl:AddToggle("ToolControl", {
    Title = "Tool: Damage all players", 
    Description = "This function using method with TouchTransmitter. This doesn\'t work in all places. Tool, Players",
    Default = false,
    Type = "ToolControl",
    Callback = function(state)
	  aaa = state 
	  while aaa and game:GetService("RunService").RenderStepped:Wait() do
    pcall(function()
        local p = game.Players:GetPlayers()
        for i = 2, #p do local v = p[i].Character
            local LP = game.Players.LocalPlayer
            local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
                for i, v in next, v:GetChildren() do
                    if v:IsA("BasePart") then
                        for _, part in next, tool:GetDescendants() do
                            if part:IsA("BasePart") and part:FindFirstChild("TouchInterest") then
                                firetouchinterest(part, v, 0)
                                firetouchinterest(part, v, 1)
                            end
                        end
                    end
                end
            end
        end
    end)
end
    end 
})

local Toggle = ToolControl:AddToggle("ToolControl", {
    Title = "Tool: Damage all NPC\'s", 
    Description = "This function uses the same method with TouchTransmitter. Doesn\'t work in all places. Tool, NPC",
    Default = false,
    Callback = function(state)
	ooj = state
while ooj and game:GetService("RunService").RenderStepped:Wait() do
    local LP = game:GetService("Players").LocalPlayer
local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
                for i, v in next, workspace:GetDescendants() do
                    if v:IsA("Humanoid") and not game:GetService("Players"):GetPlayerFromCharacter(v.Parent) then
                       for i, d in next, v.Parent:GetDescendants() do
                         if d:IsA("BasePart") then
                           for _, part in next, tool:GetDescendants() do
                             if part:IsA("BasePart") then
                              firetouchinterest(part, d, 0)
                              firetouchinterest(part, d, 1)
                            end
                          end
                       end
                    end
                 end
             end
         end
     end
    end 
})

local Toggle = ToolControl:AddToggle("ToolControl", {
    Title = "Tool: Grab tools", 
    Description = "This feature allows you grab all dropped tools in the workspace. Tool",
    Default = false,
    Callback = function(state)
      aac = state
	  while aac and task.wait() do
       for _, tool in next, game.Workspace:GetDescendants() do
  if tool:IsA("Tool") and tool:FindFirstChildWhichIsA("BasePart") and not game.Players:GetPlayerFromCharacter(tool.Parent) then
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), tool:FindFirstChildWhichIsA("BasePart"), 0)
  end
end
     end
    end 
})

ToolControl:AddToggle("Grip", {
    Title = "Tool: Random grip poses",
    Description = "If you have a lot of tools, you can cover yourself with them. Tool, Grip",
    Callback = function(state)
      aje = state
      while aje and task.wait() do
        for _, tool in game.Players.LocalPlayer.Backpack:GetChildren() do
  if tool:IsA("Tool") then
    coroutine.wrap(function()
    tool.GripPos = Vector3.new(math.random(-math.clamp(#game.Players.LocalPlayer.Backpack:GetChildren(), 1, 50), math.clamp(#game.Players.LocalPlayer.Backpack:GetChildren(), 1, 50)), math.random(-math.clamp(#game.Players.LocalPlayer.Backpack:GetChildren(), 1, 50), math.clamp(#game.Players.LocalPlayer.Backpack:GetChildren(), 1, 50)), math.random(-math.clamp(#game.Players.LocalPlayer.Backpack:GetChildren(), 1, 50), math.clamp(#game.Players.LocalPlayer.Backpack:GetChildren(), 1, 50)))
    tool.Parent = game.Players.LocalPlayer.Character
      task.wait()
    tool.Parent = game.Players.LocalPlayer.Backpack
    end)()
  end
end
  end
    end
})

local TouchControl = Tabs.Main:AddSection("TouchTransmitter/TouchInterest control")

local Toggle = TouchControl:AddToggle("TTIn", {
    Title = "Touch: Touch unanchored part to all players", 
    Description = "With this feature you can easily kill all players if there is an unattached unit with TouchTransmitter next to you. But only if there are no players nearby or you are the closest player to this part. Touch, Kill, Players",
    Default = false,
    Callback = function(state)
    aad = state
 while aad and task.wait() do
 if game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name) and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
  game.Players.LocalPlayer.SimulationRadius = math.huge
  for _, part in next, workspace:GetPartBoundsInRadius(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, 40) do
    if part:FindFirstChild("TouchInterest") then
      for _, player in next, game.Players:GetPlayers() do
         if player ~= game.Players.LocalPlayer and workspace:FindFirstChild(player.Name) then
           for _, parte in next, player.Character:GetChildren() do
             if parte:IsA("BasePart") then
               task.spawn(function()
                 firetouchinterest(part, parte, 0)
                 firetouchinterest(part, parte, 1)
               end)
             end
           end
        end
      end
    end
  end
 end
end
    end 
})

local PlayerControl = Tabs.Main:AddSection("Local Player Control")

local Toggle = PlayerControl:AddToggle("MyToggle", {
    Title = "LocalPlayer: Fling", 
    Description = "You can knock back nearby players and objects if collisions are enabled. LocalPlayer, Fling",
    Default = false,
    Callback = function(state)
     aae = state
      while aae do
  game:GetService("RunService").Heartbeat:Wait()
 local vel = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = vel * 100000 + Vector3.new(0, 100000, 0)
  game:GetService("RunService").RenderStepped:Wait()
   game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = vel
  game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = vel + Vector3.new(0, 0, 0) 
end
    end 
})

PlayerControl:AddToggle("MyToggle", {
  Title = "LocalPlayer: Fling v2",
  Description = "This feature makes all your body parts incredibly fast when you walking, but you don\'t fly away due to BodyVelocity. To stop the fling, just jump or switch humanoid states. LocalPlayer, Fling",
  Default = false,
  Callback = function(Value)
   uue = Value
   local coje = game.Players.LocalPlayer.Character.Humanoid.Running:Connect(function(speed)
  if speed > 0 and game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
   local bv = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
bv.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
bv.P = math.huge

   repeat task.wait()
  bv.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
  game.Players.LocalPlayer.SimulationRadius = math.huge
  if game.Players.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.FallingDown or game.Players.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.PlatformStanding or game.Players.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then
    game.Players.LocalPlayer.Character.Humanoid:ChangeState("GettingUp")
  end
  for _, part in next, game.Players.LocalPlayer.Character:GetDescendants() do
    if part:IsA("BasePart") then
      part.CustomPhysicalProperties = PhysicalProperties.new(100, 0, 0, 0, 0)
      part.AssemblyLinearVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 4000
      part.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 4000
    end
  end
until bv.Parent == nil or game.Players.LocalPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Running
   pcall(function() bv:Destroy() end)
   game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
  end
end)

     task.spawn(function()
       repeat task.wait() until uue == false coje:Disconnect()
     end)
  end
})

local Toggle = PlayerControl:AddToggle("MyToggle", {
    Title = "LocalPlayer: Anti fling", 
    Description = "This feature prevents you from touching players. LocalPlayer, Anti fling",
    Default = false,
    Callback = function(state)
      aaf = state
     while aaf and task.wait() do
       for _, plr in next, game:GetService("Players"):GetPlayers() do
         if plr ~= game:GetService("Players").LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
for _, part in next, plr.Character:GetChildren() do
  if part:IsA("BasePart") then
 part.CanCollide = not jhg
 part.CanTouch = not jhg
 part.AssemblyLinearVelocity = Vector3.zero
 part.AssemblyAngularVelocity = Vector3.zero
 part.Velocity = Vector3.zero
 part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
  end
end
         end
       end
     end
    end 
})

local Toggle = PlayerControl:AddToggle("MyToggle", {
    Title = "LocalPlayer: Anti sit", 
    Description = "You cant sit. LocalPlayer, Anti",
    Default = false,
    Callback = function(state)
      aal = state
while aal and task.wait() do pcall(function() game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled("Seated", not aal) end) end
    end 
})

local Toggle = PlayerControl:AddToggle("MyToggle", {
    Title = "LocalPlayer: Anti void", 
    Description = "This feature prevents you from falling off the map by teleporting you to random spawn location",
    Default = false,
    Callback = function(state)
      local function getrespawn(): Instance
  for _, part in next, workspace:GetDescendants() do
    if part:IsA("SpawnLocation") then
      return part
   end
  end
end

aaj = state
local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()

while aaj and task.wait() do
char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
  if char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.CFrame.Y <= workspace.FallenPartsDestroyHeight + 10 then
    if getrespawn() then
 char.HumanoidRootPart.CFrame = getrespawn().CFrame
 char.HumanoidRootPart.Velocity = Vector3.zero
     else
 char.HumanoidRootPart.CFrame = CFrame.new(0, 0, 0)
 char.HumanoidRootPart.Velocity = Vector3.zero
    end
  end
end
    end 
})

PlayerControl:AddToggle("MyToggle", {
  Title = "LocalPlayer: Anti ragdoll",
  Description = "You turn off ragdoll at least you can walk in ragdoll mode. LocalPlayer, Anti",
  Default = false,
  Callback = function(Value)
     hgg = Value 
  while hgg and task.wait() do
    local humanoid = (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded()) and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if (humanoid:GetState() == Enum.HumanoidStateType.FallingDown or humanoid:GetState() == Enum.HumanoidStateType.Physics or humanoid:GetState() == Enum.HumanoidStateType.Ragdoll or humanoid:GetState() == Enum.HumanoidStateType.PlatformStanding) then
      humanoid:ChangeState("GettingUp")
      humanoid.PlatformStand = false
      humanoid.Parent:MakeJoints()
    end
  end
  end
})

PlayerControl:AddToggle("MyToggle", {
  Title = "LocalPlayer: Anti bang",
  Description = "Teleports you to the void if there is a player nearby with bang animation. LocalPlayer, Anti bang",
  Default = false,
  Callback = function(Value)
    kiudi = Value
     while kiudi and task.wait() do
       for _, player in next, game.Players:GetPlayers() do
         if player ~= game.Players.LocalPlayer and game.Workspace:FindFirstChild(player.Name) and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
           for _, anim in next, player.Character.Humanoid:GetPlayingAnimationTracks() do
              if anim.Animation.AnimationId == "rbxassetid://148840371" or anim.Animation.AnimationId == "rbxassetid://5918726674" then
    game:GetService("RunService").Heartbeat:Wait()
    last_pick_sin_mrazy = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9e8, workspace.FallenPartsDestroyHeight + 1, 9e8) 
    game:GetService("RunService").Heartbeat:Wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pick_sin_mrazy
              end
           end
         end
       end
     end
  end
})

Tabs.Main:AddToggle("MyToggle", {
  Title = "LocalPlayer: Anti bang mode",
  Description = "If the anti bang couldn\'t detect the player\'s animation, but he is attached to you, then you activate this function. LocalPlayer, Anti bang",
  Default = false,
  Callback = function(Value)
     ueuif = Value
while ueuif do
game:GetService("RunService").Heartbeat:Wait()
    last_pick_sin_mrazy = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9e8, workspace.FallenPartsDestroyHeight + 1, 9e8) 
    game:GetService("RunService").Heartbeat:Wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pick_sin_mrazy
              end
  end
})

local PartControl = Tabs.Main:AddSection("Parts Control")

local Toggle = PartControl:AddToggle("Test", {
    Title = "Part: Pusher", 
    Description = "Pushes all nearby parts away from you. Part, Fling",
    Default = false,
    Callback = function(state)
      oppja = state
while oppja and task.wait() do
  if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
  game.Players.LocalPlayer.SimulationRadius = math.huge
local parts = workspace:GetPartBoundsInRadius(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, 35)
  for _, part in ipairs(parts) do
    if part and part.Anchored == false and not part:IsDescendantOf(game.Players.LocalPlayer.Character) and not game.Players:FindFirstChild(part.Parent.Name) then
part.Velocity = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Unit * -800
part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0) 
  if part:FindFirstChild("PrimaryPart") ~= nil and not part.PrimaryPart:IsDescendantOf(game.Players.LocalPlayer.Character) and not part.PrimaryPart.Anchored and not game.Players:FindFirstChild(part.PrimaryPart.Parent.Name) then
     part.Velocity = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - part.PrimaryPart.Position).Unit * -800
  end
  if part:GetRootPart() and not part:GetRootPart():IsDescendantOf(game.Players.LocalPlayer.Character) and not part:GetRootPart().Anchored and not game.Players:FindFirstChild(part:GetRootPart().Parent.Name) then
     part:GetRootPart().Velocity = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - part:GetRootPart().Position).Unit * -800
  end
      end
    end
  end
end   
    end 
})

local Toggle = PartControl:AddToggle("MyToggle", {
    Title = "Part: Anti part fling", 
    Description = "Prevents collision with all parts that do not belong to the local player. Part, Anti",
    Default = false,
    Callback = function(state)
 hueey = state
     while hueey and game:GetService("RunService").PreSimulation:Wait() do
       if game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name) and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
         game.Players.LocalPlayer.SimulationRadius = math.huge
         sethiddenproperty(game.Players.LocalPlayer, "MaxSimulationRadius", math.huge)
         sethiddenproperty(game.Players.LocalPlayer, "MaximumSimulationRadius", math.huge)
         
         for _, part in next, workspace:GetPartBoundsInRadius(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, 50) do
           if part.Anchored == false and not isnetworkowner(part) and part.Velocity.Magnitude >= 5 and not game.Players:GetPlayerFromCharacter(part.Parent) then
              part.Velocity = Vector3.zero
              part.AssemblyLinearVelocity = Vector3.zero
              part.AssemblyAngularVelocity = Vector3.zero
              part.CanCollide = isnetworkowner(part)
              part.CanTouch = isnetworkowner(part)
              part.CanQuery = isnetworkowner(part)
              part.Massless = not isnetworkowner(part)
              part:ResetPropertyToDefault("CustomPhysicalProperties")
              
             for _, mov in next, part:GetDescendants() do
               if mov:IsA("BodyMover") or mov:IsA("Constraint") then
                 mov:Destroy()
               end
             end
           end
         end
       end
     end
    end 
})

local Toggle = PartControl:AddToggle("MyToggle", {
    Title = "Part: Untouchable", 
    Description = "When touching a part signal part.Touched and part.TouchEnded doesn\'t firing. Part",
    Default = false,
    Callback = function(state)
    euh = state
 while euh and task.wait() do
 local LP = game.Players.LocalPlayer
     for _, part in ipairs(LP.Character:GetDescendants()) do
       if part:IsA("BasePart") then
         part.CanTouch = not euh
         part.CanQuery = not euh
       end
     end
   end
    end 
})

PartControl:AddToggle("MyToggle", {
  Title = "Part: X-ray",
  Description = "All parts become transparent. Part, Xray, X-ray",
  Default = false,
  Callback = function(Value)
      xrayen = Value
for _, part in ipairs(workspace:GetDescendants()) do
  if part:IsA("BasePart") and not part.Parent:FindFirstChildOfClass("Humanoid") and part.Parent ~= game.Players.LocalPlayer.Character then
 part.LocalTransparencyModifier = xrayen and 0.6 or 0
  end
end
  end
})

PartControl:AddToggle("MyToggle", {
  Title = "Part: Pull nearby objects towards nearby players",
  Description = "This function attracts nearby unattached objects to nearby players. Part, Players, Attract",
  Default = false,
  Callback = function(Value)
yen = Value
    while yen and task.wait() do
  local humanoids = {}
for _, part in next, workspace:GetPartBoundsInRadius(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, 50) do
    if part.Parent:IsA("Model") and part.Parent:FindFirstChildOfClass("Humanoid") and not part:IsDescendantOf(game.Players.LocalPlayer.Character) and game.Players:GetPlayerFromCharacter(part.Parent) then
      if not table.find(humanoids, part.Parent:FindFirstChildOfClass("Humanoid")) then
        table.insert(humanoids, part.Parent:FindFirstChildOfClass("Humanoid"))
      end
    end
  end

  for _, humanoid in next, humanoids do
    for _, part in next, workspace:GetPartBoundsInRadius(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, 75) do
      if part.Anchored == false and not part:IsDescendantOf(game.Players.LocalPlayer.Character) and not game.Players:GetPlayerFromCharacter(part.Parent) and not part:IsDescendantOf(humanoid.Parent) then
        game.Players.LocalPlayer.SimulationRadius = math.huge
        part.CustomPhysicalProperties = PhysicalProperties.new(100, 0, 0, 0, 0)
        part.CanCollide = false
        part.AssemblyLinearVelocity = (humanoid.RootPart.Position - part.Position).Unit * 500
        part.AssemblyAngularVelocity = Vector3.new(300, 300, 300)
        
        for _, bv in next, part:GetDescendants() do
          if bv:IsA("BodyMover") or bv:IsA("Constraint") then
            bv:Destroy()
          end
        end
      end
    end
  end
end
  end
})

local NPCControl = Tabs.Main:AddSection("NPC\'s control")

NPCControl:AddToggle("MyToggle", {
  Title = "NPC: Kill nearest",
  Description = "Kills nearby entities (does not guarantee). NPC, Kill",
  Default = false,
  Callback = function(Value)
    yoo = Value
while yoo and task.wait() do
 if workspace:FindFirstChild(game.Players.LocalPlayer.Name) and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
   local parts = workspace:GetPartBoundsInRadius(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, 50)
    for _, part in next, parts do
      if part.Anchored == false and not game.Players:GetPlayerFromCharacter(part.Parent) and part.Parent:FindFirstChildOfClass("Humanoid") then
       local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
        game.Players.LocalPlayer.SimulationRadius = math.huge
        
        humanoid.Health = 0
        humanoid:TakeDamage(math.huge)
        humanoid:ChangeState("Dead") 
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 0
        humanoid.JumpHeight = 0
        humanoid.Sit = true
        humanoid.PlatformStand = true
        humanoid.EvaluateStateMachine = false
        humanoid:UnequipTools()
        
        replicatesignal(humanoid.ServerBreakJoints)
        
        for _, part in next, humanoid.Parent:GetDescendants() do
           if part:IsA("BasePart") then
   part.CanCollide = false
   part.CanTouch = false
   sethiddenproperty(part, "LocalSimulationValidation", 0)
   part.Velocity = Vector3.new(0, -1000, 0)
   part.AssemblyAngularVelocity = Vector3.new(0, -1000, 0)
   part.AssemblyLinearVelocity = Vector3.new(0, -1000, 0)
           end
        end
      end
    end
  end
 end
  end
})

NPCControl:AddToggle("MyToggle", {
  Title = "NPC: Push nearest",
  Description = "You push away all nearby NPC from yourself. NPC",
  Default = false,
  Callback = function(Value)
     myyy = Value
while myyy and task.wait() do
 if workspace:FindFirstChild(game.Players.LocalPlayer.Name) and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
   local parts = workspace:GetPartBoundsInRadius(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, 45)
    for _, part in next, parts do
      if part.Anchored == false and not game.Players:GetPlayerFromCharacter(part.Parent) and part.Parent:FindFirstChildOfClass("Humanoid") then
       local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
        game.Players.LocalPlayer.SimulationRadius = math.huge
        humanoid.RootPart.Velocity = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - humanoid.RootPart.Position).Unit * -200
      end
    end
  end
 end
  end
})

NPCControl:AddToggle("Defense", {
  Title = "NPC: Rotate nearest",
  Description = "All nearby entities will revolve around you. NPC",
  Default = false,
  Callback = function(Value)
    oiyj = Value
while oiyj and task.wait() do
 if workspace:FindFirstChild(game.Players.LocalPlayer.Name) and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
   local parts = workspace:GetPartBoundsInRadius(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, 45)
    for _, part in next, parts do
      if part.Anchored == false and not game.Players:GetPlayerFromCharacter(part.Parent) and part.Parent:FindFirstChildOfClass("Humanoid") then
       local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
        game.Players.LocalPlayer.SimulationRadius = math.huge
        humanoid:ChangeState("FallingDown")
        local angle = tick() * 2
        humanoid.RootPart.Velocity = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(20 * math.cos(angle), 0, 20 * math.sin(angle)) - humanoid.RootPart.Position).Unit * 300
      end
    end
  end
 end
  end
})

NPCControl:AddToggle("MyToggle", {
  Title = "NPC: Bug nearest",
  Description = "This function distorts the positions of nearby entities, making them uncontrollable. NPC",
  Default = false,
  Callback = function(Value)
jush = Value
    while jush and task.wait(wait()) do
local humanoids = {}
for _, part in next, workspace:GetPartBoundsInRadius(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart", 10).Position, 75) do
    if part.Parent:IsA("Model") and part.Parent:FindFirstChildOfClass("Humanoid") and not part:IsDescendantOf(game.Players.LocalPlayer.Character) and not game.Players:GetPlayerFromCharacter(part.Parent) then
      if not table.find(humanoids, part.Parent:FindFirstChildOfClass("Humanoid")) then
        table.insert(humanoids, part.Parent:FindFirstChildOfClass("Humanoid"))
      end
    end
  end

  for _, humanoid in next, humanoids do
    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
    humanoid.RootPart.Position = Vector3.new(1000, 1000, 1000)
  end
end
  end
})

local AnimationControl = Tabs.Main:AddSection("Animation Control")

local Dropdown = AnimationControl:AddDropdown("Dropdown", {
    Title = "Animation: Play animation R15",
    Description = "Play animations which I found. Animation",
    Values = {"Sinister dance", "Take L", "Rampage", "Gangam style"},
    Multi = false,
    Default = "...",
})

Dropdown:OnChanged(function(Value)
  local as, res = pcall(function()
    local tabl = {
      ["Sinister dance"] = "rbxassetid://137581268977122",
      ["Take L"] = "rbxassetid://95656304023751",
      ["Rampage"] = "rbxassetid://113913115257328",
      ["Gangam style"] = "rbxassetid://129764254213842"
    }
    for _, anim in next, game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks() do
      anim:Stop()
    end
    local anim = Instance.new("Animation")
    anim.AnimationId = tabl[Value]
    anim.Name = tabl[Value]
    local realanim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
    realanim:Play()
    realanim:AdjustWeight(math.huge)
  end)
end)

AnimationControl:AddButton({
  Title = "Animation: Stop all animations",
  Description = "Stop all animations. Animation",
  Callback = function()
     for i, animation in ipairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
    animation:Stop()
end
  end
})

local Input = AnimationControl:AddInput("Input", {
    Title = "Animation: Load animation",
    Description = "Launch your animation by Content ID",
    Default = "",
    Placeholder = "Id",
    Numeric = true, 
    Finished = true,
    Callback = function(Value)
        local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://" .. tostring(Value)
local realanim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
realanim:Play()
realanim:AdjustWeight(math.huge)
    end
})

local Input = AnimationControl:AddInput("Input", {
    Title = "Animation: Search animation by name",
    Description = "Enter the name of the animation you want to find here, and the program searches the catalog for animations with that name. If a search is successful, a window will appear with five animations you can load. This feature is under development and may have some bugs",
    Default = "",
    Placeholder = "Name",
    Numeric = false,
    Finished = true,
    Callback = function(Value)
        local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Search result"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local Frame = Instance.new("Frame", gui)
Frame.Active = true
Frame.Draggable = true
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(0, 250, 0, 250)
Frame.BackgroundTransparency = 0.1
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.Position = UDim2.new(0.35, 0, 0.2, 0)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(0, 150, 0, 30)
Title.Position = UDim2.new(0, 50, 0, -5)
Title.Text = "Search result"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1

local List = Instance.new("ScrollingFrame", Frame)
List.Size = UDim2.new(0, 200, 0, 200)
List.ScrollBarThickness = 5
List.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
List.Position = UDim2.new(0, 23, 0, 21)
List.BorderSizePixel = 0
List.BackgroundTransparency = 0.1

local Layout = Instance.new("UIGridLayout", List)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.CellSize = UDim2.new(0, 200, 0, 20)
Layout.CellPadding = UDim2.new(0, 5, 0, 5)

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
  List.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
end)

local Close = Instance.new("TextButton", Title)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Text = "X"
Close.Position = UDim2.new(1, 0, 0, 0)
Close.TextColor3 = Color3.new(1, 1, 1)
Close.BackgroundTransparency = 1

Close.MouseButton1Click:Connect(function()
  gui:Destroy()
end)

local assets = game.HttpService:JSONDecode(game:HttpGet("https://catalog.roblox.com/v1/search/items/details?Category=Animation&Subcategory=Emote&Keyword=" .. game.HttpService:UrlEncode(Value) .. "&Limit=20")).data
for i, v in next, assets do
  if v.assetType == 61 or v.assetType == 50 then
  local Button = Instance.new("TextButton", List)
  Button.Text = v.name .. ": " .. tostring(v.id)
  Button.BackgroundColor3 = List.BackgroundColor3
  Button.TextColor3 = Color3.new(1, 1, 1)
  Button.TextScaled = true
  Button.Position = UDim2.new(0.5, 0, 0.5, 0)
  Button.AnchorPoint = Vector2.new(0.5, 0.5)
  Button.TextXAlignment = Enum.TextXAlignment.Center
  Button.Size = UDim2.new(0, 10, 0, 10)
  Button.BorderSizePixel = 0
  
  Button.MouseButton1Click:Connect(function()
    for _, class in next, game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks() do
      class:Stop()
    end
   
    local anim = game:GetObjects("rbxassetid://" .. tostring(v.id))[1]
    local loa = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
    loa:Play()
    loa:AdjustWeight(math.huge)
  end)
 end
end
    end
})



local Section = Tabs.Extra:AddSection("Tools")

Tabs.Extra:AddButton({
  Title = "Rainbow coil",
  Description = "My custom tool 1. Gives high speed and jump power + when landing does rainbow shockwave",
  Callback = function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/ADSKerOffical/NewTool/refs/heads/main/Auxiliary/Rainbow%20coil"))()
  end
})

Tabs.Extra:AddButton({
  Title = "Jump boots",
  Description = "My custom tool 2. Increases your jump power",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ADSKerOffical/NewTool/refs/heads/main/Auxiliary/Jump%20Boots"))()
  end
})

Tabs.Extra:AddButton({
  Title = "Particle Evaporator",
  Description = "My custom tool 3. Shoots a beam that deals good damage",
  Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ADSKerOffical/NewTool/refs/heads/main/Range/Mythic/Particle%20Evaporator"))()
  end
})

local Section = Tabs.Extra:AddSection("Special scripts")

Tabs.Extra:AddButton({
  Title = "Neko arc exe",
  Description = "By Tomato2007",
  Callback = function()
     loadstring(game:HttpGet("https://pastebin.com/raw/KW0NTUp6"))()
  end
})

Tabs.Extra:AddButton({
  Title = "Endless road",
  Description = "...",
  Callback = function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/ADSKerOffical/1PB/refs/heads/main/Endless%20Road%202"))()
  end
})



local Input 
Input = Tabs.Settings:AddInput("Input", {
    Title = "Set icon size",
    Description = "Sets the size of the icon (Multiplies the number by the original size) that turns the menu on or off",
    Default = "",
    Placeholder = "Default 1",
    Numeric = true, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        BHU2_Icon.Size = UDim2.new(0, math.floor(math.max(32, math.min(game.Players.LocalPlayer:GetMouse().ViewSizeX, game.Players.LocalPlayer:GetMouse().ViewSizeY) * 0.15)) * math.clamp(Value, 0.3, 3), 0, math.floor(math.max(32, math.min(game.Players.LocalPlayer:GetMouse().ViewSizeX, game.Players.LocalPlayer:GetMouse().ViewSizeY) * 0.15)) * math.clamp(Value, 0.3, 3))
        if tonumber(Value) < 0.3 then Input:SetValue(0.3)
        elseif tonumber(Value) > 3 then Input:SetValue(3) end
    end
})

local Toggle = Tabs.Settings:AddToggle("MyToggle", {
    Title = "Hide icon", 
    Description = "Hides or shows the icon",
    Default = false,
    Callback = function(state)
       BHU2_Icon.Visible = not state
    end 
})

Tabs.Settings:AddToggle("MyToggle", {
  Title = "Set alternative window size",
  Description = "Aligns the window",
  Default = false,
  Callback = function(Value)
    udhdb = Value
     if udhdb == true then
       Window.Root.Size = UDim2.new(0.7, 0, 1, 0) 
     else
       Window.Root.Size = UDim2.fromOffset(580, 460)
     end
  end
})

Tabs.Settings:AddToggle("Anti afk", {
  Title = "Anti afk",
  Description = "You won\'t get kicked if you\'re AFK for more than 20 minutes",
  Default = false,
  Callback = function(Value)
    for _, con in next, getconnections(game.Players.LocalPlayer.Idled) do
      if Value == true then con:Disable() else con:Enable() end
    end
  end
})

local queueonteleport = queueonteleport or queue_on_teleport
getgenv().tac = false
Tabs.Settings:AddToggle("MyToggle", {
  Title = "Execute after rejoining",
  Description = "When you rejoining or teleport to another place, the script executing again",
  Default = false,
  Callback = function(Value)
     getgenv().tac = Value
  end
})

queueonteleport([[
  if tac == true then
    -- loadstring
  end
]])
