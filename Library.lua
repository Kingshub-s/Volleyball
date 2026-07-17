-- [[ Fixed & Optimized Linoria-Style UI Library ]] --
local InputService = game:GetService('UserInputService')
local TextService = game:GetService('TextService')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer

local RenderInterface = {} do
    function RenderInterface:Create(class, properties)
        local element = Instance.new(class)
        for property, value in pairs(properties) do
            element[property] = value
        end
        return element
    end
end

local Library = {
    Registry = {},
    RegistryMap = {},
    Unloaded = false,
    Theme = {
        Font = Enum.Font.Code,
        MainColor = Color3.fromRGB(20, 20, 20),
        BackgroundColor = Color3.fromRGB(15, 15, 15),
        AccentColor = Color3.fromRGB(0, 255, 140),
        OutlineColor = Color3.fromRGB(35, 35, 35),
        TextColor = Color3.fromRGB(255, 255, 255),
    },
    Options = {},
    Toggles = {},
}

local BaseGui
local GetGui = function()
    if BaseGui then return BaseGui end
    local success, result = pcall(function()
        return game:GetService("CoreGui")
    end)
    if success and result then
        BaseGui = result
    else
        BaseGui = LocalPlayer:WaitForChild("PlayerGui")
    end
    return BaseGui
end

function Library:SetNotifySide(side)
    self.NotifySide = side
end

function Library:CreateWindow(cfg)
    local title = cfg.Title or "Script Hub"
    
    local ScreenGui = RenderInterface:Create("ScreenGui", {
        Name = "KingsHub_UI",
        ResetOnSpawn = false,
        DisplayOrder = 100,
        Parent = GetGui()
    })
    
    local MainFrame = RenderInterface:Create("Frame", {
        Name = "MainFrame",
        Position = UDim2.new(0.3, 0, 0.25, 0),
        Size = UDim2.new(0, 550, 0, 420),
        BackgroundColor3 = Library.Theme.MainColor,
        BorderSizePixel = 1,
        BorderColor3 = Library.Theme.OutlineColor,
        Active = true,
        Draggable = true,
        Parent = ScreenGui
    })

    local TopBar = RenderInterface:Create("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Library.Theme.BackgroundColor,
        BorderSizePixel = 0,
        Parent = MainFrame
    })

    local TitleLabel = RenderInterface:Create("TextLabel", {
        Text = "  " .. title,
        Font = Library.Theme.Font,
        TextSize = 16,
        TextColor3 = Library.Theme.TextColor,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0.7, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = TopBar
    })

    local SideBar = RenderInterface:Create("Frame", {
        Name = "SideBar",
        Position = UDim2.new(0, 0, 0, 35),
        Size = UDim2.new(0, 130, 1, -35),
        BackgroundColor3 = Library.Theme.BackgroundColor,
        BorderSizePixel = 0,
        Parent = MainFrame
    })

    local SideLayout = RenderInterface:Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2),
        Parent = SideBar
    })

    local ContainerHolder = RenderInterface:Create("Frame", {
        Name = "ContainerHolder",
        Position = UDim2.new(0, 135, 0, 40),
        Size = UDim2.new(1, -140, 1, -45),
        BackgroundTransparency = 1,
        Parent = MainFrame
    })

    local Window = { Tabs = {}, CurrentTab = nil }

    function Window:AddTab(tabName, icon)
        local TabButton = RenderInterface:Create("TextButton", {
            Text = tabName,
            Font = Library.Theme.Font,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(150, 150, 150),
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
            BorderSizePixel = 0,
            Parent = SideBar
        })

        -- FIXED: Changed 'ScrollBarWidth' to 'ScrollBarThickness' to prevent the crash
        local TabContainer = RenderInterface:Create("ScrollingFrame", {
            Name = tabName .. "Container",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4, 
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = ContainerHolder
        })

        local LeftContainer = RenderInterface:Create("Frame", {
            Name = "Left",
            Size = UDim2.new(0.5, -5, 1, 0),
            BackgroundTransparency = 1,
            Parent = TabContainer
        })

        local RightContainer = RenderInterface:Create("Frame", {
            Name = "Right",
            Position = UDim2.new(0.5, 5, 0, 0),
            Size = UDim2.new(0.5, -5, 1, 0),
            BackgroundTransparency = 1,
            Parent = TabContainer
        })

        RenderInterface:Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), Parent = LeftContainer })
        RenderInterface:Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), Parent = RightContainer })

        if not Window.CurrentTab then
            Window.CurrentTab = tabName
            TabContainer.Visible = true
            TabButton.TextColor3 = Library.Theme.AccentColor
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(Window.Tabs) do
                t.Container.Visible = false
                t.Button.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
            TabContainer.Visible = true
            TabButton.TextColor3 = Library.Theme.AccentColor
        end)

        local Tab = { Button = TabButton, Container = TabContainer }

        local function CreateGroupbox(parentFrame, groupName)
            local Box = RenderInterface:Create("Frame", {
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                BorderColor3 = Library.Theme.OutlineColor,
                BorderSizePixel = 1,
                Parent = parentFrame
            })

            local BoxTitle = RenderInterface:Create("TextLabel", {
                Text = " " .. groupName,
                Font = Library.Theme.Font,
                TextSize = 13,
                TextColor3 = Library.Theme.AccentColor,
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = Box
            })

            local ContentFrame = RenderInterface:Create("Frame", {
                Position = UDim2.new(0, 0, 0, 20),
                Size = UDim2.new(1, 0, 1, -20),
                BackgroundTransparency = 1,
                Parent = Box
            })

            RenderInterface:Create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5),
                Parent = ContentFrame
            })

            local Group = {}

            local function updateSize()
                local count = #ContentFrame:GetChildren() - 1
                Box.Size = UDim2.new(1, 0, 0, 25 + (count * 28))
                TabContainer.CanvasSize = UDim2.new(0, 0, 0, math.max(LeftContainer.UIListLayout.AbsoluteContentSize.Y, RightContainer.UIListLayout.AbsoluteContentSize.Y) + 30)
            end

            function Group:AddToggle(id, options)
                local text = options.Text or id
                local default = options.Default or false
                local cb = options.Callback or function() end

                local ToggleFrame = RenderInterface:Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 24),
                    BackgroundTransparency = 1,
                    Parent = ContentFrame
                })

                local Button = RenderInterface:Create("TextButton", {
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 8, 0, 5),
                    BackgroundColor3 = default and Library.Theme.AccentColor or Color3.fromRGB(40, 40, 40),
                    BorderSizePixel = 0,
                    Text = "",
                    Parent = ToggleFrame
                })

                local Label = RenderInterface:Create("TextLabel", {
                    Text = text,
                    Font = Library.Theme.Font,
                    TextSize = 13,
                    TextColor3 = Library.Theme.TextColor,
                    Position = UDim2.new(0, 30, 0, 0),
                    Size = UDim2.new(1, -35, 1, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = ToggleFrame
                })

                local state = default
                Library.Toggles[id] = { Value = state }

                Button.MouseButton1Click:Connect(function()
                    state = not state
                    Library.Toggles[id].Value = state
                    Button.BackgroundColor3 = state and Library.Theme.AccentColor or Color3.fromRGB(40, 40, 40)
                    pcall(cb, state)
                end)

                updateSize()
                return { SetValue = function(val) state = val Button.BackgroundColor3 = state and Library.Theme.AccentColor or Color3.fromRGB(40, 40, 40) pcall(cb, state) end }
            end

            function Group:AddSlider(id, options)
                local text = options.Text or id
                local min = options.Min or 0
                local max = options.Max or 100
                local default = options.Default or min
                local suffix = options.Suffix or ""
                local cb = options.Callback or function() end

                local SliderFrame = RenderInterface:Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundTransparency = 1,
                    Parent = ContentFrame
                })

                local Label = RenderInterface:Create("TextLabel", {
                    Text = text,
                    Font = Library.Theme.Font,
                    TextSize = 12,
                    TextColor3 = Library.Theme.TextColor,
                    Position = UDim2.new(0, 8, 0, 2),
                    Size = UDim2.new(0.6, 0, 0, 14),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = SliderFrame
                })

                local ValueLabel = RenderInterface:Create("TextLabel", {
                    Text = tostring(default) .. suffix,
                    Font = Library.Theme.Font,
                    TextSize = 12,
                    TextColor3 = Library.Theme.AccentColor,
                    Position = UDim2.new(0.6, 0, 0, 2),
                    Size = UDim2.new(0.4, -8, 0, 14),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = SliderFrame
                })

                local SlideBar = RenderInterface:Create("Frame", {
                    Position = UDim2.new(0, 8, 0, 20),
                    Size = UDim2.new(1, -16, 0, 8),
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    BorderSizePixel = 0,
                    Parent = SliderFrame
                })

                local Fill = RenderInterface:Create("Frame", {
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = Library.Theme.AccentColor,
                    BorderSizePixel = 0,
                    Parent = SlideBar
                })

                Library.Options[id] = { Value = default }

                local function updateSlider(input)
                    local percent = math.clamp((input.Position.X - SlideBar.AbsolutePosition.X) / SlideBar.AbsoluteSize.X, 0, 1)
                    local value = math.floor(min + (percent * (max - min)))
                    Library.Options[id].Value = value
                    ValueLabel.Text = tostring(value) .. suffix
                    Fill.Size = UDim2.new(percent, 0, 1, 0)
                    pcall(cb, value)
                end

                local dragging = false
                SlideBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true updateSlider(input) end
                end)
                InputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(input) end
                end)
                InputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                end)

                updateSize()
                return { SetValue = function(val) local percent = math.clamp((val - min) / (max - min), 0, 1) Fill.Size = UDim2.new(percent, 0, 1, 0) ValueLabel.Text = tostring(val) .. suffix Library.Options[id].Value = val pcall(cb, val) end }
            end

            function Group:AddLabel(text)
                local LabelFrame = RenderInterface:Create("Frame", { Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1, Parent = ContentFrame })
                local Lab = RenderInterface:Create("TextLabel", { Text = "  " .. text, Font = Library.Theme.Font, TextSize = 13, TextColor3 = Library.Theme.TextColor, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, Parent = LabelFrame })
                updateSize()
                
                local LabelObj = {}
                function LabelObj:SetText(t) Lab.Text = "  " .. t end
                
                -- Support for .AddColorPicker chaining
                function LabelObj:AddColorPicker(cid, coptions) 
                    local cpdefault = coptions.Default or Color3.fromRGB(255,255,255)
                    local cpcb = coptions.Callback or function() end
                    local CPBox = RenderInterface:Create("Frame", { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(1, -22, 0, 3), BackgroundColor3 = cpdefault, BorderSizePixel = 1, BorderColor3 = Color3.fromRGB(255,255,255), Parent = LabelFrame })
                    Library.Options[cid] = { Value = cpdefault }
                    return { SetValue = function(val) CPBox.BackgroundColor3 = val pcall(cpcb, val) end }
                end

                -- Support for .AddKeyPicker chaining
                function LabelObj:AddKeyPicker(kid, koptions)
                    local kdefault = koptions.Default or "RightShift"
                    local kcb = koptions.Callback or function() end
                    Library.Options[kid] = { Value = kdefault }
                    return { SetValue = function(val) Library.Options[kid].Value = val pcall(kcb, val) end }
                end

                return LabelObj
            end

            function Group:AddDivider()
                RenderInterface:Create("Frame", { Size = UDim2.new(1, -16, 0, 1), Position = UDim2.new(0, 8, 0, 0), BackgroundColor3 = Library.Theme.OutlineColor, BorderSizePixel = 0, Parent = ContentFrame })
                updateSize()
            end

            function Group:AddButton(options)
                local text = options.Text or "Button"
                local func = options.Func or function() end
                local BtnFrame = RenderInterface:Create("Frame", { Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, Parent = ContentFrame })
                local Btn = RenderInterface:Create("TextButton", { Text = text, Font = Library.Theme.Font, TextSize = 13, TextColor3 = Library.Theme.TextColor, Size = UDim2.new(1, -16, 1, -4), Position = UDim2.new(0, 8, 0, 2), BackgroundColor3 = Color3.fromRGB(35,35,35), BorderSizePixel = 1, BorderColor3 = Library.Theme.OutlineColor, Parent = BtnFrame })
                Btn.MouseButton1Click:Connect(func)
                updateSize()
            end

            return Group
        end

        function Tab:AddLeftGroupbox(groupName) return CreateGroupbox(LeftContainer, groupName) end
        function Tab:AddRightGroupbox(groupName) return CreateGroupbox(RightContainer, groupName) end

        table.insert(Window.Tabs, Tab)
        return Tab
    end

    function Library:Notify(notifOptions)
        warn("Kings Hub Notification: " .. tostring(notifOptions.Description))
    end

    return Window
end

-- Core safe hooks for Addons compatibility (ThemeManager / SaveManager)
local ThemeManager = { SetLibrary = function() end, SetFolder = function() end, ApplyToTab = function() end }
local SaveManager = { SetLibrary = function() end, SetFolder = function() end, IgnoreThemeSettings = function() end, SetIgnoreIndexes = function() end, BuildConfigSection = function() end, LoadAutoloadConfig = function() end }

function Library:OnUnload(cb) end

return Library
