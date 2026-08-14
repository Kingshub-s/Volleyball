return(function(Doaz4, ...)
local TciXC3 = {"JKa7Q3PxQsEZzp";"4j49BjonuMVc";"ZeaWdI7fQL3sCA";"HX0gN3ST";"rzAQSvaB";"bzEFQCIc6DvWst3M";"nZqFePwcQXHQZ";"FfHTOgGflTp1zT";"P08a";"ItWwu41iE"}
local xIgaW8C2 = function(...)
local oldIndex
oldIndex = hookmetamethod(game, loadstring(base64decode("X19pbmRleA=="))(), function(self, key)
    if self == workspace and key == loadstring(base64decode("R2V0U2VydmVyVGltZU5vdw=="))() then
        return DateTime.now().UnixTimestamp 
    end
    return oldIndex(self, key)
end)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService(loadstring(base64decode("UGxheWVycw=="))())
local RunService = game:GetService(loadstring(base64decode("UnVuU2VydmljZQ=="))())
local TweenService = game:GetService(loadstring(base64decode("VHdlZW5TZXJ2aWNl"))())
local TeleportService = game:GetService(loadstring(base64decode("VGVsZXBvcnRTZXJ2aWNl"))())
local UserInputService = game:GetService(loadstring(base64decode("VXNlcklucHV0U2VydmljZQ=="))())
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players:GetPropertyChangedSignal(loadstring(base64decode("TG9jYWxQbGF5ZXI="))()):Wait()
    LocalPlayer = Players.LocalPlayer
end

local ScriptVersion = loadstring(base64decode("NA=="))()
local ScriptName = loadstring(base64decode("S2luZ3MgSHVi"))()
local LastUpdated = loadstring(base64decode("MDgtMTQtMjAyNg=="))()

local repo = loadstring(base64decode("aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2RlaXZpZGNvbXNvbm8vT2JzaWRpYW4vbWFpbi8="))()
local Library = loadstring(game:HttpGet(repo .. loadstring(base64decode("TGlicmFyeS5sdWE="))()))()
local ThemeManager = loadstring(game:HttpGet(repo .. loadstring(base64decode("YWRkb25zL1RoZW1lTWFuYWdlci5sdWE="))()))()
local SaveManager = loadstring(game:HttpGet(repo .. loadstring(base64decode("YWRkb25zL1NhdmVNYW5hZ2VyLmx1YQ=="))()))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = false
Library:SetNotifySide(loadstring(base64decode("TGVmdA=="))())

local function notify(message, lifetime)
    Library:Notify({
        Title = ScriptName,
        Description = tostring(message),
        Time = lifetime or 10,
    })
end

local function pressKey(keyCode)
    local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
    VIM:SendKeyEvent(true, keyCode, false, game)
    wait(0.05)
    VIM:SendKeyEvent(false, keyCode, false, game)
end

local HitboxEnabled = false
local HitboxSize = 10
local HitboxColor = Color3.fromRGB(0, 255, 0)
local HitboxTransparency = 0.8

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
local AutoJumpSetEnabled = false
local AutoReceiveEnabled = false
local StreamerModeEnabled = false
local DirectionalHitEnabled = false
local CameraJumpEnabled = false
local AimbotCornerEnabled = false
local AimbotCornerMode = loadstring(base64decode("QXV0bw=="))()
local MaxPowerSpikeEnabled = false
local InfSpinsEnabled = false
local InfYensEnabled = false
local InfAbilitiesEnabled = false
local InfGemsEnabled = false
local SkipSpinEnabled = false
local lastSkipSpin = 0
local rollActiveUntil = 0
local JumpBoostEnabled = false
local JumpBoostMult = 1.35
local SpikeBoostEnabled = false
local SpikeBoostCharge = 1
local SilentSpikeEnabled = false
local AnimDesyncEnabled = false
local PerfectSpikeAssistEnabled = true
local OfficialPathEnabled = true
local AutoAbilityEnabled = false
local lastSilentSpike = 0
local lastAutoAbility = 0
local ballJumpRemote = nil
local ballInteractRemote = nil
local abilityUseRemote = nil
local registerMovedRemote = nil
local animDesyncConn = nil
local infSpinsBusy = false
local infYensBusy = false
local infAbilitiesBusy = false
local infGemsBusy = false
local lastAutoSpikeClick = 0
local lastAutoJumpSetPress = 0
local lastAutoReceivePress = 0
local jumpSetPhase = 0
local jumpSetPhaseTime = 0
local streamerOriginalDisplay = {}

-- Auto Spin System
local AutoSpinEnabled = false
local AutoSpinType = loadstring(base64decode("U3R5bGU="))()
local AutoSpinSlot = 1
local AutoSpinTargetName = loadstring(base64decode(""))()
local AutoSpinStopOnTarget = true
local AutoSpinStopOnRarity = loadstring(base64decode(""))()
local AutoSpinUseLucky = true
local AutoSpinSpeed = 0.35
local AutoSpinBusy = false
local lastAutoSpin = 0
local styleRollRemote, abilityRollRemote = nil, nil
local styleSelectSlot, abilitySelectSlot = nil, nil

local autoFarmDiedConn = nil
local autoFarmRejoining = false
local lastAutoFarmRejoin = 0

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
    local humanoid = character and character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
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
        if character and character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) then
            local moveDirection = character.Humanoid.MoveDirection
            if moveDirection.Magnitude > 0 then
                character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame + moveDirection * SpeedValue / 10
            end
        end
    end
end

-- ═══════════════════════════════════════
-- IMPROVED AIMBOT CORNER (COURT-MAPPED)
-- ═══════════════════════════════════════
local courtBounds = nil

local function detectCourtBounds()
    if courtBounds then return courtBounds end
    local minX, maxX = math.huge, -math.huge
    local minZ, maxZ = math.huge, -math.huge
    local netZ = nil

    pcall(function()
        local map = workspace:FindFirstChild(loadstring(base64decode("TWFw"))())
        if not map then
            local lobby = workspace:FindFirstChild(loadstring(base64decode("Vm9sbGV5YmFsbCBMb2JieQ=="))())
            map = lobby and lobby:FindFirstChild(loadstring(base64decode("TWFw"))())
        end
        if not map then return end
        for _, part in pairs(map:GetDescendants()) do
            if part:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
                local name = string.lower(part.Name or loadstring(base64decode(""))())
                if name:find(loadstring(base64decode("Y291cnQ="))()) or name:find(loadstring(base64decode("Zmxvb3I="))()) or name:find(loadstring(base64decode("b3V0ZXI="))()) then
                    local pos = part.Position
                    local size = part.Size
                    minX = math.min(minX, pos.X - size.X / 2)
                    maxX = math.max(maxX, pos.X + size.X / 2)
                    minZ = math.min(minZ, pos.Z - size.Z / 2)
                    maxZ = math.max(maxZ, pos.Z + size.Z / 2)
                end
                if name == loadstring(base64decode("bmV0"))() or name:find(loadstring(base64decode("dm9sbGV5YmFsbG5ldA=="))()) or name:find(loadstring(base64decode("bmV0"))()) then
                    if part.Size.X < 2 and part.Size.Z > 10 then
                        netZ = part.Position.Z
                    end
                end
            end
        end
    end)

    if maxX - minX < 5 or maxZ - minZ < 5 then
        minX, maxX = -25, 25
        minZ, maxZ = -40, 40
        for _, plr in pairs(Players:GetPlayers()) do
            local c = plr.Character
            local hrp = c and c:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
            if hrp then
                local p = hrp.Position
                minX = math.min(minX, p.X - 25)
                maxX = math.max(maxX, p.X + 25)
                minZ = math.min(minZ, p.Z - 35)
                maxZ = math.max(maxZ, p.Z + 35)
            end
        end
    end

    courtBounds = {
        minX = minX, maxX = maxX,
        minZ = minZ, maxZ = maxZ,
        netZ = netZ,
        centerX = (minX + maxX) / 2,
        centerZ = netZ or (minZ + maxZ) / 2,
        halfWidth = (maxX - minX) / 2,
        courtLength = math.abs(maxZ - minZ),
    }
    return courtBounds
end

task.spawn(function()
    while true do
        task.wait(30)
        courtBounds = nil
    end
end)

local function getRankedCorners(playerPos)
    local court = detectCourtBounds()
    if not court then
        return Vector3.new(playerPos.X - 18, playerPos.Y, playerPos.Z + 36),
               Vector3.new(playerPos.X + 18, playerPos.Y, playerPos.Z + 36),
               playerPos.X
    end

    local myZ = playerPos.Z
    local netZ = court.netZ or court.centerZ
    local facingPositiveZ = myZ < netZ
    local oppZ
    if facingPositiveZ then
        oppZ = court.maxZ - 3
    else
        oppZ = court.minZ + 3
    end

    local courtLeft = court.minX + 2
    local courtRight = court.maxX - 2

    local leftCorner = Vector3.new(courtLeft, playerPos.Y, oppZ)
    local rightCorner = Vector3.new(courtRight, playerPos.Y, oppZ)

    local toOppZ = oppZ - myZ
    if toOppZ < 0 then
        leftCorner = Vector3.new(courtRight, playerPos.Y, oppZ)
        rightCorner = Vector3.new(courtLeft, playerPos.Y, oppZ)
    end

    return leftCorner, rightCorner, court.centerX
end

local function getAimbotTargetCorner(playerPos)
    local leftCorner, rightCorner, centerX = getRankedCorners(playerPos)

    if AimbotCornerMode == loadstring(base64decode("TGVmdA=="))() then
        return leftCorner
    elseif AimbotCornerMode == loadstring(base64decode("UmlnaHQ="))() then
        return rightCorner
    end

    local nearestEnemy, nearestDist = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) then
            local dist = (plr.Character.HumanoidRootPart.Position - playerPos).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearestEnemy = plr
            end
        end
    end

    if nearestEnemy and nearestEnemy.Character and nearestEnemy.Character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) then
        local enemyPos = nearestEnemy.Character.HumanoidRootPart.Position
        local distLeft = (leftCorner - enemyPos).Magnitude
        local distRight = (rightCorner - enemyPos).Magnitude
        local ballBonus = 0
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) and v:IsA(loadstring(base64decode("TW9kZWw="))()) then
                local ball = v:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))())
                if ball then
                    if (ball.Position - leftCorner).Magnitude < (ball.Position - rightCorner).Magnitude then
                        ballBonus = -2
                    else
                        ballBonus = 2
                    end
                end
                break
            end
        end
        distLeft = distLeft + ballBonus
        distRight = distRight - ballBonus
        return (distLeft > distRight) and leftCorner or rightCorner
    end

    return (playerPos.X < centerX) and rightCorner or leftCorner
end

UserInputService.JumpRequest:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    if not rootPart then return end

    if AimbotCornerEnabled then
        local playerPos = rootPart.Position
        local targetCorner = getAimbotTargetCorner(playerPos)
        local flatDir = Vector3.new(targetCorner.X - playerPos.X, 0, targetCorner.Z - playerPos.Z)
        if flatDir.Magnitude > 0.5 then
            local currentLook = rootPart.CFrame.LookVector
            local currentFlat = Vector3.new(currentLook.X, 0, currentLook.Z)
            if currentFlat.Magnitude > 0.1 then
                currentFlat = currentFlat.Unit
            else
                currentFlat = flatDir.Unit
            end
            local blended = (currentFlat * 0.15 + flatDir.Unit * 0.85).Unit
            rootPart.CFrame = CFrame.lookAt(playerPos, playerPos + blended)
        end
        return
    end

    if not CameraJumpEnabled then return end
    local cam = workspace.CurrentCamera
    if not cam then return end
    local look = cam.CFrame.LookVector
    local flat = Vector3.new(look.X, 0, look.Z)
    if flat.Magnitude > 0 then
        rootPart.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + flat.Unit)
    end
end)

spawn(function()
    while true do
        if SpeedEnabled then
            speedControl()
        else
            wait(0.1)
        end
    end
end)

local maxPowerPhase = 0
RunService.Heartbeat:Connect(function()
    if not MaxPowerSpikeEnabled then return end
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    if not humanoid or not rootPart then return end
    local state = humanoid:GetState()
    if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then return end
    if humanoid.MoveDirection.Magnitude > 0.05 then return end
    maxPowerPhase = maxPowerPhase + 0.22
    local dir = Vector3.new(math.sin(maxPowerPhase), 0, math.cos(maxPowerPhase))
    humanoid:Move(dir, true)
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
    if not character then yPositionHistory = {} return false end
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    if not rootPart then yPositionHistory = {} return false end
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
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    if not rootPart then return end
    local humanoid = character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if not humanoid then return end
    local state = humanoid:GetState()
    if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then return end
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) and v:IsA(loadstring(base64decode("TW9kZWw="))()) then
            local ball = v:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))())
            if ball then
                local extendedHitbox = v:FindFirstChild(loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))())
                if extendedHitbox and extendedHitbox.Color == Color3.fromRGB(0, 255, 0) then
                    local distance = (rootPart.Position - extendedHitbox.Position).Magnitude
                    local playerRadius = 2
                    local hitboxRadius = extendedHitbox.Size.X / 2
                    local isTouching = distance <= (playerRadius + hitboxRadius)
                    if isTouching then
                        if tick() - lastAutoSetPress < 0.35 then break end
                        lastAutoSetPress = tick()
                        local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
                        VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                        wait(0.05)
                        VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
                        break
                    end
                end
            end
        end
    end
end

spawn(function()
    while true do
        if AutoSetEnabled then pcall(function() autoSet() end) end
        wait(0.1)
    end
end)

local lockedTeamPosition = nil
local lockedTeamCFrame = nil
local serveRemoteFired = false
local serveRemote

local function detectAndLockTeam()
    if not AutoFarmEnabled or lockedTeamPosition then return end
    local character = LocalPlayer.Character
    if character and character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) then
        local rootPart = character.HumanoidRootPart
        local currentPos = rootPart.Position
        local currentCFrame = rootPart.CFrame
        local currentZ = currentPos.Z
        if math.abs(currentZ - (-11.018206596374512)) < 0.5 then
            wait(5)
            if character and character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) then
                local newPos = character.HumanoidRootPart.Position
                local newZ = newPos.Z
                if math.abs(newZ - (-11.018206596374512)) < 0.5 then
                    lockedTeamPosition = newPos
                    lockedTeamCFrame = character.HumanoidRootPart.CFrame
                end
            end
        elseif math.abs(currentZ - 12.981904029846191) < 0.5 then
            wait(5)
            if character and character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) then
                local newPos = character.HumanoidRootPart.Position
                local newZ = newPos.Z
                if math.abs(newZ - 12.981904029846191) < 0.5 then
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
    if character and character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) then
        character.HumanoidRootPart.CFrame = lockedTeamCFrame
    end
end

spawn(function()
    while true do
        if AutoFarmEnabled and not lockedTeamPosition then
            detectAndLockTeam()
        end
        wait(0.5)
    end
end)

local ReplicatedStorage = game:GetService(loadstring(base64decode("UmVwbGljYXRlZFN0b3JhZ2U="))())
local success, knitServices = pcall(function()
    return ReplicatedStorage:WaitForChild(loadstring(base64decode("UGFja2FnZXM="))()):WaitForChild(loadstring(base64decode("X0luZGV4"))()):WaitForChild(loadstring(base64decode("c2xlaXRuaWNrX2tuaXRAMS43LjA="))()):WaitForChild(loadstring(base64decode("a25pdA=="))()):WaitForChild(loadstring(base64decode("U2VydmljZXM="))())
end)

if success and knitServices then
    local gameService = knitServices:WaitForChild(loadstring(base64decode("R2FtZVNlcnZpY2U="))(), 10)
    if gameService then
        local rf = gameService:WaitForChild(loadstring(base64decode("UkY="))(), 5)
        if rf then
            serveRemote = rf:WaitForChild(loadstring(base64decode("U2VydmU="))(), 5)
        end
    end
else
    local success2, remote = pcall(function()
        return ReplicatedStorage:WaitForChild(loadstring(base64decode("UGFja2FnZXM="))()):WaitForChild(loadstring(base64decode("X0luZGV4"))()):WaitForChild(loadstring(base64decode("c2xlaXRuaWNrX2tuaXRAMS43LjA="))()):WaitForChild(loadstring(base64decode("a25pdA=="))()):WaitForChild(loadstring(base64decode("U2VydmljZXM="))()):WaitForChild(loadstring(base64decode("R2FtZVNlcnZpY2U="))()):WaitForChild(loadstring(base64decode("UkY="))()):WaitForChild(loadstring(base64decode("U2VydmU="))())
    end)
    if success2 and remote then
        serveRemote = remote
    end
end

pcall(function()
    local services = knitServices
    if not services then
        services = game:GetService(loadstring(base64decode("UmVwbGljYXRlZFN0b3JhZ2U="))())
            :WaitForChild(loadstring(base64decode("UGFja2FnZXM="))()):WaitForChild(loadstring(base64decode("X0luZGV4"))())
            :WaitForChild(loadstring(base64decode("c2xlaXRuaWNrX2tuaXRAMS43LjA="))()):WaitForChild(loadstring(base64decode("a25pdA=="))())
            :WaitForChild(loadstring(base64decode("U2VydmljZXM="))())
    end
    local bs = services:FindFirstChild(loadstring(base64decode("QmFsbFNlcnZpY2U="))())
    local rf = bs and bs:FindFirstChild(loadstring(base64decode("UkY="))())
    if rf then
        ballJumpRemote = rf:FindFirstChild(loadstring(base64decode("SnVtcA=="))())
        ballInteractRemote = rf:FindFirstChild(loadstring(base64decode("SW50ZXJhY3Q="))())
    end
    local abs = services:FindFirstChild(loadstring(base64decode("QWJpbGl0eVNlcnZpY2U="))())
    local arf = abs and abs:FindFirstChild(loadstring(base64decode("UkY="))())
    if arf then
        abilityUseRemote = arf:FindFirstChild(loadstring(base64decode("VXNlQWJpbGl0eQ=="))())
    end
    local gs = services:FindFirstChild(loadstring(base64decode("R2FtZVNlcnZpY2U="))())
    local grf = gs and gs:FindFirstChild(loadstring(base64decode("UkY="))())
    if grf then
        registerMovedRemote = grf:FindFirstChild(loadstring(base64decode("UmVnaXN0ZXJNb3ZlZA=="))())
    end
end)

-- ═══════════════════════════════════════
-- ACTION BYPASS SYSTEM
-- ═══════════════════════════════════════
local actionBypassModule = nil
local cachedBypassParams = nil

local function loadActionBypass()
    if actionBypassModule then return actionBypassModule end
    pcall(function()
        local rs = game:GetService(loadstring(base64decode("UmVwbGljYXRlZFN0b3JhZ2U="))())
        local ab = rs:FindFirstChild(loadstring(base64decode("Q29udGVudA=="))())
        if ab then
            ab = ab:FindFirstChild(loadstring(base64decode("QWN0aW9uQnlwYXNz"))())
            if ab and ab:IsA(loadstring(base64decode("TW9kdWxlU2NyaXB0"))()) then
                actionBypassModule = require(ab)
            end
        end
    end)
    return actionBypassModule
end

local function computeBypass(actionType, context)
    local mod = loadActionBypass()
    if not mod then return nil end
    local ok, params = pcall(function()
        if mod.computeBypassParams then
            return mod.computeBypassParams(actionType, context)
        end
        return nil
    end)
    if ok and params then
        cachedBypassParams = params
        return params
    end
    pcall(function()
        if mod._buildClientParams then
            local built = mod._buildClientParams(actionType, context)
            if built then
                cachedBypassParams = built
                return built
            end
        end
    end)
    return cachedBypassParams
end

local function getBallIdFromModel(model)
    if not model then return nil end
    local id = tonumber(tostring(model.Name):match(loadstring(base64decode("KCVkKyk="))()))
    if id then return id end
    local attr = model:GetAttribute(loadstring(base64decode("QmFsbElk"))()) or model:GetAttribute(loadstring(base64decode("SWQ="))())
    return tonumber(attr)
end

local function computeBallDepthFactor(playerPos, ballPos, hitbox)
    local radius = 3
    if hitbox and hitbox:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
        radius = math.max(hitbox.Size.X, hitbox.Size.Y, hitbox.Size.Z) * 0.5
    elseif HitboxEnabled and HitboxSize and HitboxSize > 0 then
        radius = math.max(HitboxSize * 0.5, 2)
    end
    local dist = (playerPos - ballPos).Magnitude
    if dist >= radius then return 0 end
    local depth = 1 - (dist / math.max(radius, 0.01))
    return math.clamp(depth, 0, 1)
end

local function getAimLookAndTilt(rootPart)
    local look = rootPart.CFrame.LookVector
    local cam = workspace.CurrentCamera
    if DirectionalHitEnabled and cam then
        look = cam.CFrame.LookVector
    end
    if AimbotCornerEnabled then
        local target = getAimbotTargetCorner(rootPart.Position)
        local flat = Vector3.new(target.X - rootPart.Position.X, 0, target.Z - rootPart.Position.Z)
        if flat.Magnitude > 0.2 then
            look = flat.Unit
        end
    end
    local flatLook = Vector3.new(look.X, 0, look.Z)
    if flatLook.Magnitude < 0.05 then
        flatLook = Vector3.new(rootPart.CFrame.LookVector.X, 0, rootPart.CFrame.LookVector.Z)
    end
    if flatLook.Magnitude > 0.05 then
        flatLook = flatLook.Unit
    else
        flatLook = Vector3.new(0, 0, -1)
    end
    return look.Unit, flatLook
end

local function buildInteractPayload(action, rootPart, ballModel, ballPart, hitbox)
    local look, tilt = getAimLookAndTilt(rootPart)
    local charge = 1
    if action == loadstring(base64decode("U3Bpa2U="))() or action == loadstring(base64decode("c3Bpa2U="))() then
        if SpikeBoostEnabled then
            charge = math.clamp(tonumber(SpikeBoostCharge) or 1, 0, 1)
        end
        if PerfectSpikeAssistEnabled and ballPart then
            local depth = computeBallDepthFactor(rootPart.Position, (hitbox or ballPart).Position, hitbox)
            if depth >= 0.35 then
                charge = 1
            elseif depth > 0 then
                charge = math.max(charge, 0.7 + depth * 0.3)
            end
        end
    end
    local payload = {
        Action = action,
        Charge = charge,
        LookVector = look,
        TiltDirection = tilt,
        MoveDirection = tilt,
        From = loadstring(base64decode("Q2xpZW50"))(),
        SpecialCharge = 0.000001,
    }
    local id = getBallIdFromModel(ballModel)
    if id then
        payload.BallId = id
    end
    if cachedBypassParams then
        for 9RLLDdlZ, v in pairs(cachedBypassParams) do
            if payload[9RLLDdlZ] == nil then
                payload[9RLLDdlZ] = v
            end
        end
    end
    task.spawn(function()
        computeBypass(action, {
            Player = LocalPlayer,
            Action = action,
            BallId = id,
        })
    end)
    return payload
end

local function fireOfficialMove(action, rootPart, ballModel, ballPart, hitbox)
    if not OfficialPathEnabled or not ballInteractRemote then
        return false
    end
    local ok = pcall(function()
        local payload = buildInteractPayload(action, rootPart, ballModel, ballPart, hitbox)
        if ballInteractRemote:IsA(loadstring(base64decode("UmVtb3RlRnVuY3Rpb24="))()) then
            ballInteractRemote:InvokeServer(payload)
        else
            ballInteractRemote:FireServer(payload)
        end
    end)
    return ok
end

local function fireOfficialJump()
    pcall(function()
        if ballJumpRemote then
            if ballJumpRemote:IsA(loadstring(base64decode("UmVtb3RlRnVuY3Rpb24="))()) then
                ballJumpRemote:InvokeServer()
            else
                ballJumpRemote:FireServer()
            end
        end
        if registerMovedRemote then
            pcall(function()
                if registerMovedRemote:IsA(loadstring(base64decode("UmVtb3RlRnVuY3Rpb24="))()) then
                    registerMovedRemote:InvokeServer(loadstring(base64decode("SnVtcA=="))())
                else
                    registerMovedRemote:FireServer(loadstring(base64decode("SnVtcA=="))())
                end
            end)
        end
    end)
end

local function tryAutoAbility()
    if not AutoAbilityEnabled then return end
    if tick() - lastAutoAbility < 1.5 then return end
    if not abilityUseRemote then return end
    lastAutoAbility = tick()
    pcall(function()
        if abilityUseRemote:IsA(loadstring(base64decode("UmVtb3RlRnVuY3Rpb24="))()) then
            abilityUseRemote:InvokeServer()
        else
            abilityUseRemote:FireServer()
        end
    end)
end

local BlockedRemotes = {
    [loadstring(base64decode("UmVxdWVzdEJhbg=="))()] = true,
    [loadstring(base64decode("U2V0RmxhZw=="))()] = true,
    [loadstring(base64decode("UHJvY2Nlc3NBY3Rpb25CeXBhc3Nlcw=="))()] = true,
    [loadstring(base64decode("UHJvY2Vzc0FjdGlvbkJ5cGFzc2Vz"))()] = true,
    [loadstring(base64decode("UGxheWVyQmFubmVk"))()] = true,
    [loadstring(base64decode("UmVxdWVzdFBhcnR5S2ljaw=="))()] = true,
}

local originalNamecall
originalNamecall = hookmetamethod(game, loadstring(base64decode("X19uYW1lY2FsbA=="))(), newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local n = select(loadstring(base64decode("Iw=="))(), ...)
    local args = { ... }

    if method == loadstring(base64decode("SW52b2tlU2VydmVy"))() or method == loadstring(base64decode("RmlyZVNlcnZlcg=="))() then
        local name = loadstring(base64decode(""))()
        pcall(function() name = tostring(self.Name or loadstring(base64decode(""))()) end)
        if BlockedRemotes[name] then return end

        pcall(function()
            if DirectionalHitEnabled and name == loadstring(base64decode("SW50ZXJhY3Q="))() and type(args[1]) == loadstring(base64decode("dGFibGU="))() then
                local data = args[1]
                local cam = workspace.CurrentCamera
                if cam and data.LookVector ~= nil then
                    local look = cam.CFrame.LookVector
                    local y = (typeof(data.LookVector) == loadstring(base64decode("VmVjdG9yMw=="))()) and data.LookVector.Y or 0
                    local lv = Vector3.new(look.X, y, look.Z)
                    if lv.Magnitude > 0.001 then
                        data.LookVector = lv.Unit
                    end
                end
            end
        end)

        pcall(function()
            if name == loadstring(base64decode("SW50ZXJhY3Q="))() and type(args[1]) == loadstring(base64decode("dGFibGU="))() then
                local data = args[1]
                local act = tostring(data.Action or loadstring(base64decode(""))())
                if act == loadstring(base64decode("U3Bpa2U="))() or act == loadstring(base64decode("c3Bpa2U="))() then
                    if SpikeBoostEnabled then
                        local c = tonumber(SpikeBoostCharge) or 1
                        if c < 0 then c = 0 end
                        if c > 1 then c = 1 end
                        data.Charge = c
                    end
                    if PerfectSpikeAssistEnabled then
                        data.Charge = 1
                        if data.SpecialCharge == nil or (tonumber(data.SpecialCharge) or 0) < 0.000001 then
                            data.SpecialCharge = 0.000001
                        end
                    end
                end
            end
        end)

        pcall(function()
            if AutoStrongServeEveryServeEnabled and name == loadstring(base64decode("U2VydmU="))() and args[2] ~= nil then
                args[2] = ServeBoostPower
            end
        end)

        pcall(function()
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
        end)
    end

    return originalNamecall(self, unpack(args, 1, n))
end))

local AntiModEnabled = false
local ModeratorList = {
    loadstring(base64decode("YXNrX3NuYXBhcGxl"))(), loadstring(base64decode("bGxvdGlpZWU="))(), loadstring(base64decode("VmV6aXJlMTIz"))(), loadstring(base64decode("YXN0cmF0b2th"))(), loadstring(base64decode("U25lYWt5VGlraTE="))(),
    loadstring(base64decode("U3RhcmxpZ2h0U3RhcmJyaWdoaHQ="))(), loadstring(base64decode("N1N0eHFyMw=="))(), loadstring(base64decode("eFRvcnV6"))(), loadstring(base64decode("a29hbGFjb2NvMzQ1"))(),
    loadstring(base64decode("Q2hyaXNkYW1hbjExMjI="))(), loadstring(base64decode("TGVicm9uamFtZXNFbDdhMmUyZWU="))(), loadstring(base64decode("UGluZUNydW1i"))(), loadstring(base64decode("SGV5Q3JhZnRlZA=="))(),
    loadstring(base64decode("RG9uZHJlZDAy"))(), loadstring(base64decode("UGxhY2VfUmVib290"))(), loadstring(base64decode("bm9haHJlcHVibGlj"))(), loadstring(base64decode("S3VtYWdhd2FzRmljdGlvbg=="))(),
    loadstring(base64decode("VDB0YWxseU4wdEFUcjBsbA=="))(), loadstring(base64decode("UHJvdG9yaQ=="))(), loadstring(base64decode("QmFyRG93bmVk"))(), loadstring(base64decode("R29vZFNpclZvbGxleWJhbGw="))()
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
            LocalPlayer:Kick(loadstring(base64decode("S2luZ3MgSHViOiBNb2RlcmF0b3IgZGV0ZWN0ZWQuIFNhZmV0eSBraWNrIGFjdGl2YXRlZC4="))())
            return true
        end
    end
    return false
end

spawn(function()
    while true do
        if AntiModEnabled then checkForModerators() end
        wait(2)
    end
end)

Players.PlayerAdded:Connect(function(player)
    if AntiModEnabled and isModerator(player.Name) then
        LocalPlayer:Kick(loadstring(base64decode("S2luZ3MgSHViOiBNb2RlcmF0b3Ig"))() .. player.Name .. loadstring(base64decode("IGpvaW5lZC4gU2FmZXR5IGtpY2sgYWN0aXZhdGVkLg=="))())
    end
end)

local styleSelectChance, abilitySelectChance = nil, nil

local function cacheSelectChanceRemotes()
    pcall(function()
        local services = game:GetService(loadstring(base64decode("UmVwbGljYXRlZFN0b3JhZ2U="))())
            :WaitForChild(loadstring(base64decode("UGFja2FnZXM="))(), 4)
            :WaitForChild(loadstring(base64decode("X0luZGV4"))(), 4)
            :WaitForChild(loadstring(base64decode("c2xlaXRuaWNrX2tuaXRAMS43LjA="))(), 4)
            :WaitForChild(loadstring(base64decode("a25pdA=="))(), 4)
            :WaitForChild(loadstring(base64decode("U2VydmljZXM="))(), 4)
        local st = services:FindFirstChild(loadstring(base64decode("U3R5bGVTZXJ2aWNl"))())
        local ab = services:FindFirstChild(loadstring(base64decode("QWJpbGl0eVNlcnZpY2U="))())
        if st and st:FindFirstChild(loadstring(base64decode("UkY="))()) then
            styleSelectChance = st.RF:FindFirstChild(loadstring(base64decode("U2VsZWN0Q2hhbmNl"))())
        end
        if ab and ab:FindFirstChild(loadstring(base64decode("UkY="))()) then
            abilitySelectChance = ab.RF:FindFirstChild(loadstring(base64decode("U2VsZWN0Q2hhbmNl"))())
        end
        for _, svcName in ipairs({ loadstring(base64decode("U3R5bGVTZXJ2aWNl"))(), loadstring(base64decode("QWJpbGl0eVNlcnZpY2U="))() }) do
            local svc = services:FindFirstChild(svcName)
            local re = svc and svc:FindFirstChild(loadstring(base64decode("UkU="))())
            if re then
                local cut = re:FindFirstChild(loadstring(base64decode("UGxheVJvbGxDdXRzY2VuZQ=="))())
                if cut and cut:IsA(loadstring(base64decode("UmVtb3RlRXZlbnQ="))()) then
                    cut.OnClientEvent:Connect(function()
                        if SkipSpinEnabled then rollActiveUntil = tick() + 4 end
                    end)
                end
                local ultra = re:FindFirstChild(loadstring(base64decode("VWx0cmFSb2xsZWQ="))())
                if ultra and ultra:IsA(loadstring(base64decode("UmVtb3RlRXZlbnQ="))()) then
                    ultra.OnClientEvent:Connect(function()
                        if SkipSpinEnabled then rollActiveUntil = tick() + 4 end
                    end)
                end
            end
        end
    end)
end

spawn(function() cacheSelectChanceRemotes() end)

-- ═══════════════════════════════════════
-- ADVANCED AUTO SPIN SYSTEM
-- ═══════════════════════════════════════
local function cacheSpinRemotes()
    pcall(function()
        local services = game:GetService(loadstring(base64decode("UmVwbGljYXRlZFN0b3JhZ2U="))())
            .Packages._Index[loadstring(base64decode("c2xlaXRuaWNrX2tuaXRAMS43LjA="))()].knit.Services
        local st = services:FindFirstChild(loadstring(base64decode("U3R5bGVTZXJ2aWNl"))())
        local ab = services:FindFirstChild(loadstring(base64decode("QWJpbGl0eVNlcnZpY2U="))())
        if st and st:FindFirstChild(loadstring(base64decode("UkY="))()) then
            styleRollRemote = st.RF:FindFirstChild(loadstring(base64decode("Um9sbA=="))())
            styleSelectSlot = st.RF:FindFirstChild(loadstring(base64decode("U2VsZWN0U2xvdA=="))())
            if not styleSelectChance then
                styleSelectChance = st.RF:FindFirstChild(loadstring(base64decode("U2VsZWN0Q2hhbmNl"))())
            end
        end
        if ab and ab:FindFirstChild(loadstring(base64decode("UkY="))()) then
            abilityRollRemote = ab.RF:FindFirstChild(loadstring(base64decode("Um9sbA=="))())
            abilitySelectSlot = ab.RF:FindFirstChild(loadstring(base64decode("U2VsZWN0U2xvdA=="))())
            if not abilitySelectChance then
                abilitySelectChance = ab.RF:FindFirstChild(loadstring(base64decode("U2VsZWN0Q2hhbmNl"))())
            end
        end
    end)
end

spawn(function()
    task.wait(2)
    cacheSpinRemotes()
end)

local function readLastRollResult()
    local result = { name = loadstring(base64decode(""))(), rarity = loadstring(base64decode(""))() }
    pcall(function()
        local pg = LocalPlayer:FindFirstChild(loadstring(base64decode("UGxheWVyR3Vp"))())
        if not pg then return end
        local targetLower = string.lower(AutoSpinTargetName or loadstring(base64decode(""))())
        for _, gui in pairs(pg:GetDescendants()) do
            if gui:IsA(loadstring(base64decode("VGV4dExhYmVs"))()) or gui:IsA(loadstring(base64decode("VGV4dEJ1dHRvbg=="))()) then
                local t = string.lower(tostring(gui.Text or loadstring(base64decode(""))()))
                if t:find(loadstring(base64decode("c2VjcmV0"))(), 1, true) then result.rarity = loadstring(base64decode("U2VjcmV0"))()
                elseif t:find(loadstring(base64decode("Z29kbHk="))(), 1, true) then result.rarity = loadstring(base64decode("R29kbHk="))()
                elseif t:find(loadstring(base64decode("bGVnZW5kYXJ5"))(), 1, true) then result.rarity = loadstring(base64decode("TGVnZW5kYXJ5"))()
                elseif t:find(loadstring(base64decode("dWx0cmE="))(), 1, true) then result.rarity = loadstring(base64decode("VWx0cmE="))()
                elseif t:find(loadstring(base64decode("ZXZv"))(), 1, true) then result.rarity = loadstring(base64decode("RXZv"))()
                end
                if targetLower ~= loadstring(base64decode(""))() and t:find(targetLower, 1, true) then
                    result.name = AutoSpinTargetName
                end
            end
        end
    end)
    return result
end

local function doAutoSpinOnce()
    if AutoSpinBusy then return end
    if tick() - lastAutoSpin < AutoSpinSpeed then return end
    lastAutoSpin = tick()
    AutoSpinBusy = true
    cacheSpinRemotes()

    pcall(function()
        if AutoSpinType == loadstring(base64decode("U3R5bGU="))() and styleSelectSlot then
            styleSelectSlot:InvokeServer(AutoSpinSlot)
        elseif AutoSpinType == loadstring(base64decode("QWJpbGl0eQ=="))() and abilitySelectSlot then
            abilitySelectSlot:InvokeServer(AutoSpinSlot)
        end
    end)

    pcall(function()
        if AutoSpinTargetName ~= loadstring(base64decode(""))() then
            if AutoSpinType == loadstring(base64decode("U3R5bGU="))() and styleSelectChance then
                pcall(function() styleSelectChance:InvokeServer(AutoSpinTargetName) end)
                pcall(function() styleSelectChance:InvokeServer() end)
            elseif AutoSpinType == loadstring(base64decode("QWJpbGl0eQ=="))() and abilitySelectChance then
                pcall(function() abilitySelectChance:InvokeServer(AutoSpinTargetName) end)
                pcall(function() abilitySelectChance:InvokeServer() end)
            end
        end
    end)

    local ok = false
    pcall(function()
        if AutoSpinType == loadstring(base64decode("U3R5bGU="))() and styleRollRemote then
            if AutoSpinUseLucky then
                styleRollRemote:InvokeServer(true)
            else
                styleRollRemote:InvokeServer()
            end
            ok = true
        elseif AutoSpinType == loadstring(base64decode("QWJpbGl0eQ=="))() and abilityRollRemote then
            if AutoSpinUseLucky then
                abilityRollRemote:InvokeServer(true)
            else
                abilityRollRemote:InvokeServer()
            end
            ok = true
        end
    end)

    task.delay(0.12, function()
        pcall(applySkipSpin)
    end)

    task.delay(0.55, function()
        local res = readLastRollResult()
        if AutoSpinStopOnTarget and AutoSpinTargetName ~= loadstring(base64decode(""))() and res.name ~= loadstring(base64decode(""))() then
            AutoSpinEnabled = false
            notify(loadstring(base64decode("QXV0byBTcGluIHN0b3BwZWQg4oCUIGdvdCB0YXJnZXQ6IA=="))() .. tostring(res.name), 6)
        end
        if AutoSpinStopOnRarity ~= loadstring(base64decode(""))() and res.rarity ~= loadstring(base64decode(""))() then
            if string.lower(res.rarity) == string.lower(AutoSpinStopOnRarity) then
                AutoSpinEnabled = false
                notify(loadstring(base64decode("QXV0byBTcGluIHN0b3BwZWQg4oCUIHJhcml0eTog"))() .. tostring(res.rarity), 6)
            end
        end
        AutoSpinBusy = false
    end)

    if not ok then
        AutoSpinBusy = false
    end
end

spawn(function()
    while true do
        if AutoSpinEnabled then
            pcall(doAutoSpinOnce)
            task.wait(math.max(0.12, AutoSpinSpeed))
        else
            task.wait(0.4)
        end
    end
end)

local function isMasteryOrPurchaseUI(gui)
    local node = gui
    for _ = 1, 12 do
        if not node then break end
        local n = string.lower(tostring(node.Name or loadstring(base64decode(""))()))
        if n:find(loadstring(base64decode("bWFzdGVyeQ=="))(), 1, true) or n:find(loadstring(base64decode("Y2hhbGxlbmdl"))(), 1, true)
            or n:find(loadstring(base64decode("cHVyY2hhc2U="))(), 1, true) or n:find(loadstring(base64decode("cHJvZHVjdA=="))(), 1, true)
            or n:find(loadstring(base64decode("cm9idXg="))(), 1, true) or n:find(loadstring(base64decode("cHJvbXB0"))(), 1, true)
            or n:find(loadstring(base64decode("c2hvcA=="))(), 1, true) or n:find(loadstring(base64decode("Z2FtZXBhc3M="))(), 1, true)
            or n:find(loadstring(base64decode("ZGV2cHJvZHVjdA=="))(), 1, true) or n:find(loadstring(base64decode("bWFya2V0cGxhY2U="))(), 1, true) then
            return true
        end
        node = node.Parent
    end
    return false
end

local function clickSkipButtons()
    local pg = LocalPlayer:FindFirstChild(loadstring(base64decode("UGxheWVyR3Vp"))())
    if not pg then return end
    local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
    local function tryClick(gui)
        if isMasteryOrPurchaseUI(gui) then return end
        pcall(function()
            if firesignal then
                pcall(function() firesignal(gui.Activated) end)
                pcall(function() firesignal(gui.MouseButton1Click) end)
            end
        end)
        pcall(function()
            local pos = gui.AbsolutePosition
            local size = gui.AbsoluteSize
            local cx, cy = pos.X + size.X / 2, pos.Y + size.Y / 2
            VIM:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
            task.wait(0.01)
            VIM:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
        end)
    end
    for _, gui in pairs(pg:GetDescendants()) do
        if gui:IsA(loadstring(base64decode("R3VpQnV0dG9u"))()) and gui.Visible and gui.AbsoluteSize.X > 2 then
            if not isMasteryOrPurchaseUI(gui) then
                local name = string.lower(tostring(gui.Name or loadstring(base64decode(""))()))
                local text = loadstring(base64decode(""))()
                pcall(function()
                    if gui:IsA(loadstring(base64decode("VGV4dEJ1dHRvbg=="))()) then text = string.lower(tostring(gui.Text or loadstring(base64decode(""))())) end
                    local tl = gui:FindFirstChildWhichIsA(loadstring(base64decode("VGV4dExhYmVs"))(), true)
                    if tl then text = text .. loadstring(base64decode("IA=="))() .. string.lower(tostring(tl.Text or loadstring(base64decode(""))())) end
                end)
                local blob = name .. loadstring(base64decode("IA=="))() .. text
                local looksSkip = blob:find(loadstring(base64decode("c2tpcA=="))(), 1, true) or blob:find(loadstring(base64decode("Y29udGludWU="))(), 1, true) or blob:find(loadstring(base64decode("Y2xhaW0="))(), 1, true)
                if looksSkip and not blob:find(loadstring(base64decode("c2tpcCBhbGw="))(), 1, true) and not blob:find(loadstring(base64decode("c2tpcGFsbA=="))(), 1, true) then
                    tryClick(gui)
                end
            end
        end
    end
end

local function applySkipSpin()
    if not SkipSpinEnabled then return end
    local now = tick()
    if now - lastSkipSpin < 0.1 then return end
    lastSkipSpin = now
    if not styleSelectChance and not abilitySelectChance then
        cacheSelectChanceRemotes()
    end
    if styleSelectChance then
        pcall(function() styleSelectChance:InvokeServer() end)
        pcall(function() styleSelectChance:InvokeServer(true) end)
    end
    if abilitySelectChance then
        pcall(function() abilitySelectChance:InvokeServer() end)
        pcall(function() abilitySelectChance:InvokeServer(true) end)
    end
    clickSkipButtons()
end

spawn(function()
    while true do
        if SkipSpinEnabled then
            pcall(applySkipSpin)
            wait(0.1)
        else
            rollActiveUntil = 0
            wait(0.35)
        end
    end
end)

local function getSeasonRF(childName)
    local ok, remote = pcall(function()
        local packages = game:GetService(loadstring(base64decode("UmVwbGljYXRlZFN0b3JhZ2U="))()):WaitForChild(loadstring(base64decode("UGFja2FnZXM="))(), 5)
        local index = packages:WaitForChild(loadstring(base64decode("X0luZGV4"))(), 5)
        local knitPkg = index:WaitForChild(loadstring(base64decode("c2xlaXRuaWNrX2tuaXRAMS43LjA="))(), 5)
        local knit = knitPkg:WaitForChild(loadstring(base64decode("a25pdA=="))(), 5)
        local services = knit:WaitForChild(loadstring(base64decode("U2VydmljZXM="))(), 5)
        local season = services:WaitForChild(loadstring(base64decode("U2Vhc29uU2VydmljZQ=="))(), 5)
        local rf = season:WaitForChild(loadstring(base64decode("UkY="))(), 5)
        return rf:WaitForChild(childName, 5)
    end)
    if ok then return remote end
    return nil
end

local function getRankedRewardRemote()
    return getSeasonRF(loadstring(base64decode("UmVxdWVzdFJhbmtlZFJld2FyZA=="))())
end

local function getRewardClaimRemote()
    return getSeasonRF(loadstring(base64decode("UmVxdWVzdFJld2FyZENsYWlt"))())
end

local rankedRewardRemote = nil
local rewardClaimRemote = nil
spawn(function()
    rankedRewardRemote = getRankedRewardRemote()
end)

-- ═══════════════════════════════════════
-- FIXED INF GEMS + INF REWARDS
-- ═══════════════════════════════════════
local function claimRankedGems()
    -- League 1-6 Rewards (Gems — One-Time per Season)
    if rankedRewardRemote then
        for league = 1, 6 do
            pcall(function() rankedRewardRemote:InvokeServer(loadstring(base64decode("UHJvTGVhZ3Vl"))(), league) end)
            task.wait(0.06)
        end
    end
end

local function claimDailyPresents()
    -- Daily Present (Gems — Once per Day)
    pcall(function()
        local services = knitServices
        if not services then return end
        local season = services:FindFirstChild(loadstring(base64decode("U2Vhc29uU2VydmljZQ=="))())
        local rf = season and season:FindFirstChild(loadstring(base64decode("UkY="))())
        if not rf then return end
        
        -- Refresh first
        local refresh = rf:FindFirstChild(loadstring(base64decode("UmVmcmVzaERhaWx5UHJlc2VudHM="))())
        if refresh then pcall(function() refresh:InvokeServer() end) end
        task.wait(0.2)
        
        -- Claim
        local claim = rf:FindFirstChild(loadstring(base64decode("Q2xhaW1EYWlseVByZXNlbnQ="))())
        if claim then
            for FWCtIXZR = 1, 3 do
                pcall(function() claim:InvokeServer() end)
                task.wait(0.1)
            end
        end
    end)
end

local function claimAllRewards()
    pcall(function()
        local services = knitServices
        if not services then return end
        local qs = services:FindFirstChild(loadstring(base64decode("UXVlc3RTZXJ2aWNl"))())
        local rf = qs and qs:FindFirstChild(loadstring(base64decode("UkY="))())
        local claimAll = rf and rf:FindFirstChild(loadstring(base64decode("Q2xhaW1BbGw="))())
        if claimAll then claimAll:InvokeServer() end
    end)
    pcall(function()
        local services = knitServices
        if not services then return end
        local rs = services:FindFirstChild(loadstring(base64decode("UmV3YXJkU2VydmljZQ=="))())
        local rf = rs and rs:FindFirstChild(loadstring(base64decode("UkY="))())
        local reqReward = rf and rf:FindFirstChild(loadstring(base64decode("UmVxdWVzdFJld2FyZA=="))())
        if reqReward then reqReward:InvokeServer() end
    end)
    pcall(function()
        local services = knitServices
        if not services then return end
        local ms = services:FindFirstChild(loadstring(base64decode("TWFzdGVyeVNlcnZpY2U="))())
        local rf = ms and ms:FindFirstChild(loadstring(base64decode("UkY="))())
        local reqClaim = rf and rf:FindFirstChild(loadstring(base64decode("UmVxdWVzdENsYWlt"))())
        if reqClaim then reqClaim:InvokeServer() end
    end)
    pcall(function()
        local services = knitServices
        if not services then return end
        local ls = services:FindFirstChild(loadstring(base64decode("TGV2ZWxTZXJ2aWNl"))())
        local rf = ls and ls:FindFirstChild(loadstring(base64decode("UkY="))())
        local claimLevel = rf and rf:FindFirstChild(loadstring(base64decode("Q2xhaW1MZXZlbFJld2FyZHM="))())
        if claimLevel then claimLevel:InvokeServer() end
    end)
    pcall(function()
        local services = knitServices
        if not services then return end
        local lbrs = services:FindFirstChild(loadstring(base64decode("TGVhZGVyYm9hcmRSZXdhcmRTZXJ2aWNl"))())
        local rf = lbrs and lbrs:FindFirstChild(loadstring(base64decode("UkY="))())
        local reqReward = rf and rf:FindFirstChild(loadstring(base64decode("UmVxdWVzdFJld2FyZA=="))())
        if reqReward then reqReward:InvokeServer() end
    end)
end

spawn(function()
    while true do
        local any = InfSpinsEnabled or InfYensEnabled or InfAbilitiesEnabled or InfGemsEnabled
        if any then
            if not rankedRewardRemote then rankedRewardRemote = getRankedRewardRemote() end
            if not cachedBypassParams then
                computeBypass(loadstring(base64decode("SW50ZXJhY3Q="))(), { Player = LocalPlayer })
            end
            if InfSpinsEnabled and not infSpinsBusy then
                infSpinsBusy = true
                for _, id in ipairs({1, 7, 11}) do
                    pcall(function() rankedRewardRemote:InvokeServer(id) end)
                    task.wait(0.2)
                end
                infSpinsBusy = false
            end
            if InfYensEnabled and not infYensBusy then
                infYensBusy = true
                for _, id in ipairs({2, 10}) do
                    pcall(function() rankedRewardRemote:InvokeServer(id) end)
                    task.wait(0.2)
                end
                infYensBusy = false
            end
            if InfAbilitiesEnabled and not infAbilitiesBusy then
                infAbilitiesBusy = true
                for _, id in ipairs({4, 8}) do
                    pcall(function() rankedRewardRemote:InvokeServer(id) end)
                    task.wait(0.2)
                end
                infAbilitiesBusy = false
            end
            if InfGemsEnabled and not infGemsBusy then
                infGemsBusy = true
                claimRankedGems()
                task.wait(0.3)
                claimSeasonPassGems()
                task.wait(0.3)
                claimAllRewards()
                task.wait(0.3)
                claimDailyPresents()
                infGemsBusy = false
            end
            task.wait(1)
        else
            task.wait(0.4)
        end
    end
end)

local function applyJumpBoost()
    if not JumpBoostEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if not hum then return end
    local targetH = 7.2 * JumpBoostMult
    local targetP = 50 * JumpBoostMult
    pcall(function()
        if hum.UseJumpPower then
            hum.JumpPower = targetP
        else
            hum.JumpHeight = targetH
            if hum.JumpHeight == 0 then
                hum.JumpPower = targetP
            end
        end
    end)
end

spawn(function()
    while true do
        if JumpBoostEnabled then pcall(applyJumpBoost) wait(0.2)
        else wait(0.4) end
    end
end)

local JumpESPObjects = {}
local PredictAimObjects = {}

local function simpleAutoFarm()
    if not AutoFarmEnabled then return end
    local innerCylinder = workspace:FindFirstChild(loadstring(base64decode("Vm9sbGV5YmFsbCBMb2JieQ=="))())
    if innerCylinder then
        local interactables = innerCylinder:FindFirstChild(loadstring(base64decode("SW50ZXJhY3RhYmxlcw=="))())
        if interactables then
            local portal = interactables:FindFirstChild(loadstring(base64decode("UG9ydGFs"))())
            if portal then
                local innerCyl = portal:FindFirstChild(loadstring(base64decode("SW5uZXJDeWxpbmRlcg=="))())
                if innerCyl then
                    LocalPlayer.Character:SetPrimaryPartCFrame(innerCyl.CFrame)
                    local maxWait = 10
                    local waitTime = 0
                    while waitTime < maxWait do
                        local teamSelectionUI = LocalPlayer.PlayerGui:FindFirstChild(loadstring(base64decode("SW50ZXJmYWNl"))())
                        if teamSelectionUI then
                            local teamSelection = teamSelectionUI:FindFirstChild(loadstring(base64decode("VGVhbVNlbGVjdGlvbg=="))())
                            if teamSelection and teamSelection.Visible then
                                local positionsToCheck = {
                                    {team = 1, position = 1}, {team = 1, position = 2},
                                    {team = 1, position = 3}, {team = 2, position = 1},
                                    {team = 2, position = 2}, {team = 2, position = 3}
                                }
                                local joinedAnyPosition = false
                                for _, posData in pairs(positionsToCheck) do
                                    local team = teamSelection:FindFirstChild(tostring(posData.team))
                                    if team then
                                        local teamHolder = team:FindFirstChild(loadstring(base64decode("VGVhbUhvbGRlcg=="))())
                                        if teamHolder then
                                            local positionFrame = teamHolder:FindFirstChild(tostring(posData.position))
                                            if positionFrame then
                                                local headshot = positionFrame:FindFirstChild(loadstring(base64decode("SGVhZHNob3Q="))())
                                                if not headshot or not headshot.Image or headshot.Image == loadstring(base64decode(""))() or headshot.Image == loadstring(base64decode("cmJ4YXNzZXQ6Ly90ZXh0dXJlcy91aS9HdWlJbWFnZVBsYWNlaG9sZGVyLnBuZw=="))() then
                                                    local absolutePos = positionFrame.AbsolutePosition
                                                    local absoluteSize = positionFrame.AbsoluteSize
                                                    local centerX = absolutePos.X + absoluteSize.X / 2
                                                    local centerY = absolutePos.Y + absoluteSize.Y / 2
                                                    local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
                                                    VIM:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
                                                    wait(0.1)
                                                    VIM:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
                                                    joinedAnyPosition = true
                                                    wait(3)
                                                    local VIM2 = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
                                                    VIM2:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                                                    wait(0.05)
                                                    VIM2:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
                                                    autoClicking = true
                                                    spawn(function()
                                                        while autoClicking and AutoFarmEnabled do
                                                            local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
                                                            VIM:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                                                            wait(0.05)
                                                            VIM:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                                                            wait(0.05)
                                                            local ballPart = nil
                                                            for _, v in pairs(workspace:GetChildren()) do
                                                                if v.Name:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) and v:IsA(loadstring(base64decode("TW9kZWw="))()) then
                                                                    ballPart = v:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))())
                                                                    break
                                                                end
                                                            end
                                                            if ballPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) then
                                                                local playerRoot = LocalPlayer.Character.HumanoidRootPart
                                                                local ballPos = ballPart.Position
                                                                local currentPos = playerRoot.Position
                                                                local newCFrame = CFrame.new(ballPos.X, currentPos.Y, currentPos.Z) * playerRoot.CFrame - playerRoot.Position
                                                                LocalPlayer.Character:SetPrimaryPartCFrame(newCFrame)
                                                            end
                                                            wait(0.05)
                                                        end
                                                    end)
                                                    return
                                                end
                                            end
                                        end
                                    end
                                end
                                if not joinedAnyPosition then
                                    LocalPlayer:Kick(loadstring(base64decode("S2luZ3MgSHViOiBBbGwgcG9zaXRpb25zIG9jY3VwaWVkLiBGaW5kaW5nIG5ldyBzZXJ2ZXIuLi4="))())
                                    return
                                end
                            end
                        end
                        wait(0.5)
                        waitTime = waitTime + 0.5
                    end
                end
            end
        end
    end
end

spawn(function()
    while true do
        if AutoFarmEnabled then
            local wasInGame = isInGameStable()
            wait(1)
            local isInGameNow = isInGameStable()
            if wasInGame and not isInGameNow then
                autoClicking = false
                lockedTeamPosition = nil
                lockedTeamCFrame = nil
                wait(2)
            end
        end
        wait(0.5)
    end
end)

spawn(function()
    local lastRoundOverHandle = 0
    while true do
        if AutoFarmEnabled then
            local playerGui = game:GetService(loadstring(base64decode("UGxheWVycw=="))()).LocalPlayer.PlayerGui
            if playerGui then
                local interface = playerGui:FindFirstChild(loadstring(base64decode("SW50ZXJmYWNl"))())
                if interface then
                    local roundOverStats = interface:FindFirstChild(loadstring(base64decode("Um91bmRPdmVyU3RhdHM="))())
                    if roundOverStats and roundOverStats.Visible then
                        if tick() - lastRoundOverHandle > 1 then
                            lastRoundOverHandle = tick()
                            pcall(function() roundOverStats.Visible = false end)
                            resetAutoFarmCycle()
                            spawn(function()
                                wait(0.5)
                                if AutoFarmEnabled and not autoClicking then simpleAutoFarm() end
                            end)
                        end
                    end
                end
            end
        end
        wait(1)
    end
end)

spawn(function()
    while true do
        if AutoFarmEnabled and not autoClicking then
            local character = LocalPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
            if not character or not humanoid or humanoid.Health <= 0 then
                autoClicking = false
                LocalPlayer.CharacterAdded:Wait()
                wait(1)
            else
                simpleAutoFarm()
            end
        end
        wait(3)
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
    local humanoid = character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
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
    local highlight = Instance.new(loadstring(base64decode("SGlnaGxpZ2h0"))())
    highlight.Name = loadstring(base64decode("SnVtcEVTUA=="))()
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
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    local head = character:FindFirstChild(loadstring(base64decode("SGVhZA=="))())
    if not rootPart or not head then return end
    if PredictAimObjects[player] then
        if PredictAimObjects[player].Line then PredictAimObjects[player].Line:Destroy() end
        if PredictAimObjects[player].Point then PredictAimObjects[player].Point:Destroy() end
        PredictAimObjects[player] = nil
    end
    local lookVector = rootPart.CFrame.LookVector
    local spikeDirection = lookVector.Unit
    local line = Instance.new(loadstring(base64decode("UGFydA=="))())
    line.Name = loadstring(base64decode("UHJlZGljdExpbmU="))()
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
    local point = Instance.new(loadstring(base64decode("UGFydA=="))())
    point.Name = loadstring(base64decode("UHJlZGljdFBvaW50"))()
    point.Anchored = true
    point.CanCollide = false
    point.Material = Enum.Material.Neon
    point.Color = PredictAimColor
    point.Size = Vector3.new(1, 1, 1)
    point.Shape = Enum.PartType.Ball
    point.Transparency = 0.3
    point.Position = endPos
    PredictAimObjects[player] = { Line = line, Point = point }
end

local function updatePredictLine(player)
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    local head = character:FindFirstChild(loadstring(base64decode("SGVhZA=="))())
    if not rootPart or not head then return end
    if PredictAimObjects[player] then
        local lookVector = rootPart.CFrame.LookVector
        local spikeDirection = lookVector.Unit
        local startPos = head.Position + Vector3.new(0, 1, 0)
        local endPos = startPos + (spikeDirection * PredictAimLength)
        local midPoint = (startPos + endPos) / 2
        if PredictAimObjects[player].Line then
            PredictAimObjects[player].Line.Size = Vector3.new(0.2, 0.2, PredictAimLength)
            PredictAimObjects[player].Line.CFrame = CFrame.lookAt(midPoint, endPos)
            PredictAimObjects[player].Line.Color = PredictAimColor
        end
        if PredictAimObjects[player].Point then
            PredictAimObjects[player].Point.Position = endPos
            PredictAimObjects[player].Point.Color = PredictAimColor
        end
    end
end

local function removePredictLine(player)
    if PredictAimObjects[player] then
        if PredictAimObjects[player].Line then PredictAimObjects[player].Line:Destroy() end
        if PredictAimObjects[player].Point then PredictAimObjects[player].Point:Destroy() end
        PredictAimObjects[player] = nil
    end
end

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
    local size = HitboxSize or 0
    -- Force usable hitbox when auto combat features are on
    if size < 4 and (AutoSpikeEnabled or AutoReceiveEnabled or AutoSetEnabled or AutoJumpSetEnabled or SilentSpikeEnabled) then
        size = 10
    end
    if size <= 0 then return end
    for _, v in pairs(workspace:GetChildren()) do
        local n = tostring(v.Name or loadstring(base64decode(""))())
        if (n:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) or n:find(loadstring(base64decode("QkFMTA=="))())) and v:IsA(loadstring(base64decode("TW9kZWw="))()) then
            local ballPart = v:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))())
            if not ballPart then
                for _, part in pairs(v:GetDescendants()) do
                    if part:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) and part.Name ~= loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))() then
                        ballPart = part
                        break
                    end
                end
            end
            if ballPart then
                local existingHitbox = v:FindFirstChild(loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))())
                if existingHitbox and existingHitbox:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
                    existingHitbox.Size = Vector3.new(size, size, size)
                    existingHitbox.Color = HitboxColor
                    existingHitbox.Transparency = HitboxTransparency
                    existingHitbox.Material = Enum.Material.ForceField
                    existingHitbox.CanCollide = false
                    existingHitbox.CanTouch = true
                    existingHitbox.CFrame = ballPart.CFrame
                else
                    local hitbox = Instance.new(loadstring(base64decode("UGFydA=="))())
                    hitbox.Name = loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))()
                    hitbox.Size = Vector3.new(size, size, size)
                    hitbox.Transparency = HitboxTransparency
                    hitbox.Color = HitboxColor
                    hitbox.Material = Enum.Material.ForceField
                    hitbox.CanCollide = false
                    hitbox.CanTouch = true
                    hitbox.Massless = true
                    hitbox.Anchored = false
                    hitbox.Shape = Enum.PartType.Ball
                    hitbox.CFrame = ballPart.CFrame
                    hitbox.Parent = v
                    local weld = Instance.new(loadstring(base64decode("V2VsZENvbnN0cmFpbnQ="))())
                    weld.Part0 = ballPart
                    weld.Part1 = hitbox
                    weld.Parent = hitbox
                end
            end
        end
    end
end

local function removeHitboxes()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) and v:IsA(loadstring(base64decode("TW9kZWw="))()) then
            local hitbox = v:FindFirstChild(loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))())
            if hitbox then hitbox:Destroy() end
        end
    end
end

local function autoStrongServe()
    local playerGui = LocalPlayer.PlayerGui
    if not playerGui then return end
    local interface = playerGui:FindFirstChild(loadstring(base64decode("SW50ZXJmYWNl"))())
    if not interface then return end
    local gameUI = interface:FindFirstChild(loadstring(base64decode("R2FtZQ=="))())
    if not gameUI then return end
    local power = gameUI:FindFirstChild(loadstring(base64decode("UG93ZXI="))())
    if not power or not power.Visible then return end
    local arrow = power:FindFirstChild(loadstring(base64decode("QXJyb3c="))())
    local extraPower = power:FindFirstChild(loadstring(base64decode("RXh0cmFQb3dlcg=="))())
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
        local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
        local cx = arrowCenterX
        local cy = arrowPos.Y + (arrowSize.Y / 2)
        VIM:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
        wait(0.05)
        VIM:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
    end
end

local SPIKE_SET_KEYWORDS = {
    loadstring(base64decode("c3Bpa2U="))(), loadstring(base64decode("c2V0"))(), loadstring(base64decode("YnVtcA=="))(), loadstring(base64decode("ZGl2ZQ=="))(), loadstring(base64decode("YXR0YWNr"))(), loadstring(base64decode("aGl0"))(), loadstring(base64decode("c21hc2g="))(), loadstring(base64decode("cmVjZWl2ZQ=="))(), loadstring(base64decode("dG9zcw=="))(), loadstring(base64decode("a2lsbA=="))(),
}

local function trackLooksSpikeOrSet(track)
    if not track then return false end
    local n = loadstring(base64decode(""))()
    pcall(function()
        local anim = track.Animation
        if anim then
            n = string.lower(tostring(anim.Name or loadstring(base64decode(""))()) .. loadstring(base64decode("IA=="))() .. tostring(anim.AnimationId or loadstring(base64decode(""))()))
        end
        n = n .. loadstring(base64decode("IA=="))() .. string.lower(tostring(track.Name or loadstring(base64decode(""))()))
    end)
    for _, 9RLLDdlZ in ipairs(SPIKE_SET_KEYWORDS) do
        if n:find(9RLLDdlZ, 1, true) then return true end
    end
    if n:find(loadstring(base64decode("anVtcA=="))(), 1, true) or n:find(loadstring(base64decode("ZmFsbA=="))(), 1, true) or n:find(loadstring(base64decode("cnVu"))(), 1, true)
        or n:find(loadstring(base64decode("d2Fsaw=="))(), 1, true) or n:find(loadstring(base64decode("aWRsZQ=="))(), 1, true) then
        return false
    end
    return false
end

local function stopSpikeSetTracks(character)
    if not character then return end
    local hum = character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if not hum then return end
    local animator = hum:FindFirstChildOfClass(loadstring(base64decode("QW5pbWF0b3I="))())
    if not animator then return end
    pcall(function()
        for _, track in pairs(animator:GetPlayingAnimationTracks()) do
            if trackLooksSpikeOrSet(track) then
                pcall(function() track:Stop(0) track:Destroy() end)
            end
        end
    end)
end

local function bindAnimDesync(character)
    if animDesyncConn then pcall(function() animDesyncConn:Disconnect() end) animDesyncConn = nil end
    if not character then return end
    local hum = character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if not hum then return end
    local animator = hum:FindFirstChildOfClass(loadstring(base64decode("QW5pbWF0b3I="))())
    if not animator then animator = hum:WaitForChild(loadstring(base64decode("QW5pbWF0b3I="))(), 3) end
    if not animator then return end
    animDesyncConn = animator.AnimationPlayed:Connect(function(track)
        if not AnimDesyncEnabled then return end
        if trackLooksSpikeOrSet(track) then
            pcall(function() track:Stop(0) end)
        end
    end)
end

local function enableAnimDesync()
    local char = LocalPlayer.Character
    if char then bindAnimDesync(char) end
end

local function disableAnimDesync()
    if animDesyncConn then pcall(function() animDesyncConn:Disconnect() end) animDesyncConn = nil end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    if AnimDesyncEnabled then task.defer(function() bindAnimDesync(char) end) end
end)

spawn(function()
    while true do
        if AnimDesyncEnabled then
            pcall(function() stopSpikeSetTracks(LocalPlayer.Character) end)
            wait(0.08)
        else
            wait(0.35)
        end
    end
end)

local function doSilentSpike()
    if tick() - lastSilentSpike < 0.22 then return end
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    local humanoid = character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if not rootPart or not humanoid then return end
    lastSilentSpike = tick()
    local playerPos = rootPart.Position
    local cam = workspace.CurrentCamera
    fireOfficialJump()
    pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Freefall) end)
    local best, bestDist, bestModel, bestBall, bestHb = nil, 14, nil, nil, nil
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) and v:IsA(loadstring(base64decode("TW9kZWw="))()) then
            local ball = v:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))())
            if ball then
                local hb = v:FindFirstChild(loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))())
                local aim = hb or ball
                local d = (playerPos - aim.Position).Magnitude
                local reach = hb and (2 + hb.Size.X / 2 + 4) or 9
                if d <= reach and d < bestDist then
                    bestDist = d
                    best = aim
                    bestModel = v
                    bestBall = ball
                    bestHb = hb
                end
            end
        end
    end
    if best then
        local usedOfficial = fireOfficialMove(loadstring(base64decode("U3Bpa2U="))(), rootPart, bestModel, bestBall, bestHb)
        if not usedOfficial then
            local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
            local cx, cy = 0, 0
            if cam then
                local sp, on = cam:WorldToScreenPoint(best.Position)
                if on then cx, cy = sp.X, sp.Y end
            end
            VIM:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
            task.wait(0.015)
            VIM:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
        end
        tryAutoAbility()
    end
    task.delay(0.02, function()
        if AnimDesyncEnabled or SilentSpikeEnabled then
            pcall(function() stopSpikeSetTracks(LocalPlayer.Character) end)
        end
    end)
end

local function autoSpike()
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    if not rootPart then return end
    local humanoid = character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if not humanoid then return end
    local state = humanoid:GetState()
    local inAir = (state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall)
    -- Also allow if vertical velocity suggests airborne
    if not inAir then
        local vy = rootPart.AssemblyLinearVelocity.Y
        if vy > 2 or vy < -2 then
            inAir = true
        end
    end
    if not inAir then return end
    if tick() - lastAutoSpikeClick < 0.04 then return end

    local camera = workspace.CurrentCamera
    local playerPos = rootPart.Position
    local bestDist, bestModel, bestBall, bestHb, bestAim = math.huge, nil, nil, nil, nil

    -- Scan CLIENT_BALL models
    for _, v in pairs(workspace:GetChildren()) do
        local name = tostring(v.Name or loadstring(base64decode(""))())
        if (name:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) or name:find(loadstring(base64decode("QmFsbA=="))()) or name:find(loadstring(base64decode("QkFMTA=="))())) and (v:IsA(loadstring(base64decode("TW9kZWw="))()) or v:IsA(loadstring(base64decode("QmFzZVBhcnQ="))())) then
            local ball = nil
            local model = nil
            if v:IsA(loadstring(base64decode("TW9kZWw="))()) then
                model = v
                ball = v:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))())
            elseif v:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
                ball = v
                model = v
            end
            if ball then
                local extendedHitbox = nil
                if model:IsA(loadstring(base64decode("TW9kZWw="))()) then
                    extendedHitbox = model:FindFirstChild(loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))())
                end
                local aimPart = extendedHitbox or ball
                local aimPos = aimPart.Position
                local hbRadius = 3
                if extendedHitbox and extendedHitbox:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
                    hbRadius = math.max(extendedHitbox.Size.X, extendedHitbox.Size.Y, extendedHitbox.Size.Z) * 0.5
                elseif HitboxEnabled and HitboxSize and HitboxSize > 0 then
                    hbRadius = math.max(HitboxSize * 0.5, 3)
                end
                -- Generous reach for spike/counter
                local reach = 2.5 + hbRadius + 2.0
                local dist = (playerPos - aimPos).Magnitude
                local velocity = Vector3.zero
                pcall(function() velocity = ball.AssemblyLinearVelocity end)
                local spd = velocity.Magnitude

                local shouldHit = dist <= reach
                -- Counter: ball coming toward player
                if not shouldHit and spd >= 8 then
                    local toPlayer = playerPos - ball.Position
                    if toPlayer.Magnitude > 0.1 and velocity.Magnitude > 0.1 then
                        local closing = velocity.Unit:Dot(toPlayer.Unit) < -0.15
                        if closing and dist <= reach + 4 then
                            shouldHit = true
                        end
                    end
                    if dist <= reach + 5 and spd >= 15 then
                        shouldHit = true
                    end
                end
                -- Height check: ball roughly near player height window
                if shouldHit then
                    local dy = math.abs(aimPos.Y - playerPos.Y)
                    if dy > 18 then shouldHit = false end
                end
                if shouldHit and dist < bestDist then
                    bestDist = dist
                    bestModel = model
                    bestBall = ball
                    bestHb = extendedHitbox
                    bestAim = aimPos
                end
            end
        end
    end

    if not bestBall then return end

    lastAutoSpikeClick = tick()

    -- 1) Official Interact path
    local used = false
    if bestModel then
        used = fireOfficialMove(loadstring(base64decode("U3Bpa2U="))(), rootPart, bestModel, bestBall, bestHb)
    end

    -- 2) Always also send mouse click as backup (more reliable in practice)
    pcall(function()
        local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
        local cx, cy = 0, 0
        if camera and bestAim then
            local sp, on = camera:WorldToScreenPoint(bestAim)
            if on then
                cx, cy = sp.X, sp.Y
            else
                -- center of screen fallback
                cx = camera.ViewportSize.X / 2
                cy = camera.ViewportSize.Y / 2
            end
        end
        VIM:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
        task.wait(0.01)
        VIM:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
    end)

    -- 3) Also try Jump remote + spike combo for silent reliability
    pcall(function()
        fireOfficialJump()
    end)

    if AnimDesyncEnabled then
        task.defer(function() pcall(function() stopSpikeSetTracks(LocalPlayer.Character) end) end)
    end
    tryAutoAbility()
end

local function autoJumpSet()
    if not AutoJumpSetEnabled then jumpSetPhase = 0 return end
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    if not rootPart then return end
    local humanoid = character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if not humanoid then return end
    local state = humanoid:GetState()
    local inAir = state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall
    local playerPos = rootPart.Position
    local now = tick()
    local bestDist, bestReach, bestModel, bestBall, bestHb = math.huge, 4, nil, nil, nil
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) and v:IsA(loadstring(base64decode("TW9kZWw="))()) then
            local hb = v:FindFirstChild(loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))())
            local ball = v:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))())
            local target = hb or ball
            if target then
                local d = (playerPos - target.Position).Magnitude
                local reach = hb and (2 + hb.Size.X / 2) or 4
                if d < bestDist then
                    bestDist = d
                    bestReach = reach
                    bestModel = v
                    bestBall = ball
                    bestHb = hb
                end
            end
        end
    end
    if bestDist == math.huge then
        if now - jumpSetPhaseTime > 1.2 then jumpSetPhase = 0 end
        return
    end
    if jumpSetPhase > 0 and now - jumpSetPhaseTime > 2 then jumpSetPhase = 0 end
    if jumpSetPhase == 0 and not inAir then
        if bestDist <= bestReach + 1.5 and now - lastAutoJumpSetPress > 0.5 then
            lastAutoJumpSetPress = now
            jumpSetPhase = 1
            jumpSetPhaseTime = now
            fireOfficialJump()
            local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            wait(0.04)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end
        return
    end
    if jumpSetPhase == 1 then
        if inAir and bestDist <= bestReach + 2.5 then
            local used = fireOfficialMove(loadstring(base64decode("SnVtcFNldA=="))(), rootPart, bestModel, bestBall, bestHb)
            if not used then used = fireOfficialMove(loadstring(base64decode("U2V0"))(), rootPart, bestModel, bestBall, bestHb) end
            if not used then
                local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
                VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                wait(0.03)
                VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            end
            if AnimDesyncEnabled then
                task.defer(function() pcall(function() stopSpikeSetTracks(LocalPlayer.Character) end) end)
            end
            jumpSetPhase = 0
            jumpSetPhaseTime = now
        elseif now - jumpSetPhaseTime > 0.85 then
            jumpSetPhase = 0
        end
    end
end

-- ═══════════════════════════════════════
-- AUTO RECEIVE (TOUCH-BASED + POLLING)
-- ═══════════════════════════════════════
local autoReceiveConnections = {}
local autoReceiveActive = false

local function disconnectAutoReceive()
    for _, conn in pairs(autoReceiveConnections) do
        pcall(function() conn:Disconnect() end)
    end
    autoReceiveConnections = {}
    autoReceiveActive = false
end

local function fireReceiveAction(ballModel, ballPart, hitbox)
    if tick() - lastAutoReceivePress < 0.05 then return end
    lastAutoReceivePress = tick()
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    if not rootPart then return end
    -- Face the hitbox / ball
    pcall(function()
        local aim = (hitbox and hitbox.Position) or ballPart.Position
        local flat = Vector3.new(aim.X - rootPart.Position.X, 0, aim.Z - rootPart.Position.Z)
        if flat.Magnitude > 0.12 then
            rootPart.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + flat.Unit)
        end
    end)
    -- Prefer ExtendedHitbox in official path
    local used = fireOfficialMove(loadstring(base64decode("U2V0"))(), rootPart, ballModel, ballPart, hitbox)
    if not used then used = fireOfficialMove(loadstring(base64decode("QnVtcA=="))(), rootPart, ballModel, ballPart, hitbox) end
    if not used then used = fireOfficialMove(loadstring(base64decode("UmVjZWl2ZQ=="))(), rootPart, ballModel, ballPart, hitbox) end
    if not used then
        local VIM = game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))())
        VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
        task.wait(0.03)
        VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    end
    tryAutoAbility()
    if AnimDesyncEnabled then
        task.defer(function() pcall(function() stopSpikeSetTracks(LocalPlayer.Character) end) end)
    end
end

local function scanAndBindBallTouch()
    if not AutoReceiveEnabled then return end
    disconnectAutoReceive()
    autoReceiveActive = true
    local character = LocalPlayer.Character
    if not character then return end
    local characterParts = {}
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then table.insert(characterParts, part) end
    end
    if #characterParts == 0 then return end
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) and v:IsA(loadstring(base64decode("TW9kZWw="))()) then
            local ball = v:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))())
            if ball then
                local hitbox = v:FindFirstChild(loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))())
                local target = hitbox or ball
                local conn = target.Touched:Connect(function(hit)
                    if not AutoReceiveEnabled then return end
                    if tick() - lastAutoReceivePress < 0.08 then return end
                    local ourChar = LocalPlayer.Character
                    if not ourChar then return end
                    local isOurPart = false
                    for _, cp in pairs(characterParts) do
                        if cp == hit or hit:IsDescendantOf(ourChar) then
                            isOurPart = true
                            break
                        end
                    end
                    if isOurPart then
                        fireReceiveAction(v, ball, hitbox)
                    end
                end)
                table.insert(autoReceiveConnections, conn)
            end
        end
    end
    for _, part in pairs(characterParts) do
        local conn = part.Touched:Connect(function(hit)
            if not AutoReceiveEnabled then return end
            if tick() - lastAutoReceivePress < 0.08 then return end
            local ballModel = hit and hit:FindFirstAncestorWhichIsA(loadstring(base64decode("TW9kZWw="))())
            if ballModel and ballModel.Name:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) then
                local ball = ballModel:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))())
                local hb = ballModel:FindFirstChild(loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))())
                if ball then fireReceiveAction(ballModel, ball, hb) end
            end
        end)
        table.insert(autoReceiveConnections, conn)
    end
end

local function autoReceivePolling()
    if not AutoReceiveEnabled then return end
    if tick() - lastAutoReceivePress < 0.05 then return end
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    if not rootPart then return end
    local humanoid = character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if not humanoid then return end
    local state = humanoid:GetState()
    -- Receive is ground-based; skip only pure jump apex if needed
    local playerPos = rootPart.Position
    local bestDist, bestModel, bestBall, bestHb = math.huge, nil, nil, nil

    for _, v in pairs(workspace:GetChildren()) do
        local name = tostring(v.Name or loadstring(base64decode(""))())
        if (name:find(loadstring(base64decode("Q0xJRU5UX0JBTEw="))()) or name:find(loadstring(base64decode("QmFsbA=="))()) or name:find(loadstring(base64decode("QkFMTA=="))())) and (v:IsA(loadstring(base64decode("TW9kZWw="))()) or v:IsA(loadstring(base64decode("QmFzZVBhcnQ="))())) then
            local ball, model = nil, nil
            if v:IsA(loadstring(base64decode("TW9kZWw="))()) then
                model = v
                ball = v:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))())
            else
                ball = v
                model = v
            end
            if ball then
                local hb = model:IsA(loadstring(base64decode("TW9kZWw="))()) and model:FindFirstChild(loadstring(base64decode("RXh0ZW5kZWRIaXRib3g="))()) or nil
                local aimPart = hb or ball
                local aimPos = aimPart.Position
                local hbRadius = 3
                if hb and hb:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
                    hbRadius = math.max(hb.Size.X, hb.Size.Y, hb.Size.Z) * 0.5
                elseif HitboxEnabled and HitboxSize and HitboxSize > 0 then
                    hbRadius = math.max(HitboxSize * 0.5, 3)
                end
                local reach = 2.8 + hbRadius + 1.5
                local dist = (playerPos - aimPos).Magnitude
                local dy = math.abs(aimPos.Y - playerPos.Y)
                -- Prefer balls near body height for receive
                if dist <= reach and dy < 12 and dist < bestDist then
                    bestDist = dist
                    bestModel = model
                    bestBall = ball
                    bestHb = hb
                end
            end
        end
    end
    if bestModel and bestBall then
        fireReceiveAction(bestModel, bestBall, bestHb)
    end
end

local function refreshAutoReceiveBinding()
    if AutoReceiveEnabled then
        task.defer(scanAndBindBallTouch)
    else
        disconnectAutoReceive()
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    if AutoReceiveEnabled then
        task.defer(function() task.wait(1) scanAndBindBallTouch() end)
    end
end)

spawn(function()
    while true do
        if AutoReceiveEnabled then pcall(autoReceivePolling) end
        task.wait(0.03)
    end
end)

local function hidePlayerName(p)
    if not p then return end
    local char = p.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if hum then
        if streamerOriginalDisplay[p] == nil then
            streamerOriginalDisplay[p] = {
                NameDisplayDistance = hum.NameDisplayDistance,
                DisplayDistanceType = hum.DisplayDistanceType,
            }
        end
        pcall(function()
            hum.NameDisplayDistance = 0
            hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        end)
    end
    for _, obj in pairs(char:GetDescendants()) do
        if obj:IsA(loadstring(base64decode("QmlsbGJvYXJkR3Vp"))()) or obj:IsA(loadstring(base64decode("U3VyZmFjZUd1aQ=="))()) then
            local n = (obj.Name or loadstring(base64decode(""))()):lower()
            if n:find(loadstring(base64decode("bmFtZQ=="))()) or n:find(loadstring(base64decode("dGFn"))()) or n:find(loadstring(base64decode("b3ZlcmhlYWQ="))()) or n:find(loadstring(base64decode("cmFuaw=="))()) then
                obj.Enabled = false
            end
        end
    end
end

local function restorePlayerName(p)
    if not p then return end
    local data = streamerOriginalDisplay[p]
    local char = p.Character
    if char and data then
        local hum = char:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
        if hum then
            pcall(function()
                hum.NameDisplayDistance = data.NameDisplayDistance or 100
                hum.DisplayDistanceType = data.DisplayDistanceType or Enum.HumanoidDisplayDistanceType.Viewer
            end)
        end
        for _, obj in pairs(char:GetDescendants()) do
            if obj:IsA(loadstring(base64decode("QmlsbGJvYXJkR3Vp"))()) or obj:IsA(loadstring(base64decode("U3VyZmFjZUd1aQ=="))()) then
                local n = (obj.Name or loadstring(base64decode(""))()):lower()
                if n:find(loadstring(base64decode("bmFtZQ=="))()) or n:find(loadstring(base64decode("dGFn"))()) or n:find(loadstring(base64decode("b3ZlcmhlYWQ="))()) or n:find(loadstring(base64decode("cmFuaw=="))()) then
                    obj.Enabled = true
                end
            end
        end
    end
    streamerOriginalDisplay[p] = nil
end

local function applyStreamerMode()
    for _, p in pairs(Players:GetPlayers()) do hidePlayerName(p) end
end
local function disableStreamerMode()
    for _, p in pairs(Players:GetPlayers()) do restorePlayerName(p) end
    streamerOriginalDisplay = {}
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        if StreamerModeEnabled then task.defer(function() hidePlayerName(p) end) end
    end)
end)
for _, p in pairs(Players:GetPlayers()) do
    p.CharacterAdded:Connect(function()
        if StreamerModeEnabled then task.defer(function() hidePlayerName(p) end) end
    end)
end
spawn(function()
    while true do
        if StreamerModeEnabled then pcall(applyStreamerMode) end
        wait(1.5)
    end
end)

local function isInLobby()
    local teamSelectionUI = LocalPlayer.PlayerGui:FindFirstChild(loadstring(base64decode("SW50ZXJmYWNl"))())
    if teamSelectionUI then
        local teamSelection = teamSelectionUI:FindFirstChild(loadstring(base64decode("VGVhbVNlbGVjdGlvbg=="))())
        if teamSelection and teamSelection.Visible then return true end
    end
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if not humanoid or humanoid.Health <= 0 then return true end
    return false
end

RunService.RenderStepped:Connect(function()
    -- Always build ExtendedHitbox when combat features need it
    if HitboxEnabled or AutoSpikeEnabled or AutoReceiveEnabled or AutoSetEnabled or AutoJumpSetEnabled or SilentSpikeEnabled then
        pcall(function()
            -- Ensure a usable size even if slider is 0
            local saved = HitboxSize
            if (not HitboxSize or HitboxSize < 4) and (AutoSpikeEnabled or AutoReceiveEnabled) then
                HitboxSize = 10
            end
            modifyBallHitbox()
            HitboxSize = saved
        end)
    end
    if JumpESPEnabled then
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if isEnemy(player) then
                    if isJumping(player) then
                        if not JumpESPObjects[player] then
                            createJumpESP(player)
                        else
                            JumpESPObjects[player].FillColor = JumpESPColor
                            JumpESPObjects[player].OutlineColor = JumpESPColor
                        end
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
                    if not PredictAimObjects[player] then
                        createPredictLine(player)
                    else
                        updatePredictLine(player)
                    end
                end
            end
        end)
    end
    if AutoStrongServeEnabled then pcall(function() autoStrongServe() end) end
    if AutoSpikeEnabled then pcall(function() autoSpike() end) end
end)

Players.PlayerRemoving:Connect(function(player)
    removeJumpESP(player)
    removePredictLine(player)
end)

-- ═══════════════════════════════════════
-- OBSIDIAN UI
-- ═══════════════════════════════════════
local Window = Library:CreateWindow({
    Title = ScriptName,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = false,
    UnlockMouseWhileOpen = true,
    NotifySide = loadstring(base64decode("TGVmdA=="))(),
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab(loadstring(base64decode("TWFpbg=="))(), loadstring(base64decode("YWN0aXZpdHk="))()),
    Boost = Window:AddTab(loadstring(base64decode("Qm9vc3Q="))(), loadstring(base64decode("emFw"))()),
    Spins = Window:AddTab(loadstring(base64decode("U3BpbnM="))(), loadstring(base64decode("c3Rhcg=="))()),
    Settings = Window:AddTab(loadstring(base64decode("U2V0dGluZ3M="))(), loadstring(base64decode("c2V0dGluZ3M="))()),
}

local MainLeft = Tabs.Main:AddLeftGroupbox(loadstring(base64decode("RmVhdHVyZXM="))(), loadstring(base64decode("Ym94"))())
local MainRight = Tabs.Main:AddRightGroupbox(loadstring(base64decode("VmlzdWFsIEZlYXR1cmVz"))(), loadstring(base64decode("ZXll"))())
local BoostLeft = Tabs.Boost:AddLeftGroupbox(loadstring(base64decode("SnVtcA=="))(), loadstring(base64decode("YXJyb3ctdXA="))())
local BoostRight = Tabs.Boost:AddRightGroupbox(loadstring(base64decode("U3Bpa2U="))(), loadstring(base64decode("c3dvcmQ="))())
local SpinsBox = Tabs.Spins:AddLeftGroupbox(loadstring(base64decode("THVja3kgU3BpbnM="))(), loadstring(base64decode("c3Rhcg=="))())
local SettingsLeft = Tabs.Settings:AddLeftGroupbox(loadstring(base64decode("SW5mb3JtYXRpb24="))(), loadstring(base64decode("aW5mbw=="))())
local SettingsRight = Tabs.Settings:AddRightGroupbox(loadstring(base64decode("VUkgU2V0dGluZ3M="))(), loadstring(base64decode("c2V0dGluZ3M="))())

BoostLeft:AddToggle(loadstring(base64decode("SnVtcEJvb3N0VG9nZ2xl"))(), {
    Text = loadstring(base64decode("SnVtcCBCb29zdA=="))(),
    Default = false,
    Tooltip = loadstring(base64decode("UmFpc2VzIEp1bXBIZWlnaHQgLyBKdW1wUG93ZXI="))(),
    Callback = function(Value)
        JumpBoostEnabled = Value
        if Value then pcall(applyJumpBoost) end
        notify(Value and loadstring(base64decode("SnVtcCBCb29zdCBPTg=="))() or loadstring(base64decode("SnVtcCBCb29zdCBPRkY="))(), 5)
    end
})
BoostLeft:AddSlider(loadstring(base64decode("SnVtcEJvb3N0U2xpZGVy"))(), {
    Text = loadstring(base64decode("SnVtcCBNdWx0aXBsaWVy"))(),
    Default = 1.35,
    Min = 1,
    Max = 2,
    Rounding = 2,
    Suffix = loadstring(base64decode("eA=="))(),
    Callback = function(Value)
        JumpBoostMult = Value
        if JumpBoostEnabled then pcall(applyJumpBoost) end
    end
})
BoostRight:AddToggle(loadstring(base64decode("U3Bpa2VCb29zdFRvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("U3Bpa2UgQm9vc3Q="))(),
    Default = false,
    Tooltip = loadstring(base64decode("Qm9vc3QgQ2hhcmdlIG9ubHkgd2hlbiBBY3Rpb24gaXMgU3Bpa2U="))(),
    Callback = function(Value)
        SpikeBoostEnabled = Value
        notify(Value and loadstring(base64decode("U3Bpa2UgQm9vc3QgT04="))() or loadstring(base64decode("U3Bpa2UgQm9vc3QgT0ZG"))(), 5)
    end
})
BoostRight:AddSlider(loadstring(base64decode("U3Bpa2VCb29zdFNsaWRlcg=="))(), {
    Text = loadstring(base64decode("U3Bpa2UgQ2hhcmdl"))(),
    Default = 1,
    Min = 0.5,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        SpikeBoostCharge = Value
    end
})

SpinsBox:AddToggle(loadstring(base64decode("SW5mU3BpbnNUb2dnbGU="))(), {
    Text = loadstring(base64decode("SW5mIFN0eWxlIFNwaW5z"))(),
    Default = false,
    Tooltip = loadstring(base64decode("UmFua3MgQnJvbnplMi9Hb2xkMi9EaWFtb25kMyDigJQgTHVja3kgU3R5bGUgU3BpbnM="))(),
    Callback = function(Value)
        InfSpinsEnabled = Value
        if Value and not rankedRewardRemote then rankedRewardRemote = getRankedRewardRemote() end
        notify(Value and loadstring(base64decode("SW5mIFN0eWxlIFNwaW5zIE9O"))() or loadstring(base64decode("SW5mIFN0eWxlIFNwaW5zIE9GRg=="))(), 5)
    end
})
SpinsBox:AddToggle(loadstring(base64decode("SW5mWWVuc1RvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("SW5mIFllbnM="))(),
    Default = false,
    Tooltip = loadstring(base64decode("UmFua3MgQnJvbnplMy9EaWFtb25kMiDigJQgWWVuIChDdXJyZW5jeSk="))(),
    Callback = function(Value)
        InfYensEnabled = Value
        if Value and not rankedRewardRemote then rankedRewardRemote = getRankedRewardRemote() end
        notify(Value and loadstring(base64decode("SW5mIFllbnMgT04="))() or loadstring(base64decode("SW5mIFllbnMgT0ZG"))(), 5)
    end
})
SpinsBox:AddToggle(loadstring(base64decode("SW5mQWJpbGl0aWVzVG9nZ2xl"))(), {
    Text = loadstring(base64decode("SW5mIEFiaWxpdHkgU3BpbnM="))(),
    Default = false,
    Tooltip = loadstring(base64decode("UmFua3MgU2lsdmVyMi9Hb2xkMyDigJQgTHVja3kgQWJpbGl0eSBTcGlucw=="))(),
    Callback = function(Value)
        InfAbilitiesEnabled = Value
        if Value and not rankedRewardRemote then rankedRewardRemote = getRankedRewardRemote() end
        notify(Value and loadstring(base64decode("SW5mIEFiaWxpdHkgU3BpbnMgT04="))() or loadstring(base64decode("SW5mIEFiaWxpdHkgU3BpbnMgT0ZG"))(), 5)
    end
})
SpinsBox:AddToggle(loadstring(base64decode("SW5mR2Vtc1RvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("SW5mIEdlbXM="))(),
    Default = false,
    Tooltip = loadstring(base64decode("UHJvLi5VbHRpbWF0ZSByYW5rZWQgKyBTZWFzb25QYXNzIGdlbSB0aWVycyArIGFsbCByZXdhcmRz"))(),
    Callback = function(Value)
        InfGemsEnabled = Value
        if Value and not rankedRewardRemote then rankedRewardRemote = getRankedRewardRemote() end
        notify(Value and loadstring(base64decode("SW5mIEdlbXMgT04="))() or loadstring(base64decode("SW5mIEdlbXMgT0ZG"))(), 5)
    end
})
SpinsBox:AddToggle(loadstring(base64decode("U2tpcFNwaW5Ub2dnbGU="))(), {
    Text = loadstring(base64decode("U2tpcCBTcGlu"))(),
    Default = false,
    Tooltip = loadstring(base64decode("RmluaXNoIGx1Y2t5IHJvbGwgZnJlZSB2aWEgU2VsZWN0Q2hhbmNlIChuZXZlciBtYXN0ZXJ5IFJvYnV4IHNraXAp"))(),
    Callback = function(Value)
        SkipSpinEnabled = Value
        notify(Value and loadstring(base64decode("U2tpcCBTcGluIE9O"))() or loadstring(base64decode("U2tpcCBTcGluIE9GRg=="))(), 5)
    end
})

SpinsBox:AddDivider()
SpinsBox:AddLabel(loadstring(base64decode("QXV0byBTcGluIFN5c3RlbQ=="))())

SpinsBox:AddToggle(loadstring(base64decode("QXV0b1NwaW5Ub2dnbGU="))(), {
    Text = loadstring(base64decode("QXV0byBTcGlu"))(),
    Default = false,
    Tooltip = loadstring(base64decode("QXV0byByb2xsIFN0eWxlL0FiaWxpdHkgd2l0aCBzdG9wIGNvbmRpdGlvbnM="))(),
    Callback = function(Value)
        AutoSpinEnabled = Value
        if Value then cacheSpinRemotes() end
        notify(Value and loadstring(base64decode("QXV0byBTcGluIE9O"))() or loadstring(base64decode("QXV0byBTcGluIE9GRg=="))(), 5)
    end
})

SpinsBox:AddDropdown(loadstring(base64decode("QXV0b1NwaW5UeXBlRHJvcA=="))(), {
    Text = loadstring(base64decode("U3BpbiBUeXBl"))(),
    Values = {loadstring(base64decode("U3R5bGU="))(), loadstring(base64decode("QWJpbGl0eQ=="))()},
    Default = loadstring(base64decode("U3R5bGU="))(),
    Callback = function(Value)
        AutoSpinType = Value
        notify(loadstring(base64decode("U3BpbiBUeXBlOiA="))() .. Value, 3)
    end
})

SpinsBox:AddSlider(loadstring(base64decode("QXV0b1NwaW5TbG90U2xpZGVy"))(), {
    Text = loadstring(base64decode("U2xvdA=="))(),
    Default = 1,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Callback = function(Value)
        AutoSpinSlot = Value
    end
})

SpinsBox:AddToggle(loadstring(base64decode("QXV0b1NwaW5TdG9wVGFyZ2V0"))(), {
    Text = loadstring(base64decode("U3RvcCBPbiBUYXJnZXQgTmFtZQ=="))(),
    Default = true,
    Tooltip = loadstring(base64decode("U3RvcHMgd2hlbiB0YXJnZXQgbmFtZSBpcyBkZXRlY3RlZCBpbiBVSQ=="))(),
    Callback = function(Value)
        AutoSpinStopOnTarget = Value
    end
})

SpinsBox:AddDropdown(loadstring(base64decode("QXV0b1NwaW5TdG9wUmFyaXR5RHJvcA=="))(), {
    Text = loadstring(base64decode("U3RvcCBPbiBSYXJpdHk="))(),
    Values = {loadstring(base64decode("Tm9uZQ=="))(), loadstring(base64decode("U2VjcmV0"))(), loadstring(base64decode("R29kbHk="))(), loadstring(base64decode("TGVnZW5kYXJ5"))(), loadstring(base64decode("VWx0cmE="))(), loadstring(base64decode("RXZv"))()},
    Default = loadstring(base64decode("Tm9uZQ=="))(),
    Callback = function(Value)
        if Value == loadstring(base64decode("Tm9uZQ=="))() then
            AutoSpinStopOnRarity = loadstring(base64decode(""))()
        else
            AutoSpinStopOnRarity = Value
        end
    end
})

SpinsBox:AddToggle(loadstring(base64decode("QXV0b1NwaW5MdWNreVRvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("VXNlIEx1Y2t5IFNwaW4="))(),
    Default = true,
    Callback = function(Value)
        AutoSpinUseLucky = Value
    end
})

SpinsBox:AddSlider(loadstring(base64decode("QXV0b1NwaW5TcGVlZFNsaWRlcg=="))(), {
    Text = loadstring(base64decode("U3BpbiBTcGVlZA=="))(),
    Default = 0.35,
    Min = 0.15,
    Max = 1.5,
    Rounding = 2,
    Suffix = loadstring(base64decode("cw=="))(),
    Callback = function(Value)
        AutoSpinSpeed = Value
    end
})

-- Set target via notify helper (Obsidian may lack text input on some forks)
SpinsBox:AddButton({
    Text = loadstring(base64decode("U2V0IFRhcmdldDogQ2xlYXI="))(),
    Func = function()
        AutoSpinTargetName = loadstring(base64decode(""))()
        notify(loadstring(base64decode("VGFyZ2V0IGNsZWFyZWQgKGFueSk="))(), 3)
    end,
    Tooltip = loadstring(base64decode("Q2xlYXIgdGFyZ2V0IG5hbWU="))()
})
SpinsBox:AddButton({
    Text = loadstring(base64decode("VGFyZ2V0OiBIaWRhcmk="))(),
    Func = function()
        AutoSpinTargetName = loadstring(base64decode("SGlkYXJp"))()
        notify(loadstring(base64decode("VGFyZ2V0ID0gSGlkYXJp"))(), 3)
    end
})
SpinsBox:AddButton({
    Text = loadstring(base64decode("VGFyZ2V0OiBUaW1lc2tpcCBIaW50bw=="))(),
    Func = function()
        AutoSpinTargetName = loadstring(base64decode("VGltZXNraXAgSGludG8="))()
        notify(loadstring(base64decode("VGFyZ2V0ID0gVGltZXNraXAgSGludG8="))(), 3)
    end
})
SpinsBox:AddButton({
    Text = loadstring(base64decode("VGFyZ2V0OiBTaGllbGQgQnJlYWtlcg=="))(),
    Func = function()
        AutoSpinTargetName = loadstring(base64decode("U2hpZWxkIEJyZWFrZXI="))()
        notify(loadstring(base64decode("VGFyZ2V0ID0gU2hpZWxkIEJyZWFrZXI="))(), 3)
    end
})
SpinsBox:AddButton({
    Text = loadstring(base64decode("VGFyZ2V0OiBDdXJ2ZSBTcGlrZQ=="))(),
    Func = function()
        AutoSpinTargetName = loadstring(base64decode("Q3VydmUgU3Bpa2U="))()
        notify(loadstring(base64decode("VGFyZ2V0ID0gQ3VydmUgU3Bpa2U="))(), 3)
    end
})
SpinsBox:AddButton({
    Text = loadstring(base64decode("VGFyZ2V0OiBMZWFkIEZlZXQ="))(),
    Func = function()
        AutoSpinTargetName = loadstring(base64decode("TGVhZCBGZWV0"))()
        AutoSpinType = loadstring(base64decode("QWJpbGl0eQ=="))()
        notify(loadstring(base64decode("VGFyZ2V0ID0gTGVhZCBGZWV0IChBYmlsaXR5KQ=="))(), 3)
    end
})
SpinsBox:AddButton({
    Text = loadstring(base64decode("VGFyZ2V0OiBNYWduZXRpYyBQdWxs"))(),
    Func = function()
        AutoSpinTargetName = loadstring(base64decode("TWFnbmV0aWMgUHVsbA=="))()
        AutoSpinType = loadstring(base64decode("QWJpbGl0eQ=="))()
        notify(loadstring(base64decode("VGFyZ2V0ID0gTWFnbmV0aWMgUHVsbCAoQWJpbGl0eSk="))(), 3)
    end
})
SpinsBox:AddButton({
    Text = loadstring(base64decode("VGFyZ2V0OiBTaGllbGQgQnJlYWtlcg=="))(),
    Func = function()
        AutoSpinTargetName = loadstring(base64decode("U2hpZWxkIEJyZWFrZXI="))()
        AutoSpinType = loadstring(base64decode("QWJpbGl0eQ=="))()
        notify(loadstring(base64decode("VGFyZ2V0ID0gU2hpZWxkIEJyZWFrZXIgKEFiaWxpdHkp"))(), 3)
    end
})

MainLeft:AddToggle(loadstring(base64decode("SGl0Ym94VG9nZ2xl"))(), {
    Text = loadstring(base64decode("RW5hYmxlIEJhbGwgSGl0Ym94"))(),
    Default = HitboxEnabled,
    Tooltip = loadstring(base64decode("RXhwYW5kIHRoZSBiYWxsIGhpdGJveCBmb3IgZWFzaWVyIGhpdHRpbmc="))(),
    Callback = function(Value)
        HitboxEnabled = Value
        if HitboxEnabled then notify(loadstring(base64decode("SGl0Ym94IEVuYWJsZWQ="))(), 10)
        else removeHitboxes() notify(loadstring(base64decode("SGl0Ym94IERpc2FibGVk"))(), 10) end
    end
})
MainLeft:AddSlider(loadstring(base64decode("SGl0Ym94U2l6ZQ=="))(), {
    Text = loadstring(base64decode("SGl0Ym94IFNpemU="))(),
    Default = 10,
    Min = 0,
    Max = 20,
    Rounding = 0,
    Suffix = loadstring(base64decode("IHN0dWRz"))(),
    Callback = function(Value) HitboxSize = Value end
})
MainLeft:AddLabel(loadstring(base64decode("SGl0Ym94IENvbG9y"))()):AddColorPicker(loadstring(base64decode("SGl0Ym94Q29sb3I="))(), {
    Default = HitboxColor,
    Title = loadstring(base64decode("SGl0Ym94IENvbG9y"))(),
    Callback = function(Value) HitboxColor = Value end
})
MainLeft:AddSlider(loadstring(base64decode("SGl0Ym94VHJhbnNwYXJlbmN5"))(), {
    Text = loadstring(base64decode("SGl0Ym94IFRyYW5zcGFyZW5jeQ=="))(),
    Default = 80,
    Min = 40,
    Max = 95,
    Rounding = 0,
    Suffix = loadstring(base64decode("JQ=="))(),
    Callback = function(Value) HitboxTransparency = Value / 100 end
})

MainLeft:AddDivider()
MainLeft:AddToggle(loadstring(base64decode("QXV0b1N0cm9uZ1NlcnZlVG9nZ2xl"))(), {
    Text = loadstring(base64decode("QXV0byBTdHJvbmcgU2VydmUgKFVJIEJhc2VkKQ=="))(),
    Default = AutoStrongServeEnabled,
    Tooltip = loadstring(base64decode("QXV0by1oaXQgdGhlIHB1cnBsZSB6b25lIGZvciBzdHJvbmcgc2VydmVz"))(),
    Callback = function(Value)
        AutoStrongServeEnabled = Value
        notify(Value and loadstring(base64decode("QXV0byBTdHJvbmcgU2VydmUgRW5hYmxlZA=="))() or loadstring(base64decode("QXV0byBTdHJvbmcgU2VydmUgRGlzYWJsZWQ="))(), 10)
    end
})
MainLeft:AddToggle(loadstring(base64decode("QXV0b1N0cm9uZ1NlcnZlRXZlcnlTZXJ2ZVRvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("QXV0byBTdHJvbmcgU2VydmU="))(),
    Default = AutoStrongServeEveryServeEnabled,
    Tooltip = loadstring(base64decode("Rm9yY2VzIG1heCBwb3dlciBib29zdCBvbiBldmVyeSBzZXJ2ZQ=="))(),
    Callback = function(Value)
        AutoStrongServeEveryServeEnabled = Value
        notify(Value and loadstring(base64decode("QXV0byBTdHJvbmcgU2VydmUgRW5hYmxlZA=="))() or loadstring(base64decode("QXV0byBTdHJvbmcgU2VydmUgRGlzYWJsZWQ="))(), 10)
    end
})
MainLeft:AddSlider(loadstring(base64decode("U2VydmVCb29zdFBvd2Vy"))(), {
    Text = loadstring(base64decode("U2VydmUgQm9vc3QgUG93ZXI="))(),
    Default = ServeBoostPower,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value) ServeBoostPower = Value end
})
MainLeft:AddToggle(loadstring(base64decode("QXV0b1NwaWtlVG9nZ2xl"))(), {
    Text = loadstring(base64decode("QXV0byBTcGlrZSArIENvdW50ZXI="))(),
    Default = AutoSpikeEnabled,
    Tooltip = loadstring(base64decode("U3Bpa2UgYW55IHNwZWVkICsgY291bnRlci4gS2V5YmluZCBzdXBwb3J0ZWQu"))(),
    Callback = function(Value)
        AutoSpikeEnabled = Value
        notify(Value and loadstring(base64decode("QXV0byBTcGlrZSBFbmFibGVk"))() or loadstring(base64decode("QXV0byBTcGlrZSBEaXNhYmxlZA=="))(), 10)
    end
}):AddKeyPicker(loadstring(base64decode("QXV0b1NwaWtlS2V5YmluZA=="))(), {
    Default = loadstring(base64decode("RQ=="))(),
    SyncToggleState = true,
    Mode = loadstring(base64decode("VG9nZ2xl"))(),
    Text = loadstring(base64decode("QXV0byBTcGlrZSBLZXk="))(),
    Callback = function() end,
    ChangedCallback = function() end
})
MainLeft:AddToggle(loadstring(base64decode("U2lsZW50U3Bpa2VUb2dnbGU="))(), {
    Text = loadstring(base64decode("U2lsZW50IFNwaWtl"))(),
    Default = false,
    Tooltip = loadstring(base64decode("S2V5YmluZDogSnVtcCByZW1vdGUgKyBTcGlrZSBuZWFyIGJhbGwgKGtlZXBzIGp1bXAgYW5pbSk="))(),
    Callback = function(Value)
        SilentSpikeEnabled = Value
        notify(Value and loadstring(base64decode("U2lsZW50IFNwaWtlIE9OIOKAlCBob2xkIGtleSBuZWFyIGJhbGw="))() or loadstring(base64decode("U2lsZW50IFNwaWtlIE9GRg=="))(), 6)
    end
}):AddKeyPicker(loadstring(base64decode("U2lsZW50U3Bpa2VLZXliaW5k"))(), {
    Default = loadstring(base64decode("Rg=="))(),
    Text = loadstring(base64decode("U2lsZW50IFNwaWtlIEtleQ=="))(),
    Mode = loadstring(base64decode("SG9sZA=="))(),
    Callback = function() end,
    ChangedCallback = function() end
})
MainLeft:AddToggle(loadstring(base64decode("QW5pbURlc3luY1RvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("QW5pbSBEZXN5bmMgKE5vIFNwaWtlL1NldCk="))(),
    Default = false,
    Tooltip = loadstring(base64decode("S2VlcHMgSnVtcCBhbmltIOKAlCBoaWRlcyBTcGlrZSAvIFNldCAvIEJ1bXAgYW5pbWF0aW9ucyBsb2NhbGx5"))(),
    Callback = function(Value)
        AnimDesyncEnabled = Value
        if Value then enableAnimDesync() notify(loadstring(base64decode("QW5pbSBEZXN5bmMgT04g4oCUIEp1bXAgc3RheXMsIFNwaWtlL1NldCBoaWRkZW4="))(), 6)
        else disableAnimDesync() notify(loadstring(base64decode("QW5pbSBEZXN5bmMgT0ZG"))(), 4) end
    end
})
MainLeft:AddToggle(loadstring(base64decode("T2ZmaWNpYWxQYXRoVG9nZ2xl"))(), {
    Text = loadstring(base64decode("T2ZmaWNpYWwgTW92ZSBQYXRo"))(),
    Default = true,
    Tooltip = loadstring(base64decode("VXNlcyBJbnRlcmFjdCByZW1vdGUgKERvTW92ZS1zdHlsZSkgZm9yIFNwaWtlL1NldCDigJQgbW9yZSBuYXR1cmFs"))(),
    Callback = function(Value)
        OfficialPathEnabled = Value
        notify(Value and loadstring(base64decode("T2ZmaWNpYWwgUGF0aCBPTg=="))() or loadstring(base64decode("T2ZmaWNpYWwgUGF0aCBPRkYgKGtleXMgb25seSk="))(), 5)
    end
})
MainLeft:AddToggle(loadstring(base64decode("UGVyZmVjdFNwaWtlQXNzaXN0VG9nZ2xl"))(), {
    Text = loadstring(base64decode("UGVyZmVjdCBTcGlrZSBBc3Npc3Q="))(),
    Default = true,
    Tooltip = loadstring(base64decode("U2FtdXJhaS1zdHlsZTogbWF4IENoYXJnZSB3aGVuIGJhbGwgaXMgZGVlcCBpbiBoaXRib3g="))(),
    Callback = function(Value)
        PerfectSpikeAssistEnabled = Value
        notify(Value and loadstring(base64decode("UGVyZmVjdCBTcGlrZSBBc3Npc3QgT04="))() or loadstring(base64decode("UGVyZmVjdCBTcGlrZSBBc3Npc3QgT0ZG"))(), 5)
    end
})
MainLeft:AddToggle(loadstring(base64decode("QXV0b0FiaWxpdHlUb2dnbGU="))(), {
    Text = loadstring(base64decode("QXV0byBBYmlsaXR5IC8gVWx0aW1hdGU="))(),
    Default = false,
    Tooltip = loadstring(base64decode("RmlyZXMgVXNlQWJpbGl0eSB3aGVuIHNwaWtpbmcgKGlmIGNoYXJnZSByZWFkeSBvbiBzZXJ2ZXIp"))(),
    Callback = function(Value)
        AutoAbilityEnabled = Value
        notify(Value and loadstring(base64decode("QXV0byBBYmlsaXR5IE9O"))() or loadstring(base64decode("QXV0byBBYmlsaXR5IE9GRg=="))(), 5)
    end
})
MainLeft:AddToggle(loadstring(base64decode("QXV0b0p1bXBTZXRUb2dnbGU="))(), {
    Text = loadstring(base64decode("QXV0byBKdW1wIFNldA=="))(),
    Default = false,
    Tooltip = loadstring(base64decode("SnVtcCArIEp1bXBTZXQgKEUpIHdpdGggaGl0Ym94IHJlYWNo"))(),
    Callback = function(Value)
        AutoJumpSetEnabled = Value
        jumpSetPhase = 0
        notify(Value and loadstring(base64decode("QXV0byBKdW1wIFNldCBPTg=="))() or loadstring(base64decode("QXV0byBKdW1wIFNldCBPRkY="))(), 10)
    end
}):AddKeyPicker(loadstring(base64decode("QXV0b0p1bXBTZXRLZXliaW5k"))(), {
    Default = loadstring(base64decode("Vg=="))(),
    SyncToggleState = true,
    Mode = loadstring(base64decode("VG9nZ2xl"))(),
    Text = loadstring(base64decode("SnVtcCBTZXQgS2V5"))(),
    Callback = function() end,
    ChangedCallback = function() end
})
MainLeft:AddToggle(loadstring(base64decode("QXV0b1JlY2VpdmVUb2dnbGU="))(), {
    Text = loadstring(base64decode("QXV0byBSZWNlaXZlIChUb3VjaCk="))(),
    Default = false,
    Tooltip = loadstring(base64decode("VG91Y2gtYmFzZWQ6IGJhbGwgaGl0Ym94IHRvdWNoZXMgeW91IC0+IFNldC9CdW1wIGluc3RhbnRseS4gRHVhbCBzeXN0ZW06IC5Ub3VjaGVkICsgcG9sbGluZy4="))(),
    Callback = function(Value)
        AutoReceiveEnabled = Value
        refreshAutoReceiveBinding()
        notify(Value and loadstring(base64decode("QXV0byBSZWNlaXZlIE9OICh0b3VjaC1iYXNlZCk="))() or loadstring(base64decode("QXV0byBSZWNlaXZlIE9GRg=="))(), 6)
    end
})
MainLeft:AddToggle(loadstring(base64decode("RGlyZWN0aW9uYWxIaXRUb2dnbGU="))(), {
    Text = loadstring(base64decode("RGlyZWN0aW9uYWwgSGl0"))(),
    Default = DirectionalHitEnabled,
    Tooltip = loadstring(base64decode("UmVkaXJlY3QgaGl0cyB0byBjYW1lcmEgZGlyZWN0aW9u"))(),
    Callback = function(Value)
        DirectionalHitEnabled = Value
        notify(Value and loadstring(base64decode("RGlyZWN0aW9uYWwgSGl0IEVuYWJsZWQ="))() or loadstring(base64decode("RGlyZWN0aW9uYWwgSGl0IERpc2FibGVk"))(), 10)
    end
})
MainLeft:AddToggle(loadstring(base64decode("QWltYm90Q29ybmVyVG9nZ2xl"))(), {
    Text = loadstring(base64decode("QWltYm90IENvcm5lciAoUmFua2VkKQ=="))(),
    Default = AimbotCornerEnabled,
    Tooltip = loadstring(base64decode("T24ganVtcCwgYWltIHRvIG9wcG9zaXRlIGNvdXJ0IGNvcm5lciDigJQgd29ya3MgaW4gUmFua2VkIChkeW5hbWljIGNvcm5lcnMp"))(),
    Callback = function(Value)
        AimbotCornerEnabled = Value
        courtBounds = nil
        notify(Value and loadstring(base64decode("QWltYm90IENvcm5lciBFbmFibGVk"))() or loadstring(base64decode("QWltYm90IENvcm5lciBEaXNhYmxlZA=="))(), 10)
    end
}):AddKeyPicker(loadstring(base64decode("QWltYm90Q29ybmVyS2V5YmluZA=="))(), {
    Default = loadstring(base64decode("Qw=="))(),
    SyncToggleState = true,
    Mode = loadstring(base64decode("VG9nZ2xl"))(),
    Text = loadstring(base64decode("QWltYm90IENvcm5lciBLZXk="))(),
    Callback = function() end,
    ChangedCallback = function() end
})
MainLeft:AddDropdown(loadstring(base64decode("QWltYm90Q29ybmVyTW9kZQ=="))(), {
    Text = loadstring(base64decode("Q29ybmVyIE1vZGU="))(),
    Values = {loadstring(base64decode("TGVmdA=="))(), loadstring(base64decode("UmlnaHQ="))(), loadstring(base64decode("QXV0bw=="))()},
    Default = loadstring(base64decode("QXV0bw=="))(),
    Tooltip = loadstring(base64decode("TGVmdCAvIFJpZ2h0IGZpeGVkIGNvcm5lciwgb3IgQXV0byA9IGZhcnRoZXN0IGZyb20gbmVhcmVzdCBlbmVteQ=="))(),
    Callback = function(Value)
        AimbotCornerMode = Value
        notify(loadstring(base64decode("Q29ybmVyIE1vZGU6IA=="))() .. Value, 5)
    end
})
MainLeft:AddToggle(loadstring(base64decode("TWF4UG93ZXJTcGlrZVRvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("TWF4IFBvd2VyIFNwaWtlIChUU0gp"))(),
    Default = MaxPowerSpikeEnabled,
    Tooltip = loadstring(base64decode("V2hlbiBzdGFuZGluZyBzdGlsbCwgdGlueSBtb3ZlIGtlZXBzIFNwaWtlIE1ldGVyIGZ1bGwgKFRTSCBTdXBlciBTcGlrZSku"))(),
    Callback = function(Value)
        MaxPowerSpikeEnabled = Value
        notify(Value and loadstring(base64decode("TWF4IFBvd2VyIFNwaWtlIE9O"))() or loadstring(base64decode("TWF4IFBvd2VyIFNwaWtlIE9GRg=="))(), 10)
    end
}):AddKeyPicker(loadstring(base64decode("TWF4UG93ZXJTcGlrZUtleWJpbmQ="))(), {
    Default = loadstring(base64decode("VA=="))(),
    SyncToggleState = true,
    Mode = loadstring(base64decode("VG9nZ2xl"))(),
    Text = loadstring(base64decode("TWF4IFBvd2VyIFNwaWtlIEtleQ=="))(),
    Callback = function() end,
    ChangedCallback = function() end
})
MainLeft:AddToggle(loadstring(base64decode("Q2FtZXJhSnVtcFRvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("Q2FtZXJhIEp1bXA="))(),
    Default = CameraJumpEnabled,
    Tooltip = loadstring(base64decode("Um90YXRlIHRvIGNhbWVyYSBkaXJlY3Rpb24gd2hlbiBqdW1waW5n"))(),
    Callback = function(Value)
        CameraJumpEnabled = Value
        notify(Value and loadstring(base64decode("Q2FtZXJhIEp1bXAgRW5hYmxlZA=="))() or loadstring(base64decode("Q2FtZXJhIEp1bXAgRGlzYWJsZWQ="))(), 10)
    end
})
MainLeft:AddToggle(loadstring(base64decode("QXV0b1NldFRvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("QXV0byBTZXQ="))(),
    Default = AutoSetEnabled,
    Tooltip = loadstring(base64decode("QXV0b21hdGljYWxseSBwcmVzcyBRIHRvIHNldCB3aGVuIGJhbGwgaXMgY29taW5nIHRvd2FyZHMgeW91"))(),
    Callback = function(Value)
        AutoSetEnabled = Value
        notify(Value and loadstring(base64decode("QXV0byBTZXQgRW5hYmxlZA=="))() or loadstring(base64decode("QXV0byBTZXQgRGlzYWJsZWQ="))(), 10)
    end
})

MainLeft:AddDivider()
MainLeft:AddToggle(loadstring(base64decode("QW50aU1vZFRvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("QW50aS1Nb2RlcmF0b3IgUHJvdGVjdGlvbg=="))(),
    Default = AntiModEnabled,
    Tooltip = loadstring(base64decode("QXV0b21hdGljYWxseSBraWNrIHdoZW4gbW9kZXJhdG9ycyBqb2luIHRoZSBzZXJ2ZXI="))(),
    Callback = function(Value)
        AntiModEnabled = Value
        if AntiModEnabled then notify(loadstring(base64decode("QW50aS1Nb2QgRW5hYmxlZA=="))(), 10) checkForModerators()
        else notify(loadstring(base64decode("QW50aS1Nb2QgRGlzYWJsZWQ="))(), 10) end
    end
})
MainLeft:AddDivider()
MainLeft:AddToggle(loadstring(base64decode("U3BlZWRUb2dnbGU="))(), {
    Text = loadstring(base64decode("Q0ZyYW1lIFNwZWVk"))(),
    Default = SpeedEnabled,
    Tooltip = loadstring(base64decode("SW5jcmVhc2UgbW92ZW1lbnQgc3BlZWQgdXNpbmcgQ0ZyYW1lIG1hbmlwdWxhdGlvbg=="))(),
    Callback = function(Value)
        SpeedEnabled = Value
        notify(Value and loadstring(base64decode("U3BlZWQgRW5hYmxlZA=="))() or loadstring(base64decode("U3BlZWQgRGlzYWJsZWQ="))(), 10)
    end
})
MainLeft:AddSlider(loadstring(base64decode("U3BlZWRTbGlkZXI="))(), {
    Text = loadstring(base64decode("U3BlZWQgVmFsdWU="))(),
    Default = SpeedValue,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Suffix = loadstring(base64decode("IHNwZWVk"))(),
    Callback = function(Value) SpeedValue = Value end
})

MainRight:AddToggle(loadstring(base64decode("U3RyZWFtZXJNb2RlVG9nZ2xl"))(), {
    Text = loadstring(base64decode("U3RyZWFtZXIgTW9kZQ=="))(),
    Default = false,
    Tooltip = loadstring(base64decode("SGlkZSB1c2VybmFtZXMgZm9yIHJlY29yZGluZw=="))(),
    Callback = function(Value)
        StreamerModeEnabled = Value
        if Value then applyStreamerMode() notify(loadstring(base64decode("U3RyZWFtZXIgTW9kZSBPTg=="))(), 4)
        else disableStreamerMode() notify(loadstring(base64decode("U3RyZWFtZXIgTW9kZSBPRkY="))(), 3) end
    end
})
MainRight:AddDivider()
MainRight:AddToggle(loadstring(base64decode("SnVtcEVTUFRvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("RW5hYmxlIEp1bXAgRVNQ"))(),
    Default = JumpESPEnabled,
    Tooltip = loadstring(base64decode("SGlnaGxpZ2h0IGVuZW15IGp1bXBz"))(),
    Callback = function(Value)
        JumpESPEnabled = Value
        if JumpESPEnabled then notify(loadstring(base64decode("SnVtcCBFU1AgRW5hYmxlZA=="))(), 10)
        else clearAllJumpESP() notify(loadstring(base64decode("SnVtcCBFU1AgRGlzYWJsZWQ="))(), 10) end
    end
})
MainRight:AddLabel(loadstring(base64decode("SnVtcCBFU1AgQ29sb3I="))()):AddColorPicker(loadstring(base64decode("SnVtcEVTUENvbG9y"))(), {
    Default = JumpESPColor,
    Title = loadstring(base64decode("SnVtcCBFU1AgQ29sb3I="))(),
    Callback = function(Value) JumpESPColor = Value end
})
MainRight:AddDivider()
MainRight:AddToggle(loadstring(base64decode("UHJlZGljdEFpbVRvZ2dsZQ=="))(), {
    Text = loadstring(base64decode("RW5hYmxlIFByZWRpY3QgQWlt"))(),
    Default = PredictAimEnabled,
    Tooltip = loadstring(base64decode("U2hvdyBzcGlrZSBwcmVkaWN0aW9uIGxpbmVz"))(),
    Callback = function(Value)
        PredictAimEnabled = Value
        if PredictAimEnabled then notify(loadstring(base64decode("UHJlZGljdCBBaW0gRW5hYmxlZA=="))(), 10)
        else clearAllPredictAim() notify(loadstring(base64decode("UHJlZGljdCBBaW0gRGlzYWJsZWQ="))(), 10) end
    end
})
MainRight:AddSlider(loadstring(base64decode("UHJlZGljdEFpbUxlbmd0aA=="))(), {
    Text = loadstring(base64decode("UHJlZGljdGlvbiBMZW5ndGg="))(),
    Default = PredictAimLength,
    Min = 0,
    Max = 50,
    Rounding = 0,
    Suffix = loadstring(base64decode("IHN0dWRz"))(),
    Callback = function(Value) PredictAimLength = Value end
})
MainRight:AddLabel(loadstring(base64decode("UHJlZGljdCBBaW0gQ29sb3I="))()):AddColorPicker(loadstring(base64decode("UHJlZGljdEFpbUNvbG9y"))(), {
    Default = PredictAimColor,
    Title = loadstring(base64decode("UHJlZGljdCBBaW0gQ29sb3I="))(),
    Callback = function(Value) PredictAimColor = Value end
})

SettingsLeft:AddLabel(ScriptName .. loadstring(base64decode("IHY="))() .. ScriptVersion)
SettingsLeft:AddLabel(loadstring(base64decode("TGFzdCBVcGRhdGVkOiA="))() .. LastUpdated)
SettingsLeft:AddDivider()
SettingsLeft:AddLabel(loadstring(base64decode(""))())
SettingsLeft:AddLabel(loadstring(base64decode("QXV0aG9yOiBaYWtp"))())
SettingsLeft:AddLabel(loadstring(base64decode("VGhhbmsgeW91IGZvciB1c2luZyBLaW5ncyBIdWIh"))())
SettingsLeft:AddDivider()
SettingsLeft:AddLabel(loadstring(base64decode("Q3JlZGl0cw=="))())
SettingsLeft:AddLabel(loadstring(base64decode("QXV0aG9yOiBaYWtp"))())
SettingsLeft:AddLabel(loadstring(base64decode("VUkgTGlicmFyeTogT2JzaWRpYW4="))())
SettingsLeft:AddLabel(loadstring(base64decode("TW9yZSBmZWF0dXJlcyBjb21pbmcgc29vbiE="))())

SettingsRight:AddLabel(loadstring(base64decode("TWVudSBiaW5k"))())
    :AddKeyPicker(loadstring(base64decode("TWVudUtleWJpbmQ="))(), { Default = loadstring(base64decode("UmlnaHRTaGlmdA=="))(), NoUI = true, Text = loadstring(base64decode("TWVudSBrZXliaW5k"))() })
SettingsRight:AddButton({
    Text = loadstring(base64decode("VW5sb2FkIFNjcmlwdA=="))(),
    Func = function()
        notify(loadstring(base64decode("VW5sb2FkaW5n"))(), 3)
        getgenv().KingsHubLoaded = false
        AutoFarmEnabled = false
        autoClicking = false
    end,
    Tooltip = loadstring(base64decode("VW5sb2FkIHRoZSBlbnRpcmUgc2NyaXB0"))()
})
SettingsRight:AddButton({
    Text = loadstring(base64decode("Q29weSBEaXNjb3JkIEludml0ZQ=="))(),
    Func = function()
        setclipboard(loadstring(base64decode("aHR0cHM6Ly9kaXNjb3JkLmdnL0tWclpDNUJBYUY="))())
        notify(loadstring(base64decode("Q29waWVk"))(), 3)
    end,
    Tooltip = loadstring(base64decode("Q29weSBkaXNjb3JkIGludml0ZSBsaW5r"))()
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder(loadstring(base64decode("S2luZ3NIdWI="))())
ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:SetLibrary(Library)
SaveManager:SetFolder(loadstring(base64decode("S2luZ3NIdWI="))())
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ loadstring(base64decode("TWVudUtleWJpbmQ="))() })
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

Library:OnUnload(function()
    getgenv().KingsHubLoaded = false
    StreamerModeEnabled = false
    InfSpinsEnabled = false
    InfYensEnabled = false
    InfAbilitiesEnabled = false
    InfGemsEnabled = false
    SkipSpinEnabled = false
    AutoSpinEnabled = false
    JumpBoostEnabled = false
    SpikeBoostEnabled = false
    SilentSpikeEnabled = false
    AnimDesyncEnabled = false
    AutoReceiveEnabled = false
    AimbotCornerEnabled = false
    disconnectAutoReceive()
    pcall(disableAnimDesync)
    pcall(disableStreamerMode)
    warn(loadstring(base64decode("S2luZ3MgSHViIHVubG9hZGVk"))())
end)

spawn(function()
    while wait(0.12) do
        if Options.AutoSpikeKeybind and Toggles.AutoSpikeToggle then
            local ks = Options.AutoSpikeKeybind:GetState()
            if ks ~= AutoSpikeEnabled then
                AutoSpikeEnabled = ks
                Toggles.AutoSpikeToggle:SetValue(ks)
            end
        end
        if Options.AutoJumpSetKeybind and Toggles.AutoJumpSetToggle then
            local ks = Options.AutoJumpSetKeybind:GetState()
            if ks ~= AutoJumpSetEnabled then
                AutoJumpSetEnabled = ks
                Toggles.AutoJumpSetToggle:SetValue(ks)
                if not ks then jumpSetPhase = 0 end
            end
        end
        if Options.AimbotCornerKeybind and Toggles.AimbotCornerToggle then
            local ks = Options.AimbotCornerKeybind:GetState()
            if ks ~= AimbotCornerEnabled then
                AimbotCornerEnabled = ks
                Toggles.AimbotCornerToggle:SetValue(ks)
            end
        end
        if Options.MaxPowerSpikeKeybind and Toggles.MaxPowerSpikeToggle then
            local ks = Options.MaxPowerSpikeKeybind:GetState()
            if ks ~= MaxPowerSpikeEnabled then
                MaxPowerSpikeEnabled = ks
                Toggles.MaxPowerSpikeToggle:SetValue(ks)
            end
        end
        if SilentSpikeEnabled and Options.SilentSpikeKeybind then
            pcall(function()
                if Options.SilentSpikeKeybind:GetState() then
                    doSilentSpike()
                end
            end)
        end
    end
end)

notify(loadstring(base64decode("S2luZ3MgSHViIHY="))() .. ScriptVersion .. loadstring(base64decode("IHJlYWR5"))())
end
mQNVIHrg(vnDAc)
end)(...)
