local executeType = "Client"
local clientName = ""
if executeType == "Client" and game.Players.LocalPlayer.Name == clientName then
	loadstring(command)()
elseif executeType == "All" then
	loadstring(command)()
end
