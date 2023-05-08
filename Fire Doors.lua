local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Fire Doors [2.0.0]", "BloodTheme")
local Tab = Window:NewTab("Character")
local Section = Tab:NewSection("--Character--")
local noclip = false
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local waitFrames = function(times)
	local times = times or 1
	for i=1,times do
		game["Run Service"].RenderStepped:Wait()
	end
end
local rs = waitFrames
local dontWait = function(func)
	return coroutine.wrap(func)()
end
Section:NewToggle("Noclip", "Makes you walk trough the walls", function(state)
    noclip = state
    for i,v in pairs(char:GetChildren()) do
		if v and v:IsA("BasePart") then
			v.CanCollide = not noclip
		end
	end
end)
while true do
	rs()
end
