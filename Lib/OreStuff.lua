local Module = {};
local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local LocalPlayer = Players.LocalPlayer;

Module.GetClient = function(): Model
    local Tycoons: Model = Workspace:WaitForChild("Tycoons");
    for i, v: Model in (Tycoons:GetChildren()) do
        local Owner: StringValue = v:FindFirstChild("Owner");
        if (Owner and Owner.Value == LocalPlayer.Name) then
            return v;
        end;
    end;
end;

Module.SetUpgraded = function(Obj: BasePart)
    for i, v: Model in (Module.GetClient():GetChildren()) do
        local Model: Model = v:FindFirstChild("Model");
        if (not Model) then continue end;
        local Upgrade: BasePart = Model:FindFirstChild("Upgrade");
        if (not Upgrade) then continue end;
        if (not Model:FindFirstChild("UpgraderShip")) then continue end;
        firetouchinterest(Obj, Upgrade, 0);
    end;
end;

Module.Sell = function(Obj: BasePart)
    for i, v: Model in (Module.GetClient():GetChildren()) do
        local Model: Model = v:FindFirstChild("Model");
        if (not Model) then continue end;
        local Lava: BasePart = Model:FindFirstChild("Lava");
        if (not Lava) then continue end;
        if (not Model:FindFirstChild("MoneyScript")) then continue end;
        firetouchinterest(Obj, Lava, 0);
        break
    end;
end;

Module.UpgradeAndSell = function(Obj: BasePart)
    Module.SetUpgraded(Obj);
    task.wait(0.1);
    Module.Sell(Obj);
end;

Module.DroppedParts = Workspace.DroppedParts[Module.GetClient().Name];

return Module;
