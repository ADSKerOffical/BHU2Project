local success, result = pcall(function()
  local games = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://api.github.com/repos/ADSKerOffical/BHU2Project/contents/Hubs?ref=main"))
  for i, v in games do
    if tostring(game.PlaceId) == string.gsub(v.download_url, "%D", ""):sub(2) or tostring(game.GameId) == string.gsub(v.download_url, "%D", ""):sub(2) then
      return true
    end
  end
  return false
end)

if success then
  if result == true then
  local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.new(0, 0, 0, 0),
    Acrylic = false, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

Window.Root.AnchorPoint = Vector2.new(0.5, 0.5)
Window.Root.BackgroundTransparency = 1
Window.Root.Position = UDim2.new(0.5, 0, 0.5, 0)

Window:Dialog({
    Title = "Game detected",
    Content = "Budgie hub has a separate script for this game. Run this script instead of the universal?",
    Buttons = {
        { 
            Title = "Yes",
            Callback = function()
                Fluent:Destroy()
                local admissibility
                if pcall(function() return game:HttpGet("https://raw.githubusercontent.com/ADSKerOffical/BHU2Project/refs/heads/main/Hubs/" .. tostring(game.PlaceId)) end) == true then
                  admissibility = game.PlaceId
                elseif pcall(function() return game:HttpGet("https://raw.githubusercontent.com/ADSKerOffical/BHU2Project/refs/heads/main/Hubs/" .. tostring(game.GameId)) end) == true then
                  admissibility = game.GameId
                end
                loadstring(game:HttpGet("https://raw.githubusercontent.com/ADSKerOffical/BHU2Project/refs/heads/main/Hubs/" .. tostring(admissibility)))()
            end 
        }, {
            Title = "No",
            Callback = function()
                Fluent:Destroy()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/ADSKerOffical/BHU2Project/refs/heads/main/BudgieHubUniversal2.lua"))()
            end
        }, {
            Title = "Don\'t run anything",
            Callback = function()
               Fluent:Destroy()
            end
        }
    }
})
  else
   loadstring(game:HttpGet("https://raw.githubusercontent.com/ADSKerOffical/BHU2Project/refs/heads/main/BudgieHubUniversal2.lua"))()
 end
else
  loadstring(game:HttpGet("https://raw.githubusercontent.com/ADSKerOffical/BHU2Project/refs/heads/main/BudgieHubUniversal2.lua"))()
end
