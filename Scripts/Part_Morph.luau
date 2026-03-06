local tool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
tool.Name = "Part morph"
tool.ToolTip = "You can control the part as if you were controlling a character"
tool.RequiresHandle = false

game.Players.LocalPlayer.SimulationRadius = math.huge
tool.Activated:Connect(function()
  game.Players.LocalPlayer.SimulationRadius = math.huge
  local part = game.Players.LocalPlayer:GetMouse().Target
  if part and part.Anchored == false and isnetworkowner(part) and not part:IsDescendantOf(game.Players.LocalPlayer.Character) and not game.Players:GetPlayerFromCharacter(part.Parent) then
    local model = (part.Parent:IsA("Model") and part.Parent.Parent == workspace and part.Parent) or Instance.new("Model", workspace)
    part.Parent = model
    
    workspace.CurrentCamera.CameraSubject = part
    game.Players.LocalPlayer.Character = model
    
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.ResetOnSpawn = false
    
    local button1 = Instance.new("TextButton", gui)
    button1.Text = "Go"
    button1.Size = UDim2.new(0.09, 0, 0.09, 0)
    button1.Position = UDim2.new(0.8, 0, 0.3, 0)
    button1.Draggable = true
    button1.TextColor3 = Color3.new(1, 1, 1)
    button1.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    
    button1.MouseButton1Click:Connect(function()
      part.AssemblyLinearVelocity += workspace.CurrentCamera.CFrame.LookVector * 60
    end)
    
    local button2 = button1:Clone()
    button2.Text = "Jump"
    button2.Position = UDim2.new(0.8, 0, 0.45, 0)
    button2.Parent = gui
    
    button2.MouseButton1Click:Connect(function()
      part.AssemblyLinearVelocity += Vector3.new(0, 60, 0)
    end)
    
    local button3 = button2:Clone()
    button3.Text = "Exit"
    button3.Position = UDim2.new(0.8, 0, 0.6, 0)
    button3.Parent = gui
    
    button3.MouseButton1Click:Connect(function()
      game.Players.LocalPlayer.Character = workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    end)
      repeat task.wait() until not part or not model or not isnetworkowner(part) or game.Players.LocalPlayer.Character == workspace[game.Players.LocalPlayer.Name]
    game.Players.LocalPlayer.Character = Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    pcall(function() model:Destroy() end) pcall(function() gui:Destroy() end)
  end
end)
