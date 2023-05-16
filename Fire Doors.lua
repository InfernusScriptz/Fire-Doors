local actualName = "Fire Doors"
local version = "2.0.2"
local fullName = actualName.." ["..version.."]"
local ppNames = {
	["ModulePrompt"] = true,
	["ActivateEventPrompt"] = true,
	["LootPrompt"] = true,
	["SkipPrompt"] = true,
	["HerbPrompt"] = true,
	["AwesomePrompt"] = true,
}
local connectedFunctions = {}
local bools = {
	["nill"] = true,
	["DoorESP"] = false,
	["EntityESP"] = false,
	["PlayerESP"] = false,
	["AutoInteract"] = false,
	["Noclipping"] = false,
	["EnableAllInteractables"] = false,
	["NotifyEntities"] = false,
	["God"] = false,
	["ItemESP"] = false,
	["InstantInteract"] = false,
}
local Font = Enum.Font.Oswald
local logoImage = "http://www.roblox.com/asset/?id=876744268"
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local gui = plr.PlayerGui or plr:WaitForChild("PlayerGui") or game.CoreGui
local bp = plr.Backpack or plr:WaitForChild("Backpack")
local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Collision") or char:FindFirstChildOfClass("BasePart")
local hum = char:WaitForChild("Humanoid")
local event = Instance.new("BindableEvent",plr)
local fireproximityprompt = fireproximityprompt or function(Obj, Amount, Skip)
	local Skip = Skip or false
	if Obj and Obj.Parent and Obj:IsA("ProximityPrompt") then 
		local Amount = Amount or 1
		if Amount == 0 or Amount <= 0 then
			Amount = 1
		end
		local PromptTime = Obj.HoldDuration
		if Skip == true then 
			Obj.HoldDuration = 0
		end
		for i = 1, Amount do 
			Obj:InputHoldBegin()
			if not Skip then 
				task.wait(Obj.HoldDuration)
			end
			Obj:InputHoldEnd()
		end
		Obj.HoldDuration = PromptTime
	end
end
local rs = function(times)
	local times = times or 1
	if times == 0 or times <= 0 then
		times = 1
	end
	times = math.round(times)
	for i=1,times do
		game["Run Service"].Stepped:Wait()
	end
end
local closed = false
local distanceMult = 0
local function randomString(amoutOfSymbols)
	local symbols = string.split([[qSEPwSEPeSEPrSEPtSEPySEPuSEPiSEPoSEPpSEPaSEPsSEPdSEPfSEPgSEPhSEPjSEPkSEPlSEPzSEPxSEPcSEPvSEPbSEPnSEPmSEP1SEP2SEP3SEP4SEP5SEP6SEP7SEP8SEP9SEP0SEP-SEP=SEP`SEP\SEP/SEP.SEP,SEP+SEP_SEP*SEP;SEP:SEP'SEP"SEP]SEP[SEP SEP|SEP!SEP@SEP#SEP$SEP%SEP^SEP&SEP&SEP(SEP)SEP?SEP 
]],"SEP")
	local context = ""
	amoutOfSymbols = amoutOfSymbols or math.random(1, 250)
	if amoutOfSymbols == 0 or amoutOfSymbols <= 0 then
		amoutOfSymbols = math.random(1,250)
	end
	for i=1,amoutOfSymbols do
		local uorl = false
		if math.random(1,2) == 1 then
			uorl = true
		end
		local addSymbol = symbols[math.random(1,#symbols)]
		if uorl then
			addSymbol = string.upper(addSymbol)
		end
		context = context..addSymbol
	end
	return context
end
event.Name = randomString()
coroutine.wrap(function()
	while wait(1) do
		event.Name = randomString()
	end
end)()
local function esp(target,color,text,boolName)
	local color = color or Color3.fromRGB(255,255,255)
	if target then
		text = text or target.Name
	end
	local boolName = boolName or "nill"
	if bools[boolName] == nil then
		boolName = "nill"
	end
	local function esp(target)
		local espDetected = false
		local fldr = nil
		if target and target.Parent  then
			for i,v in pairs(target:GetChildren()) do
				if v and v.Parent and v:IsA("Folder") and string.match(string.lower(v:GetFullName()),"esp") then
					espDetected = true
					fldr = v
				end
			end
		end
		if target and target.Parent and not espDetected then
			local folder = Instance.new("Folder",target)
			folder.Name = "esp"..randomString()
			local esp = Instance.new("Highlight",folder)
			esp.OutlineColor = color
			esp.FillColor = color
			esp.Adornee = target
			esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			esp.OutlineTransparency = 0.75
			esp.OutlineTransparency = 0
			local bg = Instance.new("BillboardGui",folder)
			bg.Size = UDim2.fromOffset(100,100)
			bg.Brightness = 1
			bg.AlwaysOnTop = true
			bg.MaxDistance = 1000
			bg.Adornee = target
			local frame = Instance.new("Frame",bg)
			frame.BackgroundColor3 = color
			frame.AnchorPoint = Vector2.new(0.5,0.5)
			frame.Position = UDim2.fromScale(0.5,0.5)
			frame.Size = UDim2.fromScale(0.1,0.1)
			local txt = Instance.new("TextLabel",bg)
			txt.Text = text
			txt.BackgroundTransparency = 1
			txt.Size = UDim2.fromScale(1,0.2)
			txt.AnchorPoint = Vector2.new(0.5,0.5)
			txt.Position = UDim2.fromScale(0.5,0.65)
			txt.Font = Font
			txt.TextScaled = true
			txt.TextColor3 = color
			local stroke = Instance.new("UIStroke",txt)
			stroke.Thickness = 3
			stroke.Color = Color3.fromRGB(0,0,0)
			local stroke = Instance.new("UIStroke",frame)
			stroke.Thickness = 3
			stroke.Color = Color3.fromRGB(0,0,0)
			local corner = Instance.new("UICorner",frame)
			corner.CornerRadius = UDim.new(1,0)
			for i,v in pairs(folder:GetDescendants()) do
				if v then
					v.Name = randomString()
				end
			end
			coroutine.wrap(function()
				repeat
					if target and target.Parent then
						if bools[boolName] == true then
							esp.Enabled = bools[boolName]
							bg.Enabled = esp.Enabled
						else
							esp.Enabled = false
							bg.Enabled = esp.Enabled
						end
					end
					rs(1)
				until not target
			end)()
			return esp,frame,txt
		elseif target and target.Parent and espDetected and fldr then
			local esp =  fldr:FindFirstChildOfClass("Highlight")
			local bg = fldr:FindFirstChildOfClass("BillboardGui")
			local frame = fldr:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("Frame")
			local txt = fldr:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("TextLabel")
			coroutine.wrap(function()
				repeat
					if target and target.Parent then
						if bools[boolName] == true then
							esp.Enabled = bools[boolName]
							bg.Enabled = esp.Enabled
						else
							esp.Enabled = false
							bg.Enabled = esp.Enabled
						end
					end
					rs(1)
				until not target
			end)()
			return esp,frame,txt
		end
	end
	if not target:IsA("Instance") then return end
	return esp(target)
end
function descendant(d)
	coroutine.wrap(function()
		if d then
			if d:IsA("BasePart") then
				if d.Transparency == 0 then
					d.Transparency = 0.01
				end
				d.CanQuery = false
			end
			if d:IsA("ProximityPrompt") and ppNames[d.Name] then
				repeat
					if not d then return end
					d.MaxActivationDistance = 6*(distanceMult+1)
					if bools.AutoInteract and getDistance(d.Parent,hrp) and getDistance(d.Parent,hrp) <= d.MaxActivationDistance and d.Enabled and d.ActionText ~= "Close" and d.ObjectText ~= "Close" then
						fireproximityprompt(d,1,true)
					end
					if d.Enabled == false and bools.EnableAllInteractables and d.ActionText ~= "Close" and d.ObjectText ~= "Close" then
						d.Enabled = true
					end
					if d.ActionText == "Close" or d.ObjectText == "Close" then
						d.Enabled = not bools.AutoInteract
					end
					rs(1)
				until not d or closed
			end
			if d:IsA("Model") then
				if d.Name == "KeyObtain" then
					esp(d,Color3.fromRGB(0,150,0),"Key","ItemESP")
				end
				if d.Name == "LiveHintBook" then
					esp(d,Color3.fromRGB(0,150,150),"Hint","ItemESP")
				end
				if d.Name == "LiveBreakerPolePickup" then
					esp(d,Color3.fromRGB(150,50,0),"Breaker","ItemESP")
				end
				if d.Parent == workspace and string.match(d.Name,"Moving") then
					event:Fire("Entity",d)
				end
				if d.Name == "FigureRagdoll" and d.Parent ~= workspace then
					esp(d,Color3.fromRGB(255,0,0),"Figure","EntityESP")
				end
				if d.Name == "Door" and isnumber(d.Parent.Name) then
					esp(d:WaitForChild("Door"),Color3.fromRGB(170, 109, 35),tostring(tonumber(d.Parent.Name)+1),"DoorESP")
				end
			end
		end
	end)()
end
function isnumber(txt)
	if tonumber(txt) ~= nil or txt == "inf" then
		return true
	else
		return false
	end
end
local inGodMode = false
function getDistance(I1,I2)
	if I1 and I2 then
		local function get(I)
			if I:IsA("BasePart") then
				return I.Position
			end
			if I:IsA("Model") then
				return I.WorldPivot.Position
			end
			if I:IsA("Attachment") then
				return I.WorldPosition
			end
			return nil
		end
		if get(I1) and get(I2) then
			return (get(I1)-get(I2)).Magnitude
		end
	end
end
connectedFunctions[#connectedFunctions+1] = game.Players.PlayerAdded:Connect(function(player)
	if player.Character then
		esp(player.Character,player.Character:WaitForChild("Head").Color,player.Name,"PlayerESP")
	end
	connectedFunctions[#connectedFunctions+1] = player.CharacterAdded:Connect(function(character)
		esp(character,character:WaitForChild("Head").Color,player.Name,"PlayerESP")
	end)
end)
for i,player in pairs(game.Players:GetPlayers()) do
	if player.Character then
		esp(player.Character,player.Character:WaitForChild("Head").Color,player.Name,"PlayerESP")
	end
	connectedFunctions[#connectedFunctions+1] = player.CharacterAdded:Connect(function(character)
		esp(character,character:WaitForChild("Head").Color,player.Name,"PlayerESP")
	end)
end
local loaded = _G.loaded123FireDoors
if not loaded then
	local load = randomString()
	_G.loaded123FireDoors = load
	loaded = load
else
	return error(fullName..":"..[[The script is loaded!]],2)
end
local screenGui = Instance.new("ScreenGui",gui)
coroutine.wrap(function()
	while true do
		for i,v in pairs(screenGui:GetDescendants()) do
			if v then
				v.Name = randomString()
			end
		end
		screenGui.Name = randomString()
		rs(60)
	end
end)()
screenGui.DisplayOrder = 25000
local mainFrame = Instance.new("Frame",screenGui)
mainFrame.Size = UDim2.fromScale(0,0.4)
game.TweenService:Create(mainFrame,TweenInfo.new(2,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(0.3,0.4)}):Play()
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
mainFrame.Position = UDim2.fromScale(0.5,0.5)
local invisTopFrame = Instance.new("TextButton",screenGui)
local topFrame = Instance.new("Frame",mainFrame)
topFrame.BorderSizePixel = 0
topFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
topFrame.Size = UDim2.fromScale(1,0.1)
invisTopFrame.Text = ""
invisTopFrame.BackgroundTransparency = 1
invisTopFrame.AnchorPoint = Vector2.new(0.5,0.5)
invisTopFrame.Draggable = true
invisTopFrame.Changed:Connect(function(state)
	if state ~= "Position" then return end
	mainFrame.Position = invisTopFrame.Position
	mainFrame.Position = UDim2.new(mainFrame.Position.X.Scale,mainFrame.Position.X.Offset,0.5,mainFrame.Position.Y.Offset)
end)
invisTopFrame.Position = UDim2.fromScale(0.5,0.32)
invisTopFrame.Size = UDim2.fromScale(0.3,0.04)
local title = Instance.new("TextLabel",topFrame)
title.BackgroundTransparency = 1
title.Text = fullName
title.TextColor3 = Color3.fromRGB(0,0,0)
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Font
local stroke = Instance.new("UIStroke",title)
stroke.Thickness = 3
title.Size = UDim2.fromScale(0.3,1)
title.Position = UDim2.fromScale(0.075,0)
stroke.Color = Color3.fromRGB(255,255,255)
local grad = Instance.new("UIGradient",stroke)
grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,255,0))}
local logo = Instance.new("ImageLabel",topFrame)
logo.BackgroundTransparency = 1
logo.Size = UDim2.fromScale(0.1,0.8)
logo.Position = UDim2.fromScale(0.01,0.1)
logo.Image = logoImage
local as = Instance.new("UIAspectRatioConstraint",logo)
as.AspectRatio = 1
local corner = Instance.new("UICorner",logo)
corner.CornerRadius = UDim.new(1,0)
local mainStroke = stroke
local stroke = stroke:Clone()
stroke.Parent = logo
stroke.Color = Color3.fromRGB(0,0,0)
local stroke = stroke:Clone()
stroke.Parent = mainFrame
local close = Instance.new("TextButton",topFrame)
close.Size = UDim2.fromScale(0.1,0.8)
close.Position = UDim2.fromScale(0.89,0.1)
close.Text = "X"
close.TextScaled = true
close.BackgroundColor3 = Color3.fromRGB(100,0,0)
close.TextColor3 = Color3.fromRGB(255,255,255)
close.Font = Font
close.BorderSizePixel = 0
close.ZIndex = 2
close.MouseButton1Click:Connect(function()
	if closed then return end
	closed = true
	if inGodMode then
		char.Collision.Position += Vector3.new(0,10,0)
	end
	_G.loaded123FireDoors = nil
	game.TweenService:Create(mainFrame,TweenInfo.new(2,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(0,0)}):Play()
	for i,v in pairs(bools) do
		if i and v then
			bools[i] = false
		end
	end
	for i,v in pairs(ppNames) do
		if i and v then
			ppNames[i] = false
		end
	end
	for i,v in pairs(connectedFunctions) do
		if i and v then
			connectedFunctions[i]:Disconnect()
		end
	end
	wait(0)
	hum:SetAttribute("SpeedBoost",0)
	task.wait(2)
	screenGui:Destroy()
end)
local minimize = close:Clone()
minimize.Parent = close.Parent
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(150,150,150)
minimize.Position = UDim2.fromScale(0.78,0.1)
local minimized = false
local oldpos = invisTopFrame.Position
local maximize = Instance.new("TextButton",screenGui)
maximize.BorderSizePixel = 3
maximize.BorderColor3 = Color3.fromRGB(0,0,0)
maximize.Text = "+"
maximize.AnchorPoint = Vector2.new(0.5,0.5)
maximize.TextColor3 = Color3.fromRGB(0,0,0)
maximize.Position = UDim2.fromScale(1.2,0.5)
maximize.Size = UDim2.fromScale(0.05,0.2)
maximize.BackgroundColor3 = minimize.BackgroundColor3
maximize.TextScaled = true
maximize.MouseButton1Click:Connect(function()
	if not minimized or closed then return end
	minimized = false
	mainFrame.Visible = true
	game.TweenService:Create(maximize,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Position = UDim2.fromScale(1.2,0.5)}):Play()
	game.TweenService:Create(mainFrame,TweenInfo.new(2,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(0.3,0.4)}):Play()
	wait(1)
	mainFrame.Visible = true
	wait(1)
	mainFrame.Visible = true
end)
minimize.MouseButton1Click:Connect(function()
	if minimized or closed then return end
	minimized = true
	game.TweenService:Create(mainFrame,TweenInfo.new(2,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(0,0)}):Play()
	game.TweenService:Create(maximize,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Position = UDim2.fromScale(1,0.5)}):Play()
	task.wait(1.8)
	mainFrame.Visible = false
end)
connectedFunctions[#connectedFunctions+1] = workspace.DescendantAdded:Connect(descendant)
local pagelist = Instance.new("ScrollingFrame",mainFrame)
pagelist.Size = UDim2.fromScale(0.2,0.9)
pagelist.Position = UDim2.fromScale(0,0.1)
pagelist.BackgroundColor3 = topFrame.BackgroundColor3
pagelist.BorderSizePixel = 0
pagelist.CanvasSize = UDim2.fromScale(0,0)
pagelist.ChildAdded:Connect(function()
	pagelist.CanvasSize = UDim2.fromOffset(0,(#pagelist:GetChildren()-1)*55)
end)
pagelist.ChildRemoved:Connect(function()
	pagelist.CanvasSize = UDim2.fromOffset(0,(#pagelist:GetChildren()-1)*55)
end)
local grid = Instance.new("UIGridLayout",pagelist)
grid.CellPadding = UDim2.fromOffset(0,5)
grid.CellSize = UDim2.new(1,0,0,50)
grid.SortOrder = Enum.SortOrder.LayoutOrder
local pagesFolder = Instance.new("Folder",mainFrame)
local pageList = {}
function pageList:AddPage(pageName)
	local btn = Instance.new("TextButton",pagelist)
	btn.Text = pageName
	btn.TextScaled = true
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Font 
	btn.BackgroundColor3 = pagelist.BackgroundColor3
	btn.BorderSizePixel = 0
	local frame = Instance.new("ScrollingFrame",pagesFolder)
	frame.Size = UDim2.fromScale(0.8,0.9)
	frame.BackgroundColor3 = mainFrame.BackgroundColor3
	frame.Position = UDim2.fromScale(0.2,0.1)
	frame.BorderSizePixel = 0
	frame.CanvasSize = UDim2.fromScale(0,0)
	frame.ChildAdded:Connect(function()
		frame.CanvasSize = UDim2.fromOffset(0,(#frame:GetChildren()-1)*55)
	end)
	frame.ChildRemoved:Connect(function()
		frame.CanvasSize = UDim2.fromOffset(0,(#frame:GetChildren()-1)*55)
	end)
	frame.Visible = false
	btn.MouseButton1Click:Connect(function()
		for i,v in pairs(pagesFolder:GetChildren()) do
			v.Visible = false
		end
		frame.Visible = true
	end)
	local grid = Instance.new("UIGridLayout",frame)
	grid.CellPadding = UDim2.fromOffset(0,5)
	grid.CellSize = UDim2.new(1,0,0,50)
	grid.SortOrder = Enum.SortOrder.LayoutOrder
	local funcs = {}
	function funcs:CreateLabel(text)
		local label = Instance.new("TextLabel",frame)
		label.Text = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(50,50,50)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,255,255)
		return label
	end
	function funcs:CreateButton(text,func)
		local label = Instance.new("TextButton",frame)
		label.Text = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(150,150,150)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,255,255)
		label.MouseButton1Click:Connect(func)
		label.TextXAlignment = Enum.TextXAlignment.Left
		return label
	end
	function funcs:CreateTextBox(text,func)
		local label = Instance.new("TextBox",frame)
		label.PlaceholderText = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,75,75)
		label.PlaceholderColor3 = Color3.fromRGB(200,150,150)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,255,255)
		label.ClearTextOnFocus = false
		label.Text = ""
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.FocusLost:Connect(function(enter)
			if enter then
				func(label.Text)
			end
		end)
		return label
	end
	function funcs:CreateSwitch(text,func)
		local toggle = false
		local label = Instance.new("TextButton",frame)
		label.Text = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(150,150,150)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,255,255)
		label.TextXAlignment = Enum.TextXAlignment.Left
		local status = Instance.new("TextLabel",label)
		status.Size = UDim2.fromScale(0.2,0.9)
		status.Position = UDim2.fromScale(0.775,0.05)
		status.BackgroundColor3 = Color3.fromRGB(255,0,0)
		status.Font = Font
		status.TextScaled = true
		status.TextColor3 = Color3.fromRGB(0,0,0)
		status.Text = "OFF"
		local corner = Instance.new("UICorner",status)
		corner.CornerRadius = UDim.new(1,0)
		label.MouseButton1Click:Connect(function()
			toggle = not toggle
			if not toggle then
				status.Text = "OFF"
				game.TweenService:Create(status,TweenInfo.new(0.1),{BackgroundColor3 = Color3.fromRGB(255,0,0)}):Play()
			else
				status.Text = "ON"
				game.TweenService:Create(status,TweenInfo.new(0.1),{BackgroundColor3 = Color3.fromRGB(255,255,0)}):Play()
			end
			func(toggle)
		end)
		return label
	end
	function funcs:CreateSlider(text,minVal,maxVal,step,func)
		local minVal = minVal
		if minVal <= 0 then
			minVal = 0
		end
		local step = step
		if step <= 0 then
			step = 0.1
		end
		local val = minVal
		local label = Instance.new("TextLabel",frame)
		label.Text = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,60)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.TextColor3 = Color3.fromRGB(255,255,255)
		local slideBG = Instance.new("Frame",label)
		slideBG.Size = UDim2.fromScale(0.5,0.9)
		slideBG.Position = UDim2.fromScale(0.44,0.05)
		slideBG.BorderSizePixel = 0
		slideBG.BackgroundColor3 = Color3.fromRGB(50,0,0)
		local valText = Instance.new("TextLabel",slideBG)
		valText.Size = UDim2.fromScale(0.3,1)
		valText.BackgroundTransparency = 1
		valText.Font = Font
		valText.Text = val
		valText.TextScaled = true
		valText.TextColor3 = Color3.fromRGB(255,0,0)
		valText.Position = UDim2.fromScale(-0.4,0)
		valText.TextXAlignment = Enum.TextXAlignment.Right
		local fill = Instance.new("Frame",slideBG)
		fill.Size = UDim2.fromScale(0,1)
		fill.BorderSizePixel = 0
		fill.BackgroundColor3 = Color3.fromRGB(255,0,0)
		local gradient = Instance.new("UIGradient",slideBG)
		gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(100,100,100))}
		gradient.Rotation = 90
		gradient:Clone().Parent = fill
		local add = Instance.new("TextButton",slideBG)
		add.Text = "+"
		add.Size = UDim2.fromScale(0.1,1)
		add.TextScaled = true
		add.Font = Font
		add.TextColor3 = Color3.fromRGB(255,255,255)
		add.Position = UDim2.fromScale(1,0)
		add.BorderSizePixel = 0
		add.BackgroundColor3 = Color3.fromRGB(0,0,0)
		local function formula()
			return (maxVal-(maxVal-val))/maxVal
		end
		add.MouseButton1Click:Connect(function()
			val += step
			if val == maxVal or val >= maxVal then
				val = maxVal
			end
			game.TweenService:Create(fill,TweenInfo.new(0.5),{Size = UDim2.fromScale(formula(),1)}):Play()
			valText.Text = math.round(val*10)/10
			func(val)
		end)
		local minus = add:Clone()
		minus.Parent = add.Parent
		minus.Text = "-"
		minus.Position = UDim2.fromScale(-0.1,0)
		minus.MouseButton1Click:Connect(function()
			val -= step
			if val == minVal or val <= minVal then
				val = minVal
			end
			game.TweenService:Create(fill,TweenInfo.new(0.5),{Size = UDim2.fromScale(formula(),1)}):Play()
			valText.Text = math.round(val*10)/10
			func(val)
		end)
		return label
	end
	return funcs
end
local notificationLabel = Instance.new("Frame",screenGui)
notificationLabel.BackgroundTransparency = 1
notificationLabel.Size = UDim2.fromScale(0.2,1)
notificationLabel.ZIndex = 3
notificationLabel.Position = UDim2.fromScale(0.8,0)
local list = Instance.new("UIListLayout",notificationLabel)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Padding = UDim.new(0.02,0)
list.FillDirection = Enum.FillDirection.Vertical
list.VerticalAlignment = Enum.VerticalAlignment.Bottom
function pageList:Notify(text,time)
	coroutine.wrap(function()
		local time = time or 5
		local frame = Instance.new("Frame",notificationLabel)
		frame.Size = UDim2.fromScale(1,0)
		frame.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
		frame.BorderSizePixel = 0
		local timer = Instance.new("Frame",frame)
		timer.Size = UDim2.fromScale(1,0.05)
		timer.Position = UDim2.fromScale(0,0.1)
		timer.BackgroundColor3 = Color3.fromRGB(85,85,85)
		timer.BorderSizePixel = 0
		timer.ZIndex += 1
		local fframe = timer:Clone()
		fframe.Parent = timer.Parent
		fframe.BackgroundColor3 = Color3.fromRGB(50,50,50)
		fframe.ZIndex -= 1
		local title = Instance.new("TextLabel",frame)
		title.BackgroundTransparency = 1
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.Text = actualName
		title.Font = Font
		title.BorderSizePixel = 0
		title.TextScaled = true
		title.TextColor3 = Color3.fromRGB(255,255,255)
		title.Size = UDim2.fromScale(1,0.1)
		local content = title:Clone()
		content.Parent = frame
		content.Size = UDim2.fromScale(1,0.85)
		content.Position = UDim2.fromScale(0,0.15)
		content.Text = text
		content.TextYAlignment = Enum.TextYAlignment.Top
		game.TweenService:Create(timer,TweenInfo.new(time,Enum.EasingStyle.Linear),{Size = UDim2.fromScale(0,0.05)}):Play()
		game.TweenService:Create(frame,TweenInfo.new(0.5),{Size = UDim2.fromScale(1,0.2)}):Play()
		task.wait(time)
		game.TweenService:Create(frame,TweenInfo.new(0.5,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(1,0)}):Play()
		wait(0.5)
		frame:Destroy()
	end)()
end
pageList.CreatePage = pageList.AddPage
local pagelist = pageList
local page = pageList:AddPage("Main")
page:CreateLabel("Exclusive hub for "..fullName)
page:CreateLabel("Hub was made in 1.5 days")
page:CreateLabel("Whole script was made in [Still in developement]")
page:CreateLabel(fullName.." was made by GodWorldX - Infernus#0863")
page:CreateTextBox("Custom logo [IMAGE ID]",
	function(id)
		logo.Image = id
	end
)
page:CreateTextBox("Custom name",
	function(id)
		title.Text = id
	end
)
page:CreateTextBox([[Make notification: [Prefix: ";"] [Text,time] ]],
	function(id)
		local split = string.split(id,";")
		if not isnumber(split[2]) or #split ~= 2 then
			return
		end
		pagelist:Notify(split[1],tonumber(split[2]))
	end
)
local page = pagelist:AddPage("Character")
page:CreateSwitch("Noclip",
	function(val)
		bools.Noclipping = val
		if bools.Noclipping then
			repeat
				for _, child in pairs(char:GetDescendants()) do
					if child:IsA("BasePart") and child.CanCollide == true then
						child.CanCollide = false
					end
				end
				rs(1)
			until not bools.Noclipping
			char.Collision.CanCollide = true
		end
	end
)
local extraSpeed = 0
connectedFunctions[#connectedFunctions+1] = game["Run Service"].Stepped:Connect(function()
	hum:SetAttribute("SpeedBoost",extraSpeed)
end)
page:CreateSlider("Extra Speed",0,6,1,
	function(val)
		extraSpeed = val
	end
)
local page = pagelist:AddPage("Interactables")
page:CreateSwitch("Auto Interact",
	function(bool)
		bools.AutoInteract = bool
	end
)
page:CreateSlider([[Activation distance
multiplier]],0,1,0.1,
	function(num)
		distanceMult = num
	end
)
page:CreateSwitch("Enable every interactable",
	function(bool)
		bools.EnableAllInteractables = bool
	end
)
page:CreateSwitch("Instant Interact",
	function(bool)
		bools.InstantInteract = bool
	end
)
connectedFunctions[#connectedFunctions+1] = game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(pp)
	if bools.InstantInteract then
		pp:InputHoldEnd()
		fireproximityprompt(pp,1,true)
	end
end)
local page = pagelist:CreatePage("ESP")
page:CreateSwitch("Door ESP",
	function(bool)
		bools.DoorESP = bool
	end
)
page:CreateSwitch("Entity ESP",
	function(bool)
		bools.EntityESP = bool
	end
)
page:CreateSwitch("Player ESP",
	function(bool)
		bools.PlayerESP = bool
	end
)
page:CreateSwitch("Item ESP",
	function(bool)
		bools.ItemESP = bool
	end
)
local page = pagelist:CreatePage("Enteties")
page:CreateSwitch("Notify entities",
	function(bool)
		bools.NotifyEntities = bool
	end
)
page:CreateSwitch("God mode",
	function(bool)
		bools.God = bool
		inGodMode = bool
		if inGodMode then
			char.Collision.Position -= Vector3.new(0,10,0)
		else
			char.Collision.Position += Vector3.new(0,10,0)
		end
	end
)
page:CreateLabel("God mode works only for rush, ambush and eyes")
connectedFunctions[#connectedFunctions+1] = event.Event:Connect(function(state,value)
	if state == "Entity" and value then
		value:WaitForChild("RushNew").Changed:Wait()
		value:WaitForChild("RushNew").Changed:Wait()
		esp(value,Color3.fromRGB(150,0,0),string.split(value.Name,"Moving")[1],"EntityESP")
		if bools.NotifyEntities then
			pagelist:Notify(string.split(value.Name,"Moving")[1].." has spawned!",10)
		end
	end
end)
pagelist:Notify("Welcome to "..actualName..[[!
Thank you for using our tool!
Hope, you will enjoy it :)
(Sorry for a bad visual,
it self-made hub!)]],15)
for i,d in pairs(workspace:GetDescendants()) do
	descendant(d)
end
