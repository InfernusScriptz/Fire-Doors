local Name = "Fire Doors [2.0.0]"
local loadInLobby = false
local quickLoad = false

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
	wait(7)
else
	wait(0.1)
end



if not fireproximityprompt then
	Notificate(Name,"You exploit dont supporting fireproximityprompt function! Imitated function!")
    function fireproximityprompt(Obj, Amount, Skip)
        if Obj and Obj.ClassName == "ProximityPrompt" then 
            Amount = Amount or 1
            local PromptTime = Obj.HoldDuration
            if Skip then 
                Obj.HoldDuration = 0
            end
            for i = 1, Amount do 
                Obj:InputHoldBegin()
                if not Skip then 
                    wait(Obj.HoldDuration)
                end
                Obj:InputHoldEnd()
            end
            Obj.HoldDuration = PromptTime
        end
    end
end
if not fireclickdetector then
	Notificate(Name,"You exploit dont supporting fireclickdetector function! Imitation function is impossible!",10)
    function fireclickdetector() 
    end
end
if not firetouchinterest then
	Notificate(Name,"You exploit dont supporting firetouchinterest function! Imitated function!")
    function firetouchinterest(tt)
        if tt and tt.Parent and tt.Parent:IsA("BasePart") and v:IsA("TouchTransmitter") then
            local prevPos = character:WaitForChild("HumanoidRootPart").CFrame
            character:WaitForChild("HumanoidRootPart").CFrame = tt.Parent.CFrame
            task.wait(0)
            character:WaitForChild("HumanoidRootPart").CFrame = prevPos
            warn("Bypassed fire tounch interest/touch transmitter function")
        elseif tt and tt.Parent and tt:IsA("BasePart") then
            local prevPos = character:WaitForChild("HumanoidRootPart").CFrame
            character:WaitForChild("HumanoidRootPart").CFrame = tt.CFrame
            task.wait(0)
            character:WaitForChild("HumanoidRootPart").CFrame = prevPos
        end
    end
end
if not firetouchtransmitter then
	Notificate(Name,"You exploit dont supporting firetouchtransmitter function! Imitated function!")
    firetouchtransmitter = firetouchinterest
end

if not quickLoad then
	wait(3)
else
	wait(0.1)
end

if not game.ReplicatedStorage:FindFirstChild("GameData") or not game.ReplicatedStorage.GameData:FindFirstChild("Floor") or not game.ReplicatedStorage.GameData.Floor:IsA("StringValue") then
	Notificate(Name,"You must be in doors to execute that script!")
	return 
elseif game.ReplicatedStorage:FindFirstChild("GameData") and game.ReplicatedStorage.GameData:FindFirstChild("Floor") and game.ReplicatedStorage.GameData.Floor:IsA("StringValue") then
	if game.ReplicatedStorage.GameData.Floor.Value == "Lobby" and not loadInLobby then
		Notificate(Name,"You must be in game [Not lobby] to execute that script!")
		return
	elseif workspace:FindFirstChild("Lobby") and workspace.Lobby:FindFirstChild("Parts") and #workspace.Lobby.Parts:GetChildren() >= 1 and not loadInLobby then
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

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(Name, "BloodTheme")
local Tab = Window:NewTab("Character")
local Section = Tab:NewSection("Character settings")
local noclip = false
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("Collision")
local hum = char:WaitForChild("Humanoid")
local waitFrames = function(times)
	local times = times or 1
	for i=1,times do
		game["Run Service"].Stepped:Wait()
	end
end
local function getDistance(from)
	if from and from:IsA("BasePart") then
		return (hrp.Position-from.Position).Magnitude
	else
		return 0
	end
end
local function isNumber(str)
	if tonumber(str) ~= nil or str == 'inf' then
		return true
	end
end
local rs = waitFrames
local instant = function(func)
	return coroutine.wrap(func)()
end
Section:NewToggle("Noclip", "Makes you walk trough the walls", function(state)
    noclip = state
end)
Section:NewSlider("Extra Speed", "Makes you walk faster", 6.4, 0.1, function(s)
    hum:SetAttribute("SpeedBoost",s)
end)
local jumpAllowed = false
game.UserInputService.JumpRequest:Connect(function()
	if jumpAllowed and hum.FloorMaterial ~= Enum.Material.Air and hum.FloorMaterial ~= nil then
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
local activateDistance = 6
Section:NewSlider("Distance multiplier", "You will interact with drawest, keys and etc more than normally", 2.2, 1, function(s)
	activateDistance = 6 * s
	for i,v in pairs(workspace:GetDescendants()) do
		if v and v:IsA("ProximityPrompt") then
			v.MaxActivationDistance = activateDistance
		end
	end
end)
workspace.DescendantAdded:Connect(function(child)
	if child then
		if child:IsA("ProximityPrompt") then
			child.MaxActivationDistance = activationDistance
		end
		for i,v in pairs(child:GetDescendants()) do
			if v and v:IsA("ProximityPrompt") then
				v.MaxActivationDistance = activateDistance
			end
		end
	end
end)
local instantInteract = false
Section:NewToggle("Instant Activate", "Will make you interact with items instantly", function(state)
    instantInteract = state
end)
game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
	if instantInteract then
		prompt:InputHoldEnd()
		fireproximityprompt(prompt,1,true)
	end
end)
local autoLoot = false
Section:NewToggle("Auto loot", "Will automatically loot dressers", function(state)
    autoLoot = state
end)
function autoLootFunc(room)
	print("Auto", room)
	if room then
		repeat wait(0.1) until room:FindFirstChild("Assets") or not room
		if not room then return end
		instant(function()
			repeat
				if room:FindFirstChild("Closet") then
					
				end
				wait(0.1)
			until not room
		end)
		for _,part in pairs(room.Assets:GetChildren()) do
			if part and part:IsA("Model") then
				if part.Name == "Dresser" or part.Name == "Table" or part.Name == "Rolltop_Desk" then
					part.DescendantAdded:Connect(function(whatAdded)
						if whatAdded then
							for i,v in pairs(whatAdded:GetDescendants()) do
								if v and v:IsA("ProximityPrompt") and v.Parent:IsA("BasePart") and getDistance(v.Parent) <= activateDistance then
									fireproximityprompt(v)
								end
							end
							if whatAdded:IsA("ProximityPrompt") and whatAdded.Parent:IsA("BasePart") and getDistance(whatAdded.Parent) <= activateDistance then
								fireproximityprompt(whatAdded)
							end
						end
					end)
					instant(function()
						repeat wait(0.1) until getDistance(part:FindFirstChild("Main")) <= activateDistance or not part
						if not part then return end
						for _,pp in pairs(part:GetDescendants()) do
							instant(function()
								repeat
									if pp and pp.Parent and pp:IsA("ProximityPrompt") and pp.ActionText ~= "Close" and autoLoot and pp.Enabled and pp.Parent:IsA("BasePart") and getDistance(pp.Parent) <= activateDistance then
										fireproximityprompt(pp,1,false)
									end
									wait(0.1)
								until not pp
							end)
						end
					end)
				end
			end
		end
	end
end
for _,room in pairs(workspace.CurrentRooms:GetChildren()) do
	instant(function() autoLootFunc(room) end)
end
workspace.CurrentRooms.ChildAdded:Connect(function(room)
	print(room)
	autoLootFunc(room)
end)
workspace.DescendantAdded:Connect(function(va)
	if va then
		for i,v in pairs(va:GetDescendants()) do
			if v and v:IsA("ProximityPrompt") then
				instant(function()
					repeat
						v.MaxActivationDistance = activateDistance
						wait(0.1)
					until not v
				end)
			end
		end
		if va:IsA("ProximityPrompt") then
			repeat
				va.MaxActivationDistance = activateDistance
				wait(0.1)
			until not va
		end
	end
end)
while true do
	if noclip then
		for _, child in pairs(char:GetDescendants()) do
			if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
				child.CanCollide = false
			end
		end
	end
	rs()
end
