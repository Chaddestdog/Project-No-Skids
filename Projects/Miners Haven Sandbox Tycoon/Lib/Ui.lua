while (not shared.Loaded) do task.wait() end;

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace");
local Funcs = shared.Funcs;

local ImGui = loadstring(clonefunction(game.HttpGet)(game, "https://raw.githubusercontent.com/Chaddestdog/Project-No-Skids/refs/heads/main/Projects/Miners%20Haven%20Sandbox%20Tycoon/Lib/UiLibrary.lua"))();
local Window = ImGui:CreateWindow({Title = "Miners Haven Sandbox Tycoon | PId: " .. tostring(game.PlaceVersion) .. " | PNS" , TabsBar = true, NoClose = true, Size = UDim2.new(0, 500, 0, 400)}); 
Window:Center();

local AutoFarms = Window:CreateTab({Name = "Auto Farms", Visible = true});
local Local = Window:CreateTab({Name = "Local", Visible = false});
local Uis = Window:CreateTab({Name = "Uis", Visible = false});

--// Auto Farms

AutoFarms:Checkbox({Label = "Auto Spawn", Value = false, Callback = Funcs["Auto Spawn"]});

AutoFarms:Checkbox({Label = "Auto Sell/Upgrade", Value = false, Callback = Funcs["Auto Sell/Upgrade"]});


AutoFarms:ProgressSlider({Label = "Amt til sell", Value = 1, MinValue = 1, MaxValue = 250, Callback = Funcs["Amt til sell"]});

--// Uis 

Uis:Checkbox({Label = "Event Shop", Value = false, Callback = Funcs["Event Shop"]});

Uis:Checkbox({Label = "SpookMcDook Shop", Value = false, Callback = Funcs["SpookMcDook Shop"]});


Uis:Checkbox({Label = "Superstitious Crafting", Value = false, Callback = Funcs["Superstitious Crafting"]});

Uis:Checkbox({Label = "Craftsman", Value = false, Callback = Funcs["Craftsman"]});

--// Local

Local:Button({Text = "Sell all", Callback = Funcs["Sell all"]});

Local:Button({Text = "Upgrade all", Callback = Funcs["Upgrade all"]});

Local:Button({Text = "Upgrade and Sell all", Callback = Funcs["Upgrade and Sell all"]});

Local:ProgressSlider({Label = "Conveyor Speed", Value = -10, MinValue = -10, MaxValue = 0, Callback = Funcs["Conveyor Speed"]});
