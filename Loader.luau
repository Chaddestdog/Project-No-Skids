local LocalPlayer: Player = cloneref(game:GetService("Players")).LocalPlayer;
local Executor = (identifyexecutor and identifyexecutor() or '');
local Games = loadstring(clonefunction(game.HttpGet)(game, "https://raw.githubusercontent.com/Chaddestdog/Project-No-Skids/refs/heads/main/Projects/Games.lua"))();

if (not messagebox) then return LocalPlayer:Kick("Unsupported executor\n" .. Executor) end;

local Messagebox = function(Text, Caption, Flags)
    local Success, Value = pcall(messagebox, Text, Caption, Flags);
    if (not Success) then
        return LocalPlayer:Kick("Error: 1\n" .. tostring(Value));
    end;
    return Value;
end;

local load = function(Name)
    local Game = rawget(Games, Name);
    if (not Game) then return LocalPlayer:Kick("Unsupported Game") end;
    if (Game.Status ~= "UD" and Messagebox("The script is currently " .. Game.Status .. "\nDo you want to continue?", "Project No Skid", 52) ~= 6) then
        return;
    elseif (Game.Pid ~= game.PlaceVersion and Messagebox("The script is currently out of date\nDo you want to continue?", "Project No Skid", 52) ~= 6) then
        return;
    elseif (Game.Excs and not table.find(Game.Excs, Executor)) then
        return LocalPlayer:Kick("Unsupported executor\n" .. Executor);
    end;
    loadstring(clonefunction(game.HttpGet)(game, "https://raw.githubusercontent.com/Chaddestdog/Project-No-Skids/refs/heads/main/Projects/" .. Name .. "/Src/Main.lua"))();
end;

if (game.PlaceId == 258258996) then
    load("Miners Haven Sandbox Tycoon");
end;
