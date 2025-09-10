--!nolint
--!nocheck
--!optimize 2

--// Vars
local Cloneref = (cloneref or function(a) return a end);
local GetService = function(Service) return Cloneref(UserSettings().GetService(game, Service)) end;

local RunService: RunService = GetService("RunService");
local CoreGui: PlayerGui = (cloneref and GetService("CoreGui") or GetService("Players").LocalPlayer.PlayerGui);

local PreFab = (cloneref and game:GetObjects("rbxassetid://134588751279564")[1] or script.Prefab):Clone();
local CurrentCamera = workspace.CurrentCamera;
local Middle = (CurrentCamera.ViewportSize / 2);

local Settings = {Font = Font.fromEnum(Enum.Font.Code)};
local PlayerEsp;
local ItemEsp;
local NpcEsp;

do --// Types
	type table = typeof({});
	type func = typeof(function() end)
end;

do --// Player
	local PlayerSettings = {
		Box = {Enabled = false, Box = false, Color = Color3.fromRGB(255, 255, 255), Weapon = false, Health = false, Name = false, Dist = false},
		Skeleton = {Enabled = false, Color = Color3.fromRGB(255, 255, 255), HeadDot = false},
		OffScreenArrow = {Enabled = false, Color = Color3.fromRGB(255, 255, 255), Fov = 120},
		HasEsp = {}
	}; 
	
	PlayerEsp = function(Player: Player, GetBoundingBox: func, CallBack: func)
		local Connection1, Connection2, Thread;
		local Character = Player.Character;
		local HumanoidRootPart: BasePart = Character:WaitForChild("HumanoidRootPart");
		if (not HumanoidRootPart) then return end;
		if (rawget(PlayerSettings.HasEsp, Player)) then return end;
		
		rawset(PlayerSettings.HasEsp, Player, true);
		
		local Esp: BillboardGui = PreFab:Clone();
		Esp.Parent = CoreGui.RobloxGui;
		Esp.Adornee = workspace.Terrain;
		Esp.StudsOffset = Vector3.new(0, -0.15, 0);
		local Box: Frame = Esp.Fill;
		local Weapon: TextLabel = Esp.Weapon;
		local Health :Frame = Esp.Health;
		local Name: TextLabel = Esp.Name_;
		local Dist: TextLabel = Esp.Dist;
		local Arrow: ImageLabel = Esp.Arrow;
		Arrow.Parent = CoreGui.RobloxGui;
		Arrow.Image = ("rbxassetid://104818498825314");

		
		
		local Skeleton = Instance.new("WireframeHandleAdornment", CoreGui.RobloxGui);
		Skeleton.AlwaysOnTop = true;
		Skeleton.Adornee = workspace;

		local HeadDot = Instance.new("SphereHandleAdornment", CoreGui.RobloxGui);
		HeadDot.Visible = false;
		HeadDot.Adornee = Character.Head;
		HeadDot.Transparency = 0.5;
		HeadDot.AlwaysOnTop = true;
		HeadDot.Radius = (Character.Head.Size.Unit.Magnitude / 1.65);
		HeadDot.ZIndex = 2;
		
		Weapon.FontFace = Settings.Font;
		Name.FontFace = Settings.Font;
		Dist.FontFace = Settings.Font;
		
		Thread = task.spawn(function()
			Connection1 = RunService.RenderStepped:Connect(function(DeltaTime: number) 
				local Point, On = CurrentCamera:WorldToViewportPoint(HumanoidRootPart.Position);
				
				if (not On) then 
					--// OffScreen Arrow
					if (PlayerSettings.OffScreenArrow.Enabled) then
						Arrow.Visible = true;
						local Dir : Vector2 = (Vector2.new(Point.X, Point.Y) - Middle);
						if (Point.Z < 0) then Dir = -Dir end;
						if (Dir.Magnitude > 0) then Dir = (Dir.Unit * PlayerSettings.OffScreenArrow.Fov) end;
						Arrow.Position = UDim2.fromOffset(Middle.X + Dir.X, Middle.Y + Dir.Y);
						Arrow.Rotation =( math.deg(math.atan2(Dir.Y, Dir.X)) + 90);
					else
						Arrow.Visible = false;
					end;
					Esp.Enabled = false;
					Skeleton:Clear();
					HeadDot.Visible = false;
					return;
				else
					Arrow.Visible = false;
					Esp.Enabled = true;
				end;
				
				CallBack(Esp);
				
				local Position, Size = GetBoundingBox(Player.Character);
				Esp.StudsOffsetWorldSpace = Position;

				if (PlayerSettings.Box.Enabled) then
					Esp.Size = UDim2.fromScale((Size.X)* 500,(Size.Y)* 550);

					--// Box
					if (PlayerSettings.Box.Box) then
						Box.Visible = true;
						Box.BackgroundColor3 = PlayerSettings.Box.Color;
					else
						Box.Visible = false;
					end;

					--// Weapon
					if (PlayerSettings.Box.Weapon) then
						Weapon.Visible = true;
						Weapon.TextColor3 = PlayerSettings.Box.Color;
						Weapon.Position = UDim2.new(0.5, 0, 0.500999987, (PlayerSettings.Box.Dist and Dist.TextBounds.Y + 1 or 1));
					else
						Weapon.Visible = false;
					end;

					--// Health
					if (PlayerSettings.Box.Health) then
						Health.Visible = true;
						local HealthPercentage = (Player.Character.Humanoid.Health / Player.Character.Humanoid.MaxHealth);
						Health.Bar.Size = UDim2.fromScale(1, HealthPercentage);
						Health.Bar.BackgroundColor3 = Color3.new(1, 0, 0):Lerp(Color3.new(0, 1, 0), HealthPercentage);
					else
						Health.Visible = false;
					end;
					
					--// Name
					if (PlayerSettings.Box.Name) then
						Name.Visible = true;
						Name.TextColor3 = PlayerSettings.Box.Color;
						Name.Text = Player.Name;
					else
						Name.Visible = false;
					end
					
					--// Distance
					if (PlayerSettings.Box.Dist) then
						Dist.Visible = true;
						Dist.TextColor3 = PlayerSettings.Box.Color;
						Dist.Text = (math.round((CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Magnitude * 0.28) .. "m");
					else
						Dist.Visible = false;
					end;
					
				else
					Esp.Enabled = false;
				end

				--// Skeleton
				if (PlayerSettings.Skeleton.Enabled) then
					Skeleton:Clear();
					local HeadOffset = (Character.Head.CFrame * -Vector3.new(0, (Character.Head.Size.Y/2), 0));
					Skeleton.Color3 = PlayerSettings.Skeleton.Color;
					Skeleton:AddLines({
						HeadOffset, Character.UpperTorso.Position,
						Character.UpperTorso.Position, Character.LowerTorso.Position,
						HeadOffset, Character.RightUpperArm.Position,
						Character.RightUpperArm.Position, Character.RightLowerArm.Position,
						Character.RightLowerArm.Position, Character.RightHand.Position,
						HeadOffset, Character.LeftUpperArm.Position,
						Character.LeftUpperArm.Position, Character.LeftLowerArm.Position,
						Character.LeftLowerArm.Position, Character.LeftHand.Position,
						Character.LowerTorso.Position, Character.RightUpperLeg.Position,
						Character.RightUpperLeg.Position, Character.RightLowerLeg.Position,
						Character.RightLowerLeg.Position, Character.RightFoot.Position,
						Character.LowerTorso.Position, Character.LeftUpperLeg.Position,
						Character.LeftUpperLeg.Position, Character.LeftLowerLeg.Position,
						Character.LeftLowerLeg.Position, Character.LeftFoot.Position
					});
					
					if (PlayerSettings.Skeleton.HeadDot) then
						HeadDot.Visible = true;
						HeadDot.Color3 = PlayerSettings.Skeleton.Color;
					else
						HeadDot.Visible = false;
					end;
				else
					HeadDot.Visible = false;
					Skeleton:Clear();
				end;

		

			end);
		end)
		
		Connection2 = Character.AncestryChanged:Connect(function(self: Instance, Parent: Instance) 
			if (Parent == nil) then
				rawset(PlayerSettings.HasEsp, Player, false);
				Connection1:Disconnect();
				Connection2:Disconnect();
				task.cancel(Thread);
				Skeleton:Destroy();
				HeadDot:Destroy();
				Esp:Destroy();
			end;
		end);
	end;
	Settings.Player = PlayerSettings;
end;

do --// Npc
	local NpcSettings = {

	};

	NpcEsp = function(Item: BasePart)

	end;

	Settings.Item = NpcSettings;
end;

do --// Item
	local ItemSettings = {

	};
	
	ItemEsp = function(Item: BasePart)

	end;
	
	Settings.Item = ItemSettings;
end;

return {Settings, PlayerEsp, NpcEsp, ItemEsp}
