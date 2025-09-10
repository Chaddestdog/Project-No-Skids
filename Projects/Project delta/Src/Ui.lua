while (not shared.Loaded) do task.wait() end;
local Funcs = shared.Funcs;
local ImGui = loadstring(clonefunction(game.HttpGet)(game, "https://raw.githubusercontent.com/Chaddestdog/Project-No-Skids/refs/heads/main/Projects/Project%20delta/Lib/UiLibrary.lua"))();
local Window = ImGui:CreateWindow({Title = "Project delta | PNS | PId: " .. tostring(game.PlaceVersion) , TabsBar = true, NoClose = true, Size = UDim2.new(0, 500, 0, 400)}); 
Window:Center();
