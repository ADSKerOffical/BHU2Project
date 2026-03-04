local tool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
tool.Name = "Energy sphere"
tool.RequiresHandle = false
tool.ToolTip = "Kill NPCs and throw objects away"
tool.GripPos = Vector3.new(0, 0, 0)

local handle = Instance.new("Part", tool)
handle.Name = "Handle"
handle.Material = "Neon"
handle.Shape = "Ball"
handle.Size = Vector3.new(1.4, 1.4, 1.4)
handle.Color = Color3.new(1, 1, 1)

local cooldown = 0
game.Players.LocalPlayer.SimulationRadius = math.huge
tool.Activated:Connect(function()
  if (os.clock() - cooldown) >= 5 then
    cooldown = os.clock()
    game.Players.LocalPlayer.SimulationRadius = math.huge
    
    local shockwave = handle:Clone()
    shockwave.CanCollide = false
    shockwave.CanTouch = false
    shockwave.CanQuery = false
    shockwave.Anchored = true
    shockwave.Parent = workspace
    game.Debris:AddItem(shockwave, 5)
    
    local humanoids, parts = {}
    for _, part in next, workspace:GetPartBoundsInRadius(handle.Position, 200) do
      if part.Parent:IsA("Model") and part.Parent:FindFirstChildOfClass("Humanoid") and not part:IsDescendantOf(game.Players.LocalPlayer.Character) then
        if not table.find(humanoids, part.Parent:FindFirstChildOfClass("Humanoid")) then
          table.insert(humanoids, part.Parent:FindFirstChildOfClass("Humanoid"))
        end
        elseif part.Anchored == false and not (part.Parent:IsA("Model") and part.Parent:FindFirstChildOfClass("Humanoid")) and not part:IsDescendantOf(game.Players.LocalPlayer.Character) then
        part.AssemblyLinearVelocity = (shockwave.Position - part.Position).Unit * -1200
      end
    end

    for _, humanoid in next, humanoids do
      humanoid.RootPart.AssemblyLinearVelocity = (shockwave.Position - humanoid.RootPart.Position).Unit * -800
      if isnetworkowner(humanoid.RootPart) then
        humanoid.Health = 0
        humanoid.PlatformStand = true
      end
    end
    
    game:GetService("TweenService"):Create(shockwave, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
       Size = Vector3.new(250, 250, 250),
       Transparency = 1,
       Color = Color3.new(0, 0, 0)
     }):Play()
  end
end)
