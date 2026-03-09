local soundId = "A60Sound_" .. tostring(math.random(1e5, 9e9)) .. ".mp3"
local imgId = "A60Image_" .. tostring(math.random(1e5, 9e9)) .. ".png"

writefile(imgId, "https://pbs.twimg.com/media/GtRjJxFWIAA5jaN.png")
writefile(soundId, "https://www.soundjay.com/mechanical_c2026/tv-static-01.mp3")

if game:GetService("GuiService"):GetGameplayPausedNotificationEnabled() then
  game:GetService("GuiService"):SetGameplayPausedNotificationEnabled(false)
  workspace.StreamingIntegrityMod = Enum.StreamingIntegrityMod.Default
end

for _, part in next, game.Players.LocalPlayer.Character:GetDescendants() do
  if part:IsA("BasePart") or part:IsA("FaceInstance") then
    part.Transparency = 1
  end
end

local killSound = Instance.new("Sound", game.Players.LocalPlayer.Character.HumanoidRootPart)
killSound.SoundId = "rbxassetid://515093461"
killSound.Volume = 10
killSound.PlaybackSpeed = 1

local light = Instance.new("PointLight", game.Players.LocalPlayer.Character.HumanoidRootPart)
light.Color = Color3.new(1, 0, 0)
light.Brightness = 5
light.Range = 35

local hitbox = Instance.new("Part", workspace)
hitbox.Size = Vector3.new(11, 11, 11)
hitbox.Massless = true
hitbox.CanCollide = false
hitbox.Transparency = 1

hitbox.Touched:Connect(function(part)
  game.Players.LocalPlayer.SimulationRadius = math.huge
  if not part:IsDescendantOf(light.Parent) and part.Parent:FindFirstChildOfClass("Humanoid") and not game.Players:GetPlayerFromCharacter(part.Parent) then
    local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
    humanoid.RootPart.AssemblyLinearVelocity = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - humanoid.RootPart.Position).Unit * -500
    if isnetworkowner(humanoid.RootPart) then
      humanoid.Health = 0
      humanoid.BreakJointsOnDeath = false
      killSound:Play()
    end
  elseif not part:IsDescendantOf(light.Parent) and part.Anchored == false and not part.Parent:FindFirstChildOfClass("Humanoid") then
    part.AssemblyLinearVelocity = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Unit * -500
  end
end)

local forParticles = hitbox:Clone()
forParticles.Parent = hitbox
forParticles.Size = Vector3.new(25, 10, 25)

local joint = Instance.new("Weld", hitbox)
joint.Part0 = hitbox
joint.Part1 = game.Players.LocalPlayer.Character.HumanoidRootPart

local joint2 = Instance.new("Weld", forParticles)
joint2.Part0 = forParticles
joint2.Part1 = game.Players.LocalPlayer.Character.HumanoidRootPart

local bill = Instance.new("BillboardGui", game.Players.LocalPlayer.Character.HumanoidRootPart)
bill.Adornee = game.Players.LocalPlayer.Character.HumanoidRootPart
bill.AlwaysOnTop = false
bill.Size = UDim2.new(11, 0, 11, 0)

local img = Instance.new("ImageLabel", bill)
img.Size = UDim2.new(1, 0, 1, 0)
img.BackgroundTransparency = 1
img.ZIndex = 5
img.BorderSizePixel = 0
img.Image = "rbxassetid://12485176630"

local particle = Instance.new("ParticleEmitter", forParticles)
particle.Texture = "rbxassetid://12532482993"
particle.Rate = 1000
particle.LightEmission = 10
particle.LightInfluence = 5
particle.Transparency = NumberSequence.new(0.1, 0.1)
particle.Speed = NumberRange.new(0, 0)
particle.Size = NumberSequence.new(9, 9)
particle.Lifetime = NumberRange.new(0.05, 0.05)

local loop = Instance.new("Sound", game.Players.LocalPlayer.Character.HumanoidRootPart)
loop.Looped = true
loop.SoundId = "rbxassetid://136992416500756"
loop.Volume = 60
loop.PlaybackSpeed = 1.5
loop:Play()

local pitch = Instance.new("PitchShiftSoundEffect", loop)
pitch.Priority = math.huge
pitch.Octave = 0.25

local vel = Instance.new("BodyForce", game.Players.LocalPlayer.Character.HumanoidRootPart)
vel.Name = "Moving"

game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
  vel.Force = game.Players.LocalPlayer.Character.HumanoidRootPart:GetMass() * game.Players.LocalPlayer.Character.Humanoid.MoveDirection * 6000
end)
