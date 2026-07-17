local InputService = game:GetService('UserInputService')
local TextService = game:GetService('TextService')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local CoreGui = game:GetService('CoreGui')

local RenderStepped = RunService.RenderStepped
local LocalPlayer = game:GetService('Players').LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ProtectGui = protect_gui or (syn and syn.protect_gui) or function() end

local ScreenGui = Instance.new('ScreenGui')
ScreenGui.Name = 'LinoriaLibrary'
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 100
ProtectGui(ScreenGui)
ScreenGui.Parent = CoreGui

local Library = {
    Registry = {},
    RegistryMap = {},
    Unloaded = false,
    Options = {},
    Toggles = {},
    Folder = 'Linoria',
    Theme = 'Default',
    SetNotifySide = function(self, side) self.NotifySide = side end,
    NotifySide = 'Left',
    Font = Enum.Font.Code,
}

local Themes = {
    Default = {
        FontColor = Color3.fromRGB(255, 255, 255),
        MainColor = Color3.fromRGB(20, 20, 20),
        BackgroundColor = Color3.fromRGB(15, 15, 15),
        AccentColor = Color3.fromRGB(0, 150, 255),
        OutlineColor = Color3.fromRGB(35, 35, 35),
    }
}

function Library:SafeCallback(f, ...)
    if f then
        local success, err = pcall(f, ...)
        if not success then warn('Callback Error: ' .. tostring(err)) end
    end
end

function Library:AddToRegistry(inst, prop, themeProperty)
    table.insert(self.Registry, { Inst = inst, Prop = prop, ThemeProp = themeProperty })
    inst[prop] = Themes[self.Theme][themeProperty]
end

function Library:Notify(cfg)
    local title = cfg.Title or 'Notification'
    local desc = cfg.Description or ''
    local time = cfg.Time or 5

    local frame = Instance.new('Frame')
    frame.Size = UDim2.new(0, 250, 0, 60)
    frame.BackgroundColor3 = Themes[self.Theme].MainColor
    frame.BorderColor3 = Themes[self.Theme].AccentColor
    frame.Position = self.NotifySide == 'Left' and UDim2.new(0, 10, 0, 10) or UDim2.new(1, -260, 0, 10)
    frame.Parent = ScreenGui

    local ttl = Instance.new('TextLabel')
    ttl.Size = UDim2.new(1, -10, 0, 20)
    ttl.Position = UDim2.new(0, 5, 0, 5)
    ttl.Text = title
    ttl.TextColor3 = Themes[self.Theme].AccentColor
    ttl.BackgroundTransparency = 1
    ttl.Font = self.Font
    ttl.TextSize = 14
    ttl.TextXAlignment = Enum.TextXAlignment.Left
    ttl.Parent = frame

    local dsc = Instance.new('TextLabel')
    dsc.Size = UDim2.new(1, -10, 1, -25)
    dsc.Position = UDim2.new(0, 5, 0, 25)
    dsc.Text = desc
    dsc.TextColor3 = Themes[self.Theme].FontColor
    dsc.BackgroundTransparency = 1
    dsc.Font = self.Font
    dsc.TextSize = 12
    dsc.TextWrapped = true
    dsc.TextXAlignment = Enum.TextXAlignment.Left
    dsc.Parent = frame

    task.delay(time, function()
        frame:Destroy()
    end)
end

function Library:CreateWindow(cfg)
    local title = cfg.Title or 'Window'
    
    local MainFrame = Instance.new('Frame')
    MainFrame.Size = UDim2.new(0, 550, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
    MainFrame.BackgroundColor3 = Themes[self.Theme].BackgroundColor
    MainFrame.BorderColor3 = Themes[self.Theme].OutlineColor
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local TopBar = Instance.new('Frame')
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = Themes[self.Theme].MainColor
    TopBar.BorderColor3 = Themes[self.Theme].AccentColor
    TopBar.Parent = MainFrame

    local TitleLabel = Instance.new('TextLabel')
    TitleLabel.Size = UDim2.new(1, -10, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Themes[self.Theme].FontColor
    TitleLabel.Font = self.Font
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = TopBar

    local TabContainer = Instance.new('Frame')
    TabContainer.Size = UDim2.new(1, 0, 0, 25)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.BackgroundColor3 = Themes[self.Theme].MainColor
    TabContainer.BorderColor3 = Themes[self.Theme].OutlineColor
    TabContainer.Parent = MainFrame

    local TabList = Instance.new('UIListLayout')
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Parent = TabContainer

    local ContentContainer = Instance.new('Frame')
    ContentContainer.Size = UDim2.new(1, 0, 1, -55)
    ContentContainer.Position = UDim2.new(0, 0, 0, 55)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local WindowObj = { Tabs = {} }

    function WindowObj:AddTab(name, icon)
        local TabButton = Instance.new('TextButton')
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.BackgroundColor3 = Themes[Library.Theme].MainColor
        TabButton.Text = name
        TabButton.TextColor3 = Themes[Library.Theme].FontColor
        TabButton.Font = Library.Font
        TabButton.TextSize = 14
        TabButton.Parent = TabContainer

        local TabPage = Instance.new('Frame')
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.Visible = #WindowObj.Tabs == 0
        TabPage.Parent = ContentContainer

        local LeftPage = Instance.new('ScrollingFrame')
        LeftPage.Size = UDim2.new(0.5, -10, 1, -10)
        LeftPage.Position = UDim2.new(0, 5, 0, 5)
        LeftPage.BackgroundTransparency = 1
        LeftPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        LeftPage.ScrollBarWidth = 4
        LeftPage.Parent = TabPage

        local LeftList = Instance.new('UIListLayout')
        LeftList.Padding = UDim.new(0, 8)
        LeftList.Parent = LeftPage
        LeftList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            LeftPage.CanvasSize = UDim2.new(0, 0, 0, LeftList.AbsoluteContentSize.Y + 10)
        end)

        local RightPage = Instance.new('ScrollingFrame')
        RightPage.Size = UDim2.new(0.5, -10, 1, -10)
        RightPage.Position = UDim2.new(0.5, 5, 0, 5)
        RightPage.BackgroundTransparency = 1
        RightPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        RightPage.ScrollBarWidth = 4
        RightPage.Parent = TabPage

        local RightList = Instance.new('UIListLayout')
        RightList.Padding = UDim.new(0, 8)
        RightList.Parent = RightPage
        RightList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            RightPage.CanvasSize = UDim2.new(0, 0, 0, RightList.AbsoluteContentSize.Y + 10)
        end)

        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(WindowObj.Tabs) do t.Page.Visible = false end
            TabPage.Visible = true
        end)

        local TabObj = {}

        local function createGroupbox(parentFrame, title)
            local Box = Instance.new('Frame')
            Box.Size = UDim2.new(1, -5, 0, 30)
            Box.BackgroundColor3 = Themes[Library.Theme].MainColor
            Box.BorderColor3 = Themes[Library.Theme].OutlineColor
            Box.Parent = parentFrame

            local BoxTitle = Instance.new('TextLabel')
            BoxTitle.Size = UDim2.new(1, -10, 0, 20)
            BoxTitle.Position = UDim2.new(0, 5, 0, 2)
            BoxTitle.Text = title
            BoxTitle.TextColor3 = Themes[Library.Theme].AccentColor
            BoxTitle.Font = Library.Font
            BoxTitle.TextSize = 13
            BoxTitle.TextXAlignment = Enum.TextXAlignment.Left
            BoxTitle.BackgroundTransparency = 1
            BoxTitle.Parent = Box

            local Container = Instance.new('Frame')
            Container.Size = UDim2.new(1, -10, 1, -25)
            Container.Position = UDim2.new(0, 5, 0, 22)
            Container.BackgroundTransparency = 1
            Container.Parent = Box

            local BoxList = Instance.new('UIListLayout')
            BoxList.Padding = UDim.new(0, 5)
            BoxList.Parent = Container

            BoxList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                Box.Size = UDim2.new(1, -5, 0, BoxList.AbsoluteContentSize.Y + 30)
            end)

            local GroupObj = {}

            function GroupObj:AddToggle(id, config)
                local text = config.Text or id
                local default = config.Default or false
                local cb = config.Callback

                local ToggleFrame = Instance.new('Frame')
                ToggleFrame.Size = UDim2.new(1, 0, 0, 20)
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Parent = Container

                local Button = Instance.new('TextButton')
                Button.Size = UDim2.new(0, 16, 0, 16)
                Button.Position = UDim2.new(0, 2, 0, 2)
                Button.BackgroundColor3 = default and Themes[Library.Theme].AccentColor or Themes[Library.Theme].BackgroundColor
                Button.BorderColor3 = Themes[Library.Theme].OutlineColor
                Button.Text = ""
                Button.Parent = ToggleFrame

                local Label = Instance.new('TextLabel')
                Label.Size = UDim2.new(1, -25, 1, 0)
                Label.Position = UDim2.new(0, 25, 0, 0)
                Label.Text = text
                Label.TextColor3 = Themes[Library.Theme].FontColor
                Label.Font = Library.Font
                Label.TextSize = 13
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.BackgroundTransparency = 1
                Label.Parent = ToggleFrame

                local ToggleState = default
                local ToggleData = { Value = ToggleState }

                local function update()
                    Button.BackgroundColor3 = ToggleData.Value and Themes[Library.Theme].AccentColor or Themes[Library.Theme].BackgroundColor
                    Library:SafeCallback(cb, ToggleData.Value)
                end

                Button.MouseButton1Click:Connect(function()
                    ToggleData.Value = not ToggleData.Value
                    update()
                end)

                function ToggleData:SetValue(val)
                    ToggleData.Value = val
                    update()
                end

                Library.Toggles[id] = ToggleData
                return ToggleData
            end

            function GroupObj:AddSlider(id, config)
                local text = config.Text or id
                local min = config.Min or 0
                local max = config.Max or 100
                local default = config.Default or min
                local rounding = config.Rounding or 0
                local suffix = config.Suffix or ""
                local cb = config.Callback

                local SliderFrame = Instance.new('Frame')
                SliderFrame.Size = UDim2.new(1, 0, 0, 35)
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Parent = Container

                local Label = Instance.new('TextLabel')
                Label.Size = UDim2.new(1, 0, 0, 15)
                Label.Text = text
                Label.TextColor3 = Themes[Library.Theme].FontColor
                Label.Font = Library.Font
                Label.TextSize = 12
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.BackgroundTransparency = 1
                Label.Parent = SliderFrame

                local Bar = Instance.new('Frame')
                Bar.Size = UDim2.new(1, -4, 0, 12)
                Bar.Position = UDim2.new(0, 2, 0, 18)
                Bar.BackgroundColor3 = Themes[Library.Theme].BackgroundColor
                Bar.BorderColor3 = Themes[Library.Theme].OutlineColor
                Bar.Parent = SliderFrame

                local Fill = Instance.new('Frame')
                Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                Fill.BackgroundColor3 = Themes[Library.Theme].AccentColor
                Fill.BorderSizePixel = 0
                Fill.Parent = Bar

                local ValLabel = Instance.new('TextLabel')
                ValLabel.Size = UDim2.new(1, 0, 1, 0)
                ValLabel.Text = tostring(default) .. suffix
                ValLabel.TextColor3 = Themes[Library.Theme].FontColor
                ValLabel.Font = Library.Font
                ValLabel.TextSize = 11
                ValLabel.BackgroundTransparency = 1
                ValLabel.Parent = Bar

                local SliderData = { Value = default }

                local function snap(val)
                    if rounding == 0 then return math.floor(val + 0.5) end
                    local p = math.pow(10, rounding)
                    return math.floor(val * p + 0.5) / p
                end

                local function update(input)
                    local percent = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                    local rawVal = min + (max - min) * percent
                    SliderData.Value = snap(rawVal)
                    Fill.Size = UDim2.new(percent, 0, 1, 0)
                    ValLabel.Text = tostring(SliderData.Value) .. suffix
                    Library:SafeCallback(cb, SliderData.Value)
                end

                local dragging = false
                Bar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        update(input)
                    end
                end)

                InputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        update(input)
                    end
                end)

                InputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                function SliderData:SetValue(val)
                    SliderData.Value = math.clamp(snap(val), min, max)
                    Fill.Size = UDim2.new((SliderData.Value - min) / (max - min), 0, 1, 0)
                    ValLabel.Text = tostring(SliderData.Value) .. suffix
                    Library:SafeCallback(cb, SliderData.Value)
                end

                Library.Options[id] = SliderData
                return SliderData
            end

            function GroupObj:AddLabel(text)
                local LabelFrame = Instance.new('Frame')
                LabelFrame.Size = UDim2.new(1, 0, 0, 18)
                LabelFrame.BackgroundTransparency = 1
                LabelFrame.Parent = Container

                local Label = Instance.new('TextLabel')
                Label.Size = UDim2.new(1, 0, 1, 0)
                Label.Position = UDim2.new(0, 2, 0, 0)
                Label.Text = text
                Label.TextColor3 = Themes[Library.Theme].FontColor
                Label.Font = Library.Font
                Label.TextSize = 13
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.BackgroundTransparency = 1
                Label.Parent = LabelFrame

                local LabelObj = {}

                function LabelObj:AddColorPicker(id, config)
                    local default = config.Default or Color3.fromRGB(255, 255, 255)
                    local cb = config.Callback

                    local PickerBtn = Instance.new('TextButton')
                    PickerBtn.Size = UDim2.new(0, 25, 0, 14)
                    PickerBtn.Position = UDim2.new(1, -30, 0, 2)
                    PickerBtn.BackgroundColor3 = default
                    PickerBtn.Text = ""
                    PickerBtn.Parent = LabelFrame

                    local PickerData = { Value = default }

                    PickerBtn.MouseButton1Click:Connect(function()
                        local randomColor = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                        PickerData.Value = randomColor
                        PickerBtn.BackgroundColor3 = randomColor
                        Library:SafeCallback(cb, randomColor)
                    end)

                    function PickerData:SetValue(val)
                        PickerData.Value = val
                        PickerBtn.BackgroundColor3 = val
                        Library:SafeCallback(cb, val)
                    end

                    Library.Options[id] = PickerData
                    return LabelObj
                end

                function LabelObj:AddKeyPicker(id, config)
                    local default = config.Default or "None"
                    local cb = config.Callback

                    local KeyBtn = Instance.new('TextButton')
                    KeyBtn.Size = UDim2.new(0, 60, 0, 14)
                    KeyBtn.Position = UDim2.new(1, -65, 0, 2)
                    KeyBtn.BackgroundColor3 = Themes[Library.Theme].BackgroundColor
                    KeyBtn.Text = default
                    KeyBtn.TextColor3 = Themes[Library.Theme].FontColor
                    KeyBtn.Font = Library.Font
                    KeyBtn.TextSize = 11
                    KeyBtn.Parent = LabelFrame

                    local KeyData = { Value = default }
                    local listening = false

                    KeyBtn.MouseButton1Click:Connect(function()
                        KeyBtn.Text = "..."
                        listening = true
                    end)

                    InputService.InputBegan:Connect(function(input)
                        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                            listening = false
                            KeyData.Value = input.KeyCode.Name
                            KeyBtn.Text = KeyData.Value
                            Library:SafeCallback(cb, input.KeyCode)
                        end
                    end)

                    Library.Options[id] = KeyData
                    return LabelObj
                end

                return LabelObj
            end

            function GroupObj:AddDivider()
                local Div = Instance.new('Frame')
                Div.Size = UDim2.new(1, 0, 0, 2)
                Div.BackgroundColor3 = Themes[Library.Theme].OutlineColor
                Div.BorderSizePixel = 0
                Div.Parent = Container
            end

            function GroupObj:AddButton(config)
                local text = config.Text or "Button"
                local func = config.Func

                local Btn = Instance.new('TextButton')
                Btn.Size = UDim2.new(1, -4, 0, 22)
                Btn.BackgroundColor3 = Themes[Library.Theme].BackgroundColor
                Btn.BorderColor3 = Themes[Library.Theme].OutlineColor
                Btn.Text = text
                Btn.TextColor3 = Themes[Library.Theme].FontColor
                Btn.Font = Library.Font
                Btn.TextSize = 13
                Btn.Parent = Container

                Btn.MouseButton1Click:Connect(function()
                    Library:SafeCallback(func)
                end)
            end

            return GroupObj
        end

        function TabObj:AddLeftGroupbox(title)
            return createGroupbox(LeftPage, title)
        end

        function TabObj:AddRightGroupbox(title)
            return createGroupbox(RightPage, title)
        end

        TabObj.Page = TabPage
        table.insert(WindowObj.Tabs, TabObj)
        return TabObj
    end

    return WindowObj
end

function Library:OnUnload(cb)
    self.UnloadCallback = cb
end
return Library
