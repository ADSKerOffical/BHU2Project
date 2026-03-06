local tool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
tool.Name = "Atomic Bomb"
tool.ToolTip = "Blow up everything that moves"
tool.RequiresHandle = false

game.Players.LocalPlayer.SimulationRadius = math.huge
tool.Activated:Connect(function()
  game.Players.LocalPlayer.SimulationRadius = math.huge
  local bomb = Instance.new("Part", workspace)
  bomb.Size = Vector3.new(2, 2, 2)
  bomb.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 2
  bomb.AssemblyLinearVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 1000 + Vector3.new(0, 20, 0)
  
  local mesh = Instance.new("SpecialMesh", bomb)
  mesh.MeshId = "rbxassetid://14797474634"
  mesh.TextureId = "rbxassetid://14797476659"
  mesh.Scale = Vector3.new(1, 1, 1)
  
  bomb.Touched:Connect(function(part)
    if not part:IsDescendantOf(game.Players.LocalPlayer.Character) then
      local expl = Instance.new("Part", workspace)
      expl.Shape = "Ball"
      expl.Anchored = true
      expl.CanCollide = false
      expl.CanTouch = false
      expl.CanQuery = false
      expl.Material = "Neon"
      expl.Color = Color3.new(1, 0.5, 0)
      expl.Position = bomb.Position
      game.Debris:AddItem(expl, 10)
      
      local shockwave = Instance.new("Part", expl)
      shockwave.Anchored = true 
      shockwave.Size = Vector3.zero
      shockwave.Position = expl.Position + Vector3.new(0, 10, 0)
      shockwave.Color = Color3.new(0.5, 0.5, 0.5)
      
      local shockwave_mesh = Instance.new("SpecialMesh", shockwave)
      shockwave_mesh.MeshId = "rbxassetid://73432515253008"
      shockwave_mesh.Scale = Vector3.new(10, 10, 10)
      
      game:GetService("TweenService"):Create(expl, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), {
        Size = Vector3.new(400, 400, 400),
        Transparency = 1,
        Color = Color3.new(0, 0, 0)
      }):Play()
      
      game:GetService("TweenService"):Create(shockwave, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
        Transparency = 1,
        Color = Color3.new(0, 0, 0)
      }):Play()
      
      game:GetService("TweenService"):Create(shockwave_mesh, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
        Scale = Vector3.new(600, 30, 600)
      }):Play()
      
      local humanoids = {}
    for _, part in next, workspace:GetPartBoundsInRadius(expl.Position, 500) do
      if part.Parent:IsA("Model") and part.Parent:FindFirstChildOfClass("Humanoid") and not part:IsDescendantOf(game.Players.LocalPlayer.Character) then
        if not table.find(humanoids, part.Parent:FindFirstChildOfClass("Humanoid")) then
          table.insert(humanoids, part.Parent:FindFirstChildOfClass("Humanoid"))
        end
        elseif part.Anchored == false and not part:IsDescendantOf(game.Players.LocalPlayer.Character) and not game.Players:GetPlayerFromCharacter(part.Parent) then
         part.AssemblyLinearVelocity += (expl.Position - part.Position).Unit * -1000
         part.AssemblyAngularVelocity += Vector3.new(400, 400, 400)
      end
    end

      for _, humanoid in next, humanoids do
        if isnetworkowner(humanoid.RootPart) then
          humanoid.Heath = 0
        end
      end
      
      local sound = Instance.new("Sound", workspace)
      sound.SoundId = "rbxassetid://115869261291059"
      sound.Volume = 6
      sound.TimePosition = 0.9
      sound:Play()
      game.Debris:AddItem(sound, 6)
      bomb:Destroy()
    end
  end)
end)
