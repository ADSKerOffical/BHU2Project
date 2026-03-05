local tool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
tool.Name = "Brazil Samba"
tool.ToolTip = "Boulder"
tool.RequiresHandle = false

local lastPressTime = 0
game.Players.LocalPlayer.SimulationRadius = math.huge
tool.Activated:Connect(function()
  local currentTime = tick()
            if currentTime - lastPressTime >= 2 then
                lastPressTime = currentTime 
game.Players.LocalPlayer.SimulationRadius = math.huge
coroutine.wrap(function()
local owner = tool.Parent
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://76715054152443"
local k = owner.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
  task.wait(0.3)
local ball = Instance.new("Part", workspace)
ball.Size = Vector3.new(5, 5, 5)
ball.CustomPhysicalProperties = PhysicalProperties.new(100, 0, 1, 1, 1)
ball.CFrame = owner.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7)
ball.Velocity = owner.HumanoidRootPart.CFrame.LookVector * 700 + Vector3.new(0, 35, 0)
game.Debris:AddItem(ball, 30)

local mesh = Instance.new("SpecialMesh", ball)
mesh.MeshId = "rbxassetid://1042484771"
mesh.TextureId = "rbxassetid://1042482997"
mesh.Scale = Vector3.new(5, 5, 5)

ball.Touched:Connect(function(hit)
 local human = hit.Parent:FindFirstChildOfClass("Humanoid")
   if human and not human:IsDescendantOf(owner) then
    if isnetworkowner(human.RootPart) then
      human:TakeDamage(math.huge)
      human.Health = 0
      human.RootPart.Velocity = (ball.Position - human.RootPart.Position).Unit * -1000
      human.PlatformStand = true
   end
local sound = Instance.new("Sound", ball)
sound.SoundId = "rbxassetid://1086799256"
sound.Volume = 7
sound.PlaybackSpeed = 1
sound.Looped = false
sound:Play()
game.Debris:AddItem(sound, 5)

local sound = Instance.new("Sound", human)
sound.SoundId = "rbxassetid://138210320"
sound.Volume = 5
sound.PlaybackSpeed = 1
sound.Looped = false
game.Debris:AddItem(sound, 5)
sound:Play()
   end
end)

local sound = Instance.new("Sound", owner.HumanoidRootPart)
sound.SoundId = "rbxassetid://28445431"
sound.Volume = 1
sound:Play()
game.Debris:AddItem(sound, 5)
    end)()
  end 
end)
