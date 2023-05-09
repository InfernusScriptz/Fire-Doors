local Name = "Fire Doors [2.0.1]"
local loadInLobby = false
local quickLoad = true
local t = true

local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
function Notificate(title, text, timee)
	task.spawn(function()
		local notif = Instance.new("Sound");notif.Parent = game.SoundService;notif.SoundId = "rbxassetid://4590657391";notif.Volume = 5;notif:Play();notif.Stopped:Wait();notif:Destroy()
	end)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84)}
	)
end

Notificate(Name,"Preparing to load "..Name.."...")
if not quickLoad then
	wait(2)
else
	wait(0.1)
end



if not fireproximityprompt then
	Notificate(Name,"LMAO, GO GET A BETTER EXECUTOR")
	return
end

if not quickLoad then
	wait(1)
else
	wait(0.1)
end
function Exist(part)
	if part and part.Parent then
		return true
	end
	return false
end
if _G["loading "..Name] == true then
	Notificate(Name,'Script it loading, wait...')
	return
end
_G["loading "..Name] = true
if _G["loaded "..Name] == true then
	Notificate(Name,'The script is already loaded! Try pressing "Z"')
	return
end
if not game.ReplicatedStorage:FindFirstChild("GameData") or not game.ReplicatedStorage.GameData:FindFirstChild("Floor") or not game.ReplicatedStorage.GameData.Floor:IsA("StringValue") then
	Notificate(Name,"You must be in doors to execute that script!")
	return 
elseif game.ReplicatedStorage:FindFirstChild("GameData") and game.ReplicatedStorage.GameData:FindFirstChild("Floor") and game.ReplicatedStorage.GameData.Floor:IsA("StringValue") then
	if workspace:FindFirstChild("Lobby") and workspace.Lobby:FindFirstChild("Parts") and #workspace.Lobby.Parts:GetChildren() >= 1 and not loadInLobby then
		Notificate(Name,"You must be in game [Not lobby] to execute that script!")
		return
	else
		Notificate(Name,"Almost loaded "..Name.."...")
	end
end

if not quickLoad then
	wait(5)
else
	wait(0.1)
end
Notificate(Name,"If you closed the gui, press Z, that will fully unload the script!")
local autoLoot = false
local activateDistance = 6
local ppNames = {
	["ModulePrompt"] = true,
	["ActivateEventPrompt"] = true,
	["LootPrompt"] = true,
	["SkipPrompt"] = true,
	["HerbPrompt"] = true,
}
local ESP = {
	["Doors"] = {
		["Door"] = {
			["Class"] = "MeshPart",
			["Color"] = Color3.fromRGB(255,255,0),
			["DescendantOf"] = workspace.CurrentRooms,
			["UseHL"] = true,
		},
		["KeyObtain"] = {
			["Class"] = "Model",
			["Color"] = Color3.fromRGB(255,255,0),
			["DescendantOf"] = workspace.CurrentRooms,
			["UseHL"] = false,
		},
		["LeverForGate"] = {
			["Class"] = "Model",
			["Color"] = Color3.fromRGB(255,255,0),
			["DescendantOf"] = workspace.CurrentRooms,
			["UseHL"] = false,
		},
		["LiveHintBook"] = {
			["Class"] = "Model",
			["Color"] = Color3.fromRGB(0,255,0),
			["DescendantOf"] = workspace.CurrentRooms,
			["UseHL"] = false,
		},
	},

	["Enteties"] = {
		["RushMoving"] = {
			["Class"] = "Model",
			["Color"] = Color3.fromRGB(100,0,0),
			["DescendantOf"] = workspace,
			["UseHL"] = false,
		},
		["AmbushMoving"] = {
			["Class"] = "Model",
			["Color"] = Color3.fromRGB(150,255,0),
			["DescendantOf"] = workspace,
			["UseHL"] = false,
		},
		["SeekMoving"] = {
			["Class"] = "Model",
			["Color"] = Color3.fromRGB(100,0,0),
			["DescendantOf"] = workspace,
			["UseHL"] = true,
		},
		["FigureRagdoll"] = {
			["Class"] = "Model",
			["Color"] = Color3.fromRGB(170, 82, 84),
			["DescendantOf"] = workspace.CurrentRooms,
			["UseHL"] = true,
		},
	},
}
local function isNumber(str)
	if tonumber(str) ~= nil or str == 'inf' then
		return true
	end
end
_G["loading "..Name] = false
_G["loaded "..Name] = true
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(Name, "BloodTheme")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("The main page")
Section:NewKeybind("!Unload half script!", "Many features after thaw will wont work!", Enum.KeyCode.Z, function()
	if t then
		_G["loaded "..Name] = false
		t = false
		Notificate(Name,"Unloaded half of script!")
	end
end)
Section:NewKeybind("Toggle UI", "", Enum.KeyCode.X, function()
	Library:ToggleUI()
end)
local ur = 60
Section:NewTextBox("Update rate", "Update rate of scripts (per fps)", function(txt)
	if isNumber(txt) then
		ur = tonumber(txt)
	end
end)
local Tab = Window:NewTab("Character")
local Section = Tab:NewSection("Character settings")
local noclip = false
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:FindFirstChild("Collision") or char:FindFirstChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local instant = function(func)
	return coroutine.wrap(func)()
end
local function getDistance(from)
	if from and from:IsA("BasePart") then
		return (hrp.Position-from.Position).Magnitude
	elseif from and from:IsA("Model") then
		return (hrp.Position-from.WorldPivot.Position).Magnitude
	elseif from and from:IsA("Attachment") then
		return (hrp.Position-from.WorldPosition).Magnitude
	end
end
function fire(v)
	if Exist(v) and Exist(v.Parent) and ppNames[v.Name] and getDistance(v.Parent) <= activateDistance and v.Enabled == true and v.ActionText ~= "Close" and autoLoot and t then
		if workspace.CurrentRooms:FindFirstChild("50") then
			if v:IsDescendantOf(workspace.CurrentRooms["50"].Door) then
				return
			end
		elseif workspace.CurrentRooms:FindFirstChild("52") then
			if v:IsDescendantOf(workspace.CurrentRooms["52"]) then
				return
			end
		elseif workspace.CurrentRooms:FindFirstChild("100") then
			if v:IsDescendantOf(workspace.CurrentRooms["100"].ElevatorBreaker) or v:IsDescendantOf(workspace.CurrentRooms["100"].IndustrialGate) then
				return
			end
		end
		fireproximityprompt(v,1,true)
	end
end
local waitFrames = function(times)
	local times = times or 1
	for i=1,times do
		game["Run Service"].Stepped:Wait()
	end
end
local rs = waitFrames
Section:NewToggle("Noclip", "Makes you walk trough the walls", function(state)
	noclip = state
end)
Section:NewSlider("Extra Speed", "Makes you walk faster", 6.4, 0.1, function(s)
	hum:SetAttribute("SpeedBoost",s)
end)
local jumpAllowed = false
game.UserInputService.JumpRequest:Connect(function()
	if jumpAllowed and hum.FloorMaterial ~= Enum.Material.Air and hum.FloorMaterial ~= nil and t then
		hum.UseJumpPower = true
		hum.JumpPower = 15
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)
Section:NewToggle("Jump", "Allow you jump in the game!", function(state)
	jumpAllowed = state
end)
local Tab = Window:NewTab("Interactables")
local Section = Tab:NewSection("Interactables settings")
Section:NewSlider("Distance multiplier", "You will interact with drawest, keys and etc more than normally", 2.2, 1, function(s)
	activateDistance = 6 * s
	for i,v in pairs(workspace:GetDescendants()) do
		if v and v:IsA("ProximityPrompt") then
			v.MaxActivationDistance = activateDistance
		end
	end
end)
local instantInteract = false
Section:NewToggle("Instant Activate", "Will make you interact with items instantly", function(state)
	instantInteract = state
end)
game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
	if instantInteract and t then
		prompt:InputHoldEnd()
		fireproximityprompt(prompt,1,true)
	end
end)
Section:NewToggle("Auto loot", "Will automatically loot dressers", function(state)
	autoLoot = state
end)
local doorESP = false
local entityESP = false
function MakeESP(target:Instance)
	if t then
		if not target:FindFirstChild("ESP FOLDER") then
			local folder = Instance.new("Folder",target)
			folder.Name = "ESP FOLDER"
			local hl = Instance.new("Highlight",folder)
			hl.Adornee = target
			local bbg = Instance.new("BillboardGui",folder)
			bbg.Adornee = target
			bbg.AlwaysOnTop = true
			bbg.MaxDistance = 3000
			bbg.Size = UDim2.fromOffset(30,30)
			local circle = Instance.new("Frame",bbg)
			circle.Size = UDim2.fromOffset(10,10)
			circle.AnchorPoint = Vector2.new(0.5,0.5)
			circle.Position = UDim2.fromOffset(15,5)
			local corner = Instance.new("UICorner",circle)
			corner.CornerRadius = UDim.new(1,0)
			local stroke = Instance.new("UIStroke",circle)
			stroke.Thickness = 2
			stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
			local txt = Instance.new("TextLabel",bbg)
			txt.BackgroundTransparency = 1
			txt.Position = UDim2.fromOffset(15,15)
			txt.AnchorPoint = Vector2.new(0.5,0.5)
			txt.Size = UDim2.fromOffset(30,5)
			local stroke2 = stroke:Clone()
			stroke2.Parent = txt
			instant(function()
				local yes = false
				repeat
					if not t then
						yes = true
						folder:Destroy()
					end
					rs(ur)
				until yes
			end)
			return hl,circle,txt
		else
			local f = target:FindFirstChild("ESP FOLDER")
			instant(function()
				local yes = false
				repeat
					if not t then
						yes = true
						f:Destroy()
					end
					rs(ur)
				until yes
			end)
			return f.Highlight,f.BillboardGui.Frame,f.BillboardGui.TextLabel
		end
	end
end
workspace.DescendantAdded:Connect(function(va)
	if Exist(va) and t then
		for i,v in pairs(va:GetDescendants()) do
			if Exist(v) and v:IsA("ProximityPrompt") and t then
				instant(function()
					repeat
						fire(v)
						v.MaxActivationDistance = activateDistance
						rs(ur/6)
					until not v or not t
				end)
			end
			if Exist(v) and t then
				local f = ESP.Doors
				if f[v.Name] and v:IsA(f[v.Name].Class) and v:IsDescendantOf(f[v.Name].DescendantOf) then
					instant(function()
						repeat
							local h,c,t = MakeESP(v)
							h.OutlineColor = f[v.Name].Color
							h.FillColor = f[v.Name].Color
							c.BackgroundColor3 = f[v.Name].Color
							t.TextColor3 = f[v.Name].Color
							if f[v.Name].UseHL == false then
								h.FillTransparency = 1
								h.OutlineTransparency = 1
							else
								h.FillTransparency = 0.5
								h.OutlineTransparency = 0
							end
							if Exist(v) and v.Name == "Door" then
								local txt = ""
								if v.Parent:FindFirstChild("Sign") and v.Parent.Sign:FindFirstChild("Stinker") then
									txt = v.Parent.Sign.Stinker.Text
								else
									txt = "Door"
								end
								t.Text = txt
							elseif Exist(v) and v.Name == "KeyObtain" then
								t.Text = "Key ["..v:WaitForChild("Sign"):WaitForChild("Label").Text.."]"
							elseif Exist(v) and v.Name == "LiveHintBook" then
								t.Text = "Hint book"
							elseif Exist(v) then
								t.Text = v.Name
							end
							rs(ur)
						until not v or not t
					end)
				end
				local f = ESP.Enteties
				if f[v.Name] and v:IsA(f[v.Name].Class) and v:IsDescendantOf(f[v.Name].DescendantOf) then
					instant(function()
						repeat
							local h,c,t = MakeESP(v)
							h.OutlineColor = f[v.Name].Color
							h.FillColor = f[v.Name].Color
							c.BackgroundColor3 = f[v.Name].Color
							t.TextColor3 = f[v.Name].Color
							if f[v.Name].UseHL == false then
								h.FillTransparency = 1
								h.OutlineTransparency = 1
							else
								h.FillTransparency = 0.5
								h.OutlineTransparency = 0
							end
							if Exist(v) and v.Name == "RushMoving" then
								t.Text = "Rush"
							elseif Exist(v) and v.Name == "AmbushMoving" then
								t.Text = "Ambush"
							elseif Exist(v) and v.Name == "SeekMoving" then
								t.Text = "Seek"
							elseif Exist(v) and v.Name == "FigureRagdoll" then
								t.Text = "Figure"
							end
							rs(ur)
						until not v or not t
					end)
				end
			end
		end
		if va:IsA("ProximityPrompt") and t then
			repeat
				fire(va)
				va.MaxActivationDistance = activateDistance
				rs(ur/6)
			until not va or not t
		end
		local v = va
		if Exist(v) and t then
			local f = ESP.Doors
			if f[v.Name] and v:IsA(f[v.Name].Class) and v:IsDescendantOf(f[v.Name].DescendantOf) then
				instant(function()
					repeat
						local h,c,t = MakeESP(v)
						h.OutlineColor = f[v.Name].Color
						h.FillColor = f[v.Name].Color
						c.BackgroundColor3 = f[v.Name].Color
						t.TextColor3 = f[v.Name].Color
						t.Parent.Enabled = doorESP
						h.Enabled = doorESP
						if f[v.Name].UseHL == false then
							h.FillTransparency = 1
							h.OutlineTransparency = 1
						else
							h.FillTransparency = 0.5
							h.OutlineTransparency = 0
						end
						if Exist(v) and v.Name == "Door" then
							local txt = ""
							if v.Parent:FindFirstChild("Sign") and v.Parent.Sign:FindFirstChild("Stinker") then
								txt = v.Parent.Sign.Stinker.Text
							else
								txt = "Door"
							end
							t.Text = txt
						elseif Exist(v) and v.Name == "KeyObtain" then
							t.Text = "Key ["..v:WaitForChild("Sign"):WaitForChild("Label").Text.."]"
						elseif Exist(v) and v.Name == "LiveHintBook" then
							t.Text = "Hint book"
						elseif Exist(v) then
							t.Text = v.Name
						end
						rs(ur)
					until not v or not t
				end)
			end
			local f = ESP.Enteties
			if f[v.Name] and v:IsA(f[v.Name].Class) and v:IsDescendantOf(f[v.Name].DescendantOf) then
				instant(function()
					repeat
						local h,c,t = MakeESP(v)
						h.OutlineColor = f[v.Name].Color
						h.FillColor = f[v.Name].Color
						c.BackgroundColor3 = f[v.Name].Color
						t.TextColor3 = f[v.Name].Color
						t.Parent.Enabled = entityESP
						h.Enabled = entityESP
						if f[v.Name].UseHL == false then
							h.FillTransparency = 1
							h.OutlineTransparency = 1
						else
							h.FillTransparency = 0.5
							h.OutlineTransparency = 0
						end
						if Exist(v) and v.Name == "RushMoving" then
							t.Text = "Rush"
						elseif Exist(v) and v.Name == "AmbushMoving" then
							t.Text = "Ambush"
						elseif Exist(v) and v.Name == "SeekMoving" then
							t.Text = "Seek"
						elseif Exist(v) and v.Name == "FigureRagdoll" then
							t.Text = "Figure"
						end
						rs(ur)
					until not v or not t
				end)
			end
		end
	end
end)
for i,v in pairs(workspace:GetDescendants()) do
	if Exist(v) and v:IsA("ProximityPrompt") and t then
		instant(function()
			repeat
				fire(v)
				v.MaxActivationDistance = activateDistance
				rs(ur/6)
			until not v or not t
		end)
	end
	if Exist(v) and t then
		local f = ESP.Doors
		if f[v.Name] and v:IsA(f[v.Name].Class) and v:IsDescendantOf(f[v.Name].DescendantOf) then
			instant(function()
				repeat
					local h,c,t = MakeESP(v)
					h.OutlineColor = f[v.Name].Color
					h.FillColor = f[v.Name].Color
					c.BackgroundColor3 = f[v.Name].Color
					t.TextColor3 = f[v.Name].Color
					t.Parent.Enabled = doorESP
					h.Enabled = doorESP
					if f[v.Name].UseHL == false then
						h.FillTransparency = 1
						h.OutlineTransparency = 1
					else
						h.FillTransparency = 0.5
						h.OutlineTransparency = 0
					end
					if Exist(v) and v.Name == "Door" then
						local txt = ""
						if v.Parent:FindFirstChild("Sign") and v.Parent.Sign:FindFirstChild("Stinker") then
							txt = v.Parent.Sign.Stinker.Text
						else
							txt = "Door"
						end
						t.Text = txt
					elseif Exist(v) and v.Name == "KeyObtain" then
						t.Text = "Key ["..v:WaitForChild("Sign"):WaitForChild("Label").Text.."]"
					elseif Exist(v) and v.Name == "LiveHintBook" then
						t.Text = "Hint book"
					elseif Exist(v) then
						t.Text = v.Name
					end
					rs(ur)
				until not v or not t
			end)
		end
		local f = ESP.Enteties
		if f[v.Name] and v:IsA(f[v.Name].Class) and v:IsDescendantOf(f[v.Name].DescendantOf) then
			instant(function()
				repeat
					local h,c,t = MakeESP(v)
					h.OutlineColor = f[v.Name].Color
					h.FillColor = f[v.Name].Color
					c.BackgroundColor3 = f[v.Name].Color
					t.TextColor3 = f[v.Name].Color
					t.Parent.Enabled = entityESP
					h.Enabled = entityESP
					if f[v.Name].UseHL == false then
						h.FillTransparency = 1
						h.OutlineTransparency = 1
					else
						h.FillTransparency = 0.5
						h.OutlineTransparency = 0
					end
					if Exist(v) and v.Name == "RushMoving" then
						t.Text = "Rush"
					elseif Exist(v) and v.Name == "AmbushMoving" then
						t.Text = "Ambush"
					elseif Exist(v) and v.Name == "SeekMoving" then
						t.Text = "Seek"
					elseif Exist(v) and v.Name == "FigureRagdoll" then
						t.Text = "Figure"
					end
					rs(ur)
				until not v or not t
			end)
		end
	end
end
local Tab = Window:NewTab("Lighting")
local Section = Tab:NewSection("Control lights in the game")
local fb = false
Section:NewToggle("Brightness", "Will delete the shadows", function(state)
	fb = state
	if fb then
		game.Lighting.Ambient = Color3.new(1,1,1)
		game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
		game.Lighting.Brightness = 1
		game.Lighting.ColorShift_Bottom = Color3.new(1,1,1)
		game.Lighting.FogEnd = 100000
	end
end)
game.Lighting.Changed:Connect(function()
	if fb and t then
		game.Lighting.Ambient = Color3.new(1,1,1)
		game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
		game.Lighting.Brightness = 1
		game.Lighting.ColorShift_Bottom = Color3.new(1,1,1)
		game.Lighting.FogEnd = 100000
	end
end)
local Tab = Window:NewTab("ESP")
local Section = Tab:NewSection("ESP settings")
Section:NewToggle("ESP Items", "Will ESP all that will help you play the game", function(state)
	doorESP = state
end)
Section:NewToggle("ESP Enteties", "Will ESP all enteties", function(state)
	entityESP = state
end)
local plrESP = false
Section:NewToggle("ESP Players", "Will ESP all players", function(state)
	plrESP = state
end)
for i,player in pairs(game.Players:GetPlayers()) do
	if player and player ~= plr then
		local character = player.Character or player.CharacterAdded:Wait()
		instant(function()
			repeat
				local h,c,t = MakeESP(player.Character)
				h.FillColor = character:WaitForChild("Head").Color
				h.OutlineColor = h.FillColor
				c.BackgroundColor3 = h.FillColor
				t.TextColor3 = h.FillColor
				t.Parent.Enabled = plrESP
				h.Enabled = plrESP
			until not player or not t
		end)
	end
end
game.Players.PlayerAdded:Connect(function(player)
	if player and player ~= plr then
		local character = player.Character or player.CharacterAdded:Wait()
		instant(function()
			repeat
				local h,c,t = MakeESP(player.Character)
				h.FillColor = character:WaitForChild("Head").Color
				h.OutlineColor = h.FillColor
				c.BackgroundColor3 = h.FillColor
				t.TextColor3 = h.FillColor
				t.Parent.Enabled = plrESP
				h.Enabled = plrESP
			until not player or not t
		end)
	end
end)
repeat
	if noclip then
		for _, child in pairs(char:GetDescendants()) do
			if child:IsA("BasePart") and child.CanCollide == true then
				child.CanCollide = false
			end
		end
	else
		hrp.CanCollide = true
	end
	rs(1)
until not t
