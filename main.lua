-- [[ MAIN CORE SCRIPT ]] --
local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, key)
    if self == workspace and key == "GetServerTimeNow" then
        return DateTime.now().UnixTimestamp 
    end
    return oldIndex(self, key)
end)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local ScriptVersion = "1.4"
local ScriptName = "Kings Hub"
local LastUpdated = "12-06-2026"

local repo = "https://raw.githubusercontent.com/Kingshub-s/Volleyball/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = false
Library:SetNotifySide("Left")

local function notify(message, lifetime)
    Library:Notify({
        Title = ScriptName,
        Description = tostring(message),
        Time = lifetime or 10,
    })
end

local function pressKey(keyCode)
    local VIM = game:GetService("VirtualInputManager")
    VIM:SendKeyEvent(true, keyCode, false, game)
    task.wait(0.05)
    VIM:SendKeyEvent(false, keyCode, false, game)
end

local HitboxEnabled = false
local HitboxSize = 0
local HitboxColor = Color3.fromRGB(0, 255, 0)
local JumpESPEnabled = false
local JumpESPColor = Color3.fromRGB(255, 0, 0)
local PredictAimEnabled = false
local PredictAimColor = Color3.fromRGB(255, 255, 0)
local PredictAimLength = 0
local AutoStrongServeEnabled = false
local AutoStrongServeEveryServeEnabled = false
local ServeBoostPower = 1
local AutoSpikeEnabled = false
local AutoFarmEnabled = false
local autoClicking = false 
local AutoSetEnabled = false 
local AutoReceiveEnabled = false
local DiveCancelEnabled = false
local DirectionalHitEnabled = false
local CameraJumpEnabled = false

local autoFarmDiedConn = nil
local autoFarmRejoining = false
local lastAutoFarmRejoin = 0
local lastAutoReceivePress = 0
local SPIKE_MIN_SPEED = 55 

local function resetAutoFarmCycle()
    autoClicking = false
    lockedTeamPosition = nil
    lockedTeamCFrame = nil
    yPositionHistory = {}
end

local function attachAutoFarmDeathListener(character)
    if autoFarmDiedConn then
        autoFarmDiedConn:Disconnect()
        autoFarmDiedConn = nil
    end
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    autoFarmDiedConn = humanoid.Died:Connect(function()
        if not AutoFarmEnabled then return end
        if autoFarmRejoining then return end
        if tick() - lastAutoFarmRejoin < 5 then return end
        lastAutoFarmRejoin = tick()
        autoFarmRejoining = true
        pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end)
    end)
end

if LocalPlayer.Character then
    attachAutoFarmDeathListener(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(function(character)
    attachAutoFarmDeathListener(character)
end)

local SpeedEnabled = false
local SpeedValue = 0

local function speedControl()
    while SpeedEnabled do
        RunService.RenderStepped:Wait()
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local moveDirection = character.Humanoid.MoveDirection
            if moveDirection.Magnitude > 0 then
                character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame + moveDirection * SpeedValue / 10
            end
        end
    end
end

UserInputService.JumpRequest:Connect(function()
    if not CameraJumpEnabled then return end
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    local cam = workspace.CurrentCamera
    if not cam then return end
    local look = cam.CFrame.LookVector
    local flat = Vector3.new(look.X, 0, look.Z)
    if flat.Magnitude > 0 then
        rootPart.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + flat.Unit)
    end
end)

task.spawn(function()
    while true do
        if SpeedEnabled then
            speedControl()
        else
            task.wait(0.1)
        end
    end
end)

local yPositionHistory = {}
local lastYCheck = 0

local function isInGameStable()
    local currentTime = tick()
    if currentTime - lastYCheck < 0.5 then
        return #yPositionHistory >= 20 
    end
    lastYCheck = currentTime
    local character = LocalPlayer.Character
    if not character then 
        yPositionHistory = {}
        return false 
    end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then 
        yPositionHistory = {}
        return false 
    end
    local yPosition = rootPart.Position.Y
    table.insert(yPositionHistory, yPosition)
    if #yPositionHistory > 20 then
        table.remove(yPositionHistory, 1)
    end
    if #yPositionHistory >= 20 then
        local allDifferentFromLobby = true
        for _, y in pairs(yPositionHistory) do
            if math.abs(y - (-1.813598871231079)) < 0.1 then
                allDifferentFromLobby = false
                break
            end
        end
        return allDifferentFromLobby
    end
    return false
end

local lastAutoSetPress = 0
local function autoSet()
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local state = humanoid:GetState()
    if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then
        return 
    end
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find("CLIENT_BALL") and v:IsA("Model") then
            local ball = v:FindFirstChildWhichIsA("BasePart")
            if ball then
                local extendedHitbox = v:FindFirstChild("ExtendedHitbox")
                if extendedHitbox and extendedHitbox.Color == Color3.fromRGB(0, 255, 0) then 
                    local distance = (rootPart.Position - extendedHitbox.Position).Magnitude
                    local playerRadius = 2 
                    local hitboxRadius = extendedHitbox.Size.X / 2
                    local isTouching = distance <= (playerRadius + hitboxRadius)
                    if isTouching then
                        if tick() - lastAutoSetPress < 0.35 then break end
                        lastAutoSetPress = tick()
                        local VIM = game:GetService("VirtualInputManager")
                        VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                        task.wait(0.05)
                        VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
                        break
                    end
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        if AutoSetEnabled then
            pcall(function() autoSet() end)
        end
        task.wait(0.1)
    end
end)

local function autoReceive()
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local state = humanoid:GetState()
    if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then
        return 
    end
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find("CLIENT_BALL") and v:IsA("Model") then
            local ball = v:FindFirstChildWhichIsA("BasePart")
            if ball then
                local speed = ball.AssemblyLinearVelocity.Magnitude
                local distance = (rootPart.Position - ball.Position).Magnitude
                if speed >= SPIKE_MIN_SPEED and distance <= (HitboxSize / 2 + 5) then 
                    if tick() - lastAutoReceivePress < 0.3 then break end
                    lastAutoReceivePress = tick()
                    local VIM = game:GetService("VirtualInputManager")
                    VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                    task.wait(0.02)
                    VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
                    warn("Kings Hub: Enemy Spike Saved!")
                    break
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        if AutoReceiveEnabled and HitboxEnabled then
            pcall(function() autoReceive() end)
        end
        task.wait(0.005)
    end
end)

local function bypassDiveLock(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.AnimationPlayed:Connect(function(animationTrack)
        if DiveCancelEnabled then
            if animationTrack.Name:lower():find("dive") or tostring(animationTrack.Animation.AnimationId):find("dive") then
                task.wait(0.08) 
                animationTrack:Stop()
                humanoid:ChangeState(Enum.HumanoidStateType.Running)
                warn("Kings Hub: Instant Dive Recovery Activated!")
            end
        end
    end)
end

if LocalPlayer.Character then bypassDiveLock(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(character)
    bypassDiveLock(character)
end)

local lockedTeamPosition = nil
local lockedTeamCFrame = nil
local serveRemoteFired = false
local serveRemote

local function detectAndLockTeam()
    if not AutoFarmEnabled or lockedTeamPosition then return end
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local rootPart = character.HumanoidRootPart
        local currentPos = rootPart.Position
        local currentZ = currentPos.Z
        if math.abs(currentZ - (-11.018206596374512)) < 0.5 then
            task.wait(5)
            if character and character:FindFirstChild("HumanoidRootPart") then
                local newPos = character.HumanoidRootPart.Position
                if math.abs(newPos.Z - (-11.018206596374512)) < 0.5 then
                    lockedTeamPosition = newPos
                    lockedTeamCFrame = character.HumanoidRootPart.CFrame
                end
            end
        elseif math.abs(currentZ - 12.981904029846191) < 0.5 then
            task.wait(5)
            if character and character:FindFirstChild("HumanoidRootPart") then
                local newPos = character.HumanoidRootPart.Position
                if math.abs(newPos.Z - 12.981904029846191) < 0.5 then
                    lockedTeamPosition = newPos
                    lockedTeamCFrame = character.HumanoidRootPart.CFrame
                end
            end
        end
    end
end

local function resetToTeamPosition()
    if not lockedTeamPosition or not lockedTeamCFrame then return end
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = lockedTeamCFrame
    end
end

task.spawn(function()
    while true do
        if AutoFarmEnabled and not lockedTeamPosition then
            detectAndLockTeam()
        end
        task.wait(0.5)
    end
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local success, knitServices = pcall(function()
    return ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services")
end)

if success and knitServices then
    local gameService = knitServices:WaitForChild("GameService", 10)
    if gameService then
        local rf = gameService:WaitForChild("RF", 5)
        if rf then serveRemote = rf:WaitForChild("Serve", 5) end
    end
else
    local success2, remote = pcall(function()
        return ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("Serve")
    end)
    if success2 and remote then serveRemote = remote end
end

local originalNamecall
originalNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = { ... }
    if method == "InvokeServer" then
        if DirectionalHitEnabled and tostring(self) == "Interact" and args[1] and type(args[1]) == "table" then
            local data = args[1]
            local cam = workspace.CurrentCamera
            if cam and data.Move and data.LookVector then
                local look = cam.CFrame.LookVector
                local y = data.LookVector.Y
                local lv = Vector3.new(look.X, y, look.Z)
                if lv.Magnitude > 0 then data.LookVector = lv.Unit end
            end
        end
        if AutoStrongServeEveryServeEnabled and tostring(self) == "Serve" and args[2] ~= nil then
            args[2] = ServeBoostPower
        end
        if serveRemote and AutoFarmEnabled and lockedTeamPosition and self == serveRemote then
            serveRemoteFired = true
            task.spawn(function()
                task.wait(2)
                if serveRemoteFired then
                    resetToTeamPosition()
                    serveRemoteFired = false
                end
            end)
        end
    end
    return originalNamecall(self, table.unpack(args))
end))

local AntiModEnabled = false
local ModeratorList = {
    "ask_snapaple", "llotiiee", "Vezire123", "astratoka", "SneakyTiki1",
    "StarlightStarbrighht", "7Stxqr3", "xToruz", "koalacoco345", "Chrisdaman1122",
    "LebronjamesEl7a2e2ee", "PineCrumb", "HeyCrafted", "Dondred02", "Place_Reboot",
    "noahrepublic", "KumagawasFiction", "T0tallyN0tATr0ll", "Protori", "BarDowned", "GoodSirVolleyball"
}

local function isModerator(playerName)
    for _, modName in pairs(ModeratorList) do
        if playerName:lower() == modName:lower() then return true end
    end
    return false
end

local function checkForModerators()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isModerator(player.Name) then
            LocalPlayer:Kick("Kings Hub: Moderator detected. Safety kick activated.")
            return true
        end
    end
    return false
end

task.spawn(function()
    while true do
        if AntiModEnabled then checkForModerators() end
        task.wait(2)
    end
end)

Players.PlayerAdded:Connect(function(player)
    if AntiModEnabled and isModerator(player.Name) then
        LocalPlayer:Kick("Kings Hub: Moderator " .. player.Name .. " joined. Safety kick activated.")
    end
end)

local JumpESPObjects = {}
local PredictAimObjects = {}

local function switchLobby()
    pcall(function() LocalPlayer:Kick("Kings Hub: Target position unavailable. Rejoining...") end)
    task.wait(0.5)
    pcall(function() game:GetService("NetworkClient"):Disconnect() end)
end

local function simpleAutoFarm()
    if not AutoFarmEnabled then return end
    local innerCylinder = workspace:FindFirstChild("Volleyball Lobby")
    if innerCylinder then
        local interactables = innerCylinder:FindFirstChild("Interactables")
        if interactables then
            local portal = interactables:FindFirstChild("Portal")
            if portal then
                local innerCyl = portal:FindFirstChild("InnerCylinder")
                if innerCyl then
                    LocalPlayer.Character:SetPrimaryPartCFrame(innerCyl.CFrame)
                    local maxWait = 10
                    local waitTime = 0
                    while waitTime < maxWait do
                        local teamSelectionUI = LocalPlayer.PlayerGui:FindFirstChild("Interface")
                        if teamSelectionUI then
                            local teamSelection = teamSelectionUI:FindFirstChild("TeamSelection")
                            if teamSelection and teamSelection.Visible then
                                local positionsToCheck = {
                                    {team = 1, position = 1}, {team = 1, position = 2}, {team = 1, position = 3},
                                    {team = 2, position = 1}, {team = 2, position = 2}, {team = 2, position = 3}
                                }
                                local joinedAnyPosition = false
                                for _, posData in pairs(positionsToCheck) do
                                    local team = teamSelection:FindFirstChild(tostring(posData.team))
                                    if team then
                                        local teamHolder = team:FindFirstChild("TeamHolder")
                                        if teamHolder then
                                            local positionFrame = teamHolder:FindFirstChild(tostring(posData.position))
                                            if positionFrame then
                                                local headshot = positionFrame:FindFirstChild("Headshot")
                                                if not headshot or not headshot.Image or headshot.Image == "" or headshot.Image == "rbxasset://textures/ui/GuiImagePlaceholder.png" then
                                                    local absolutePos = positionFrame.AbsolutePosition
                                                    local absoluteSize = positionFrame.AbsoluteSize
                                                    local centerX = absolutePos.X + absoluteSize.X / 2
                                                    local centerY = absolutePos.Y + absoluteSize.Y / 2
                                                    local VIM = game:GetService("VirtualInputManager")
                                                    VIM:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
                                                    task.wait(0.1)
                                                    VIM:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
                                                    joinedAnyPosition = true
                                                    task.wait(3)
                                                    local VIM2 = game:GetService("VirtualInputManager")
                                                    VIM2:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                                                    task.wait(0.05)
                                                    VIM2:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
                                                    autoClicking = true
                                                    task.spawn(function()
                                                        while autoClicking and AutoFarmEnabled do
                                                            local VIMClick = game:GetService("VirtualInputManager")
                                                            VIMClick:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                                                            task.wait(0.05)
                                                            VIMClick:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                                                            task.wait(0.05)
                                                            local ballPart = nil
                                                            for _, v in pairs(workspace:GetChildren()) do
                                                                if v.Name:find("CLIENT_BALL") and v:IsA("Model") then
                                                                    ballPart = v:FindFirstChildWhichIsA("BasePart")
                                                                    break
                                                                end
                                                            end
                                                            if ballPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                                                local playerRoot = LocalPlayer.Character.HumanoidRootPart
                                                                local ballPos = ballPart.Position
                                                                local currentPos = playerRoot.Position
                                                                local newCFrame = CFrame.new(ballPos.X, currentPos.Y, currentPos.Z) * playerRoot.CFrame - playerRoot.Position
                                                                LocalPlayer.Character:SetPrimaryPartCFrame(newCFrame)
                                                            end
                                                            task.wait(0.05)
                                                        end
                                                    end)
                                                    return
                                                end
                                            end
                                        end
                                    end
                                end
                                if not joinedAnyPosition then
                                    switchLobby()
                                    return
                                end
                            end
                        end
                        task.wait(0.5)
                        waitTime = waitTime + 0.5
                    end
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        if AutoFarmEnabled then
            local wasInGame = isInGameStable()
            task.wait(1)
            local isInGameNow = isInGameStable()
            if wasInGame and not isInGameNow then
                autoClicking = false
                lockedTeamPosition = nil
                lockedTeamCFrame = nil
                task.wait(2)
            end
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    local lastRoundOverHandle = 0
    while true do
        if AutoFarmEnabled then
            local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
            if playerGui then
                local interface = playerGui:FindFirstChild("Interface")
                if interface then
                    local roundOverStats = interface:FindFirstChild("RoundOverStats")
                    if roundOverStats and roundOverStats.Visible then
                        if tick() - lastRoundOverHandle > 1 then
                            lastRoundOverHandle = tick()
                            pcall(function() roundOverStats.Visible = false end)
                            resetAutoFarmCycle()
                            task.spawn(function()
                                task.wait(0.5)
                                if AutoFarmEnabled and not autoClicking then simpleAutoFarm() end
                            end)
                        end
                    end
                end
            end
        end
        task.wait(1)
    end
end)

task.spawn(function()
    while true do
        if AutoFarmEnabled and not autoClicking then
            local character = LocalPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if not character or not humanoid or humanoid.Health <= 0 then
                autoClicking = false
                LocalPlayer.CharacterAdded:Wait()
                task.wait(1)
            else
                simpleAutoFarm()
            end
        end
        task.wait(3)
    end
end)

local function getPlayerTeam(player)
    if player.Team then return player.Team end
    return nil
end

local function isEnemy(player)
    if player == LocalPlayer then return false end
    local localTeam = getPlayerTeam(LocalPlayer)
    local playerTeam = getPlayerTeam(player)
    if localTeam and playerTeam then return localTeam ~= playerTeam end
    return true
end

local function isJumping(player)
    local character = player.Character
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoid and rootPart then
        local state = humanoid:GetState()
        if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then return true end
        if rootPart.AssemblyLinearVelocity.Y > 5 then return true end
    end
    return false
end

local function createJumpESP(player)
    local character = player.Character
    if not character then return end
    if JumpESPObjects[player] then JumpESPObjects[player]:Destroy() JumpESPObjects[player] = nil end
    local highlight = Instance.new("Highlight")
    highlight.Name = "JumpESP"
    highlight.Adornee = character
    highlight.FillColor = JumpESPColor
    highlight.OutlineColor = JumpESPColor
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    JumpESPObjects[player] = highlight
end

local function removeJumpESP(player)
    if JumpESPObjects[player] then JumpESPObjects[player]:Destroy() JumpESPObjects[player] = nil end
end

local function createPredictLine(player)
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")
    if not rootPart or not head then return end
    if PredictAimObjects[player] then
        if PredictAimObjects[player].Line then PredictAimObjects[player].Line:Destroy() end
        if PredictAimObjects[player].Point then PredictAimObjects[player].Point:Destroy() end
        PredictAimObjects[player] = nil
    end
    local lookVector = rootPart.CFrame.LookVector
    local spikeDirection = lookVector.Unit
    local line = Instance.new("Part")
    line.Name = "PredictLine"
    line.Anchored = true
    line.CanCollide = false
    line.Material = Enum.Material.Neon
    line.Color = PredictAimColor
    line.Size = Vector3.new(0.2, 0.2, PredictAimLength)
    line.Transparency = 0.3
    local startPos = head.Position + Vector3.new(0, 1, 0)
    local endPos = startPos + (spikeDirection * PredictAimLength)
    local midPoint = (startPos + endPos) / 2
    line.CFrame = CFrame.lookAt(midPoint, endPos)
    line.Parent = workspace
    PredictAimObjects[player] = { Line = line }
end

local function updatePredictLine(player)
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")
    if not rootPart or not head then return end
    if PredictAimObjects[player] and PredictAimObjects[player].Line then
        local lookVector = rootPart.CFrame.LookVector
        local spikeDirection = lookVector.Unit
        local startPos = head.Position + Vector3.new(0, 1, 0)
        local endPos = startPos + (spikeDirection * PredictAimLength)
        local midPoint = (startPos + endPos) / 2
        PredictAimObjects[player].Line.Size = Vector3.new(0.2, 0.2, PredictAimLength)
        PredictAimObjects[player].Line.CFrame = CFrame.lookAt(midPoint, endPos)
        PredictAimObjects[player].Line.Color = PredictAimColor
    end
end

RunService.RenderStepped:Connect(function()
    if PredictAimEnabled then
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if isEnemy(player) then
                    if not PredictAimObjects[player] then
                        createPredictLine(player)
                    else
                        updatePredictLine(player)
                    end
                else
                    if PredictAimObjects[player] then
                        if PredictAimObjects[player].Line then PredictAimObjects[player].Line:Destroy() end
                        PredictAimObjects[player] = nil
                    end
                end
            end
        end)
    end
end)

local function clearAllJumpESP()
    for player, obj in pairs(JumpESPObjects) do if obj then obj:Destroy() end end
    JumpESPObjects = {}
end

local function clearAllPredictAim()
    for player, obj in pairs(PredictAimObjects) do
        if obj then
            if obj.Line then obj.Line:Destroy() end
            if obj.Point then obj.Point:Destroy() end
        end
    end
    PredictAimObjects = {}
end

local function modifyBallHitbox()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find("CLIENT_BALL") and v:IsA("Model") then
            local mainPart = v:FindFirstChildWhichIsA("BasePart")
            if mainPart then
                local existingHitbox = v:FindFirstChild("ExtendedHitbox")
                if existingHitbox then
                    existingHitbox.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                    existingHitbox.Color = HitboxColor
                    existingHitbox.CFrame = mainPart.CFrame
                else
                    local hitbox = Instance.new("Part")
                    hitbox.Name = "ExtendedHitbox"
                    hitbox.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                    hitbox.Transparency = 0.75
                    hitbox.Color = HitboxColor
                    hitbox.Material = Enum.Material.Neon
                    hitbox.CanCollide = false
                    hitbox.CanTouch = true
                    hitbox.Massless = true
                    hitbox.Anchored = false
                    hitbox.Shape = Enum.PartType.Ball
                    hitbox.CFrame = mainPart.CFrame
                    hitbox.CastShadow = false
                    hitbox.Parent = v
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = mainPart
                    weld.Part1 = hitbox
                    weld.Parent = hitbox
                end
            end
        end
    end
end

local function removeHitboxes()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find("CLIENT_BALL") and v:IsA("Model") then
            local hitbox = v:FindFirstChild("ExtendedHitbox")
            if hitbox then hitbox:Destroy() end
        end
    end
end

local function autoStrongServe()
    local playerGui = LocalPlayer.PlayerGui
    if not playerGui then return end
    local interface = playerGui:FindFirstChild("Interface")
    if not interface then return end
    local gameUI = interface:FindFirstChild("Game")
    if not gameUI then return end
    local power = gameUI:FindFirstChild("Power")
    if not power or not power.Visible then return end
    local arrow = power:FindFirstChild("Arrow")
    local extraPower = power:FindFirstChild("ExtraPower")
    if not arrow or not extraPower then return end
    local arrowPos = arrow.AbsolutePosition
    local arrowSize = arrow.AbsoluteSize
    local extraPowerPos = extraPower.AbsolutePosition
    local extraPowerSize = extraPower.AbsoluteSize
    local arrowCenterX = arrowPos.X + (arrowSize.X / 2)
    local extraPowerLeftX = extraPowerPos.X
    local extraPowerRightX = extraPowerPos.X + extraPowerSize.X
    local xAligned = arrowCenterX >= extraPowerLeftX and arrowCenterX <= extraPowerRightX
    local overlapsY = (arrowPos.Y < extraPowerPos.Y + extraPowerSize.Y) and (arrowPos.Y + arrowSize.Y > extraPowerPos.Y)
    if xAligned and overlapsY then
        local VIM = game:GetService("VirtualInputManager")
        VIM:SendMouseButtonEvent(arrowCenterX, arrowPos.Y + (arrowSize.Y / 2), 0, true, game, 1)
        task.wait(0.05)
        VIM:SendMouseButtonEvent(arrowCenterX, arrowPos.Y + (arrowSize.Y / 2), 0, false, game, 1)
    end
end

local function autoSpike()
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local state = humanoid:GetState()
    if state ~= Enum.HumanoidStateType.Jumping and state ~= Enum.HumanoidStateType.Freefall then return end
    local camera = workspace.CurrentCamera
    if not camera then return end
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find("CLIENT_BALL") and v:IsA("Model") then
            local ball = v:FindFirstChildWhichIsA("BasePart")
            if ball then
                local velocity = ball.AssemblyLinearVelocity
                local extendedHitbox = v:FindFirstChild("ExtendedHitbox")
                if extendedHitbox and extendedHitbox.Color == Color3.fromRGB(0, 255, 0) then 
                    local distance = (rootPart.Position - extendedHitbox.Position).Magnitude
                    local isTouching = distance <= (2 + (extendedHitbox.Size.X / 2))
                    if isTouching and velocity.Y <= 0 then
                        local screenPos, onScreen = camera:WorldToScreenPoint(ball.Position)
                        if onScreen then
                            local VIM = game:GetService("VirtualInputManager")
                            VIM:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, true, game, 1)
                            task.wait(0.02)
                            VIM:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, false, game, 1)
                            break
                        end
                    end
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if HitboxEnabled then pcall(modifyBallHitbox) end
    if JumpESPEnabled then
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if isEnemy(player) then
                    if isJumping(player) then
                        createJumpESP(player)
                    else
                        removeJumpESP(player)
                    end
                end
            end
        end)
    end
    if PredictAimEnabled then
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if isEnemy(player) then
                    updatePredictLine(player)
                end
            end
        end)
    end
    if AutoStrongServeEnabled then pcall(autoStrongServe) end
    if AutoSpikeEnabled then pcall(autoSpike) end
end)

local Window = Library:CreateWindow({
    Title = ScriptName,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = false,
    UnlockMouseWhileOpen = true,
    NotifySide = "Left",
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab("Main", "activity"),
    Settings = Window:AddTab("Settings", "settings"),
}

local MainLeft = Tabs.Main:AddLeftGroupbox("Features", "boxes")
local MainRight = Tabs.Main:AddRightGroupbox("Visual Features", "eye")
local SettingsLeft = Tabs.Settings:AddLeftGroupbox("Information", "info")
local SettingsRight = Tabs.Settings:AddRightGroupbox("UI Settings", "wrench")

MainLeft:AddToggle("HitboxToggle", {
    Text = "Enable Safe Ball Hitbox",
    Default = HitboxEnabled,
    Callback = function(Value)
        HitboxEnabled = Value
        if not HitboxEnabled then removeHitboxes() end
    end
})

MainLeft:AddSlider("HitboxSize", {
    Text = "Hitbox Size", Default = HitboxSize, Min = 0, Max = 100, Rounding = 0, Suffix = " studs",
    Callback = function(Value) HitboxSize = Value end
})

MainLeft:AddLabel("Hitbox Color"):AddColorPicker("HitboxColor", {
    Default = HitboxColor, Title = "Hitbox Color", Callback = function(Value) HitboxColor = Value end
})

MainLeft:AddDivider()
MainLeft:AddToggle("AutoStrongServeToggle", {
    Text = "Auto Strong Serve (UI Based)", Default = AutoStrongServeEnabled,
    Callback = function(Value) AutoStrongServeEnabled = Value end
})

MainLeft:AddToggle("AutoStrongServeEveryServeToggle", {
    Text = "Auto Strong Serve", Default = AutoStrongServeEveryServeEnabled,
    Callback = function(Value) AutoStrongServeEveryServeEnabled = Value end
})

MainLeft:AddSlider("ServeBoostPower", {
    Text = "Serve Boost Power", Default = ServeBoostPower, Min = 0, Max = 1, Rounding = 2,
    Callback = function(Value) ServeBoostPower = Value end
})

MainLeft:AddToggle("AutoSpikeToggle", {
    Text = "Auto Spike", Default = AutoSpikeEnabled, Callback = function(Value) AutoSpikeEnabled = Value end
})

MainLeft:AddToggle("DirectionalHitToggle", {
    Text = "Directional Hit", Default = DirectionalHitEnabled, Callback = function(Value) DirectionalHitEnabled = Value end
})

MainLeft:AddToggle("CameraJumpToggle", {
    Text = "Camera Jump", Default = CameraJumpEnabled, Callback = function(Value) CameraJumpEnabled = Value end
})

MainLeft:AddToggle("AutoSetToggle", {
    Text = "Auto Set (Q)", Default = AutoSetEnabled, Callback = function(Value) AutoSetEnabled = Value end
})

MainLeft:AddToggle("AutoReceiveToggle", {
    Text = "Auto Receive Spike (Q)",
    Default = AutoReceiveEnabled,
    Tooltip = "Automatically receives enemy spikes based on hitbox dynamic detection",
    Callback = function(Value)
        AutoReceiveEnabled = Value
        notify(Value and "Auto Receive Enabled" or "Auto Receive Disabled", 10)
    end
})

MainLeft:AddToggle("DiveCancelToggle", {
    Text = "Dive Cancel (VBL Premium)",
    Default = DiveCancelEnabled,
    Tooltip = "Instantly cancels the dive lag in Volleyball Legends after hitting the ball",
    Callback = function(Value)
        DiveCancelEnabled = Value
        notify(Value and "Dive Cancel Enabled" or "Dive Cancel Disabled", 10)
    end
})

MainLeft:AddToggle("AutoFarmToggle", {
    Text = "Auto Farm Levels", Default = AutoFarmEnabled,
    Callback = function(Value)
        AutoFarmEnabled = Value
        if AutoFarmEnabled then
            HitboxSize = 100
            pcall(function() Options.HitboxSize:SetValue(100) end)
            resetAutoFarmCycle()
        else
            switchLobby()
        end
    end
})

MainLeft:AddDivider()
MainLeft:AddToggle("AntiModToggle", {
    Text = "Anti-Moderator Protection", Default = AntiModEnabled,
    Callback = function(Value)
        AntiModEnabled = Value
        if AntiModEnabled then checkForModerators() end
    end
})

MainLeft:AddDivider()
MainLeft:AddToggle("SpeedToggle", {
    Text = "CFrame Speed", Default = SpeedEnabled, Callback = function(Value) SpeedEnabled = Value end
})

MainLeft:AddSlider("SpeedSlider", {
    Text = "Speed Value", Default = SpeedValue, Min = 0, Max = 10, Rounding = 1, Suffix = " speed",
    Callback = function(Value) SpeedValue = Value end
})

MainRight:AddToggle("JumpESPToggle", {
    Text = "Enable Jump ESP", Default = JumpESPEnabled,
    Callback = function(Value)
        JumpESPEnabled = Value
        if not JumpESPEnabled then clearAllJumpESP() end
    end
})

MainRight:AddLabel("Jump ESP Color"):AddColorPicker("JumpESPColor", {
    Default = JumpESPColor, Callback = function(Value) JumpESPColor = Value end
})

MainRight:AddDivider()
MainRight:AddToggle("PredictAimToggle", {
    Text = "Enable Predict Aim", Default = PredictAimEnabled,
    Callback = function(Value)
        PredictAimEnabled = Value
        if not PredictAimEnabled then clearAllPredictAim() end
    end
})

MainRight:AddSlider("PredictAimLength", {
    Text = "Prediction Length", Default = PredictAimLength, Min = 0, Max = 50, Rounding = 0, Suffix = " studs",
    Callback = function(Value) PredictAimLength = Value end
})

MainRight:AddLabel("Predict Aim Color"):AddColorPicker("PredictAimColor", {
    Default = PredictAimColor, Callback = function(Value) PredictAimColor = Value end
})

SettingsLeft:AddLabel(ScriptName .. " v" .. ScriptVersion)
SettingsLeft:AddLabel("Last Updated: " .. LastUpdated)
SettingsLeft:AddDivider()
SettingsLeft:AddLabel("Developed by Kings")
SettingsLeft:AddLabel("Thank you for using Kings Hub!")
SettingsLeft:AddDivider()
SettingsLeft:AddLabel("Credits")
SettingsLeft:AddLabel("Main Developer: Kings")
SettingsLeft:AddLabel("UI Library: Obsidian")

SettingsRight:AddLabel("Menu bind")
    :AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })

SettingsRight:AddButton({
    Text = "Unload Script",
    Func = function()
        getgenv().KingsHubLoaded = false
        AutoFarmEnabled = false
        autoClicking = false
    end
})

Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("KingsHub")
ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:SetLibrary(Library)
SaveManager:SetFolder("KingsHub")
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

Library:OnUnload(function()
    getgenv().KingsHubLoaded = false
end)

notify("Kings Hub Updated Successfully!", 10)
