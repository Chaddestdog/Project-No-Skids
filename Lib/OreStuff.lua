local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local LocalPlayer = Players.LocalPlayer;

local Tycoons = Workspace:WaitForChild("Tycoons");
local ClientTycoon: Model;

for i, v: Model in (Tycoons:GetChildren()) do
	local Owner: StringValue = v:FindFirstChild("Owner");
	if (Owner and Owner.Value == LocalPlayer.Name) then
		ClientTycoon = v;
		break;
	end;
end;

local SetUpgraded = function(Obj: BasePart)
	for i, v: Model in (ClientTycoon:GetChildren()) do
		local Model: Model = v:FindFirstChild("Model");
		if (not Model) then continue end;
		local Upgrade: BasePart = Model:FindFirstChild("Upgrade");
		if (not Upgrade) then continue end;
		firetouchinterest(Obj, Upgrade, 0);
	end;
end;

local Sell = function(Obj: BasePart)
	for i, v: Model in (ClientTycoon:GetChildren()) do
		local Model: Model = v:FindFirstChild("Model");
		if (not Model) then continue end;
		local Lava: BasePart = Model:FindFirstChild("Lava");
		if (not Lava) then continue end;
		if (not Model:FindFirstChild("MoneyScript")) then continue end;
		if (v.Name == "Cell Furnace") then continue end;
		firetouchinterest(Obj, Lava, 0);
		break;
	end;
end;

local UpgradeAndSell = function(Obj: BasePart)
	SetUpgraded(Obj);
	Sell(Obj);
end;

local GetDropped = function()
	return Workspace.DroppedParts[ClientTycoon.Name];
end;

local GetTycoon = function()
	return ClientTycoon;
end;


return {
	["GetTycoon"] = GetTycoon,
	["GetDropped"] = GetDropped,
	["UpgradeAndSell"] = UpgradeAndSell,
	["Sell"] = Sell,
	["SetUpgraded"] = SetUpgraded,
};
