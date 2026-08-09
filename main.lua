-- Kings Hub Loader + Key System (Obsidian Style)
-- Service: kingshub

local ServiceID = "kingshub"
local GetKeyURL = "https://ads.pandauth.com/getkey/kingshub"
local ScriptURL = "https://raw.githubusercontent.com/Kingshub-s/dfgfdgdfgdfgdfgfdg/main/vbl"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Load Panda Auth
local Pelinda = loadstring(game:HttpGet("https://api.pandauth.com/lib/external/v3.lua"))()

local function getSavedKey()
    local ok, key = pcall(function()
        return readfile("KingsHub_Key.txt")
    end)
    if ok and key and #key > 5 then
        return key:gsub("%s+", "")
    end
    return nil
end

local function saveKey(key)
    pcall(function()
        writefile("KingsHub_Key.txt", key)
    end)
end

local function loadMainScript()
    local success, err = pcall(function()
        loadstring(game:HttpGet(ScriptURL))()
    end)
    if not success then
        warn("[Kings Hub] Failed to load main script:", err)
    end
end

-- Check saved key
local savedKey = getSavedKey()
if savedKey then
    local result = Pelinda.Init({
        Service = ServiceID,
        Key = savedKey,
        SilentMode = true
    })
    if result == "validated!!" then
        print("[Kings Hub] Key validated — loading...")
        loadMainScript()
        return
    end
end

-- ====================== KEY UI ======================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KingsHubKey"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function()
    if gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = CoreGui
    end
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = CoreGui
end

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 380, 0, 240)
Main.Position = UDim2.new(0.5, -190, 0.5, -120)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(45, 45, 55)
Stroke.Thickness = 1
Stroke.Parent = Main

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 15)
TitleFix.Position = UDim2.new(0, 0, 1, -15)
TitleFix.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Kings Hub  |  Key System"
Title.TextColor3 = Color3.fromRGB(230, 230, 240)
Title.TextSize = 15
Title.Font = Enum.Font.GothamMedium
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Key Input
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -40, 0, 36)
KeyBox.Position = UDim2.new(0, 20, 0, 65)
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
KeyBox.BorderSizePixel = 0
KeyBox.Text = ""
KeyBox.PlaceholderText = "Enter your key here..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
KeyBox.TextColor3 = Color3.fromRGB(230, 230, 240)
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.Gotham
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = Main

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 7)
KeyCorner.Parent = KeyBox

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(50, 50, 65)
KeyStroke.Thickness = 1
KeyStroke.Parent = KeyBox

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -40, 0, 20)
Status.Position = UDim2.new(0, 20, 0, 110)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(255, 100, 100)
Status.TextSize = 13
Status.Font = Enum.Font.Gotham
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.Parent = Main

-- Get Key Button
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.5, -25, 0, 36)
GetKeyBtn.Position = UDim2.new(0, 20, 0, 145)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(220, 220, 235)
GetKeyBtn.TextSize = 14
GetKeyBtn.Font = Enum.Font.GothamMedium
GetKeyBtn.Parent = Main

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 7)
GetKeyCorner.Parent = GetKeyBtn

-- Submit Button
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.5, -25, 0, 36)
SubmitBtn.Position = UDim2.new(0.5, 5, 0, 145)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(70, 120, 220)
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "Submit"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.GothamMedium
SubmitBtn.Parent = Main

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 7)
SubmitCorner.Parent = SubmitBtn

-- Footer
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, -20, 0, 20)
Footer.Position = UDim2.new(0, 10, 1, -30)
Footer.BackgroundTransparency = 1
Footer.Text = "Key lasts 12 hours  •  HWID Locked"
Footer.TextColor3 = Color3.fromRGB(100, 100, 120)
Footer.TextSize = 12
Footer.Font = Enum.Font.Gotham
Footer.Parent = Main

-- Drag
local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Get Key
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(GetKeyURL)
    Status.Text = "GetKey link copied to clipboard!"
    Status.TextColor3 = Color3.fromRGB(100, 220, 140)
    task.delay(3, function()
        if Status and Status.Parent then
            Status.Text = ""
        end
    end)
end)

-- Submit
local checking = false
SubmitBtn.MouseButton1Click:Connect(function()
    if checking then return end
    local key = KeyBox.Text:gsub("%s+", "")
    if #key < 5 then
        Status.Text = "Please enter a valid key"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end

    checking = true
    Status.Text = "Checking key..."
    Status.TextColor3 = Color3.fromRGB(200, 200, 100)
    SubmitBtn.Text = "..."

    task.spawn(function()
        local result = Pelinda.Init({
            Service = ServiceID,
            Key = key,
            SilentMode = true
        })

        if result == "validated!!" then
            saveKey(key)
            Status.Text = "Key accepted! Loading script..."
            Status.TextColor3 = Color3.fromRGB(100, 220, 140)
            task.wait(0.5)
            ScreenGui:Destroy()
            loadMainScript()
        else
            Status.Text = "Invalid or expired key"
            Status.TextColor3 = Color3.fromRGB(255, 100, 100)
            SubmitBtn.Text = "Submit"
            checking = false
        end
    end)
end)
