local Platoboost = loadstring(game:HttpGet("https://raw.githubusercontent.com/Platoboost/Roblox-SDK/main/SDK.lua"))()

local ServiceID = 29190
local SecretKey = "2c99913d-7eb3-42c4-8396-2b5106ddaef4"

Platoboost:Init(ServiceID, SecretKey)

local keyFile = "KingsHub_Key.txt"
if isfile and isfile(keyFile) then
    local savedKey = readfile(keyFile)
    if savedKey and savedKey ~= "" then
        local success, isValid = pcall(function()
            return Platoboost:Verify(savedKey)
        end)
        if success and isValid then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Kingshub-s/dfgfdgdfgdfgdfgfdg/main/vbl"))()
            return
        end
    end
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Kings Hub | Key System",
    SubTitle = "Volleyball Legends",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 340),
    Theme = "Dark"
})

local KeyTab = Window:AddTab({ Title = "Key Verification", Icon = "key" })

KeyTab:AddButton({
    Title = "Get Key (Lootlabs / Workink)",
    Description = "Copy key link to clipboard",
    Callback = function()
        Fluent:Notify({ Title = "Generating Link...", Content = "Please wait a moment.", Duration = 2 })
        
        task.spawn(function()
            local success, link = pcall(function()
                return Platoboost:GetLink()
            end)
            
            if success and link then
                setclipboard(tostring(link))
                Fluent:Notify({
                    Title = "Link Copied!",
                    Content = "Paste the link in your browser to get your key.",
                    Duration = 4
                })
            else
                Fluent:Notify({
                    Title = "Error",
                    Content = "Failed to fetch link. Try again.",
                    Duration = 3
                })
            end
        end)
    end
})

local KeyInput = ""
KeyTab:AddInput("Input", {
    Title = "Enter Key",
    Placeholder = "Paste your key here...",
    Callback = function(Value)
        KeyInput = Value
    end
})

KeyTab:AddButton({
    Title = "Verify Key",
    Callback = function()
        if KeyInput == "" then
            Fluent:Notify({ Title = "Warning", Content = "Please enter a key first!", Duration = 3 })
            return
        end

        Fluent:Notify({ Title = "Verifying...", Content = "Checking key status.", Duration = 2 })

        task.spawn(function()
            local success, isValid = pcall(function()
                return Platoboost:Verify(KeyInput)
            end)
            
            if success and isValid then
                if writefile then
                    writefile(keyFile, KeyInput)
                end
                
                Fluent:Notify({
                    Title = "Success!",
                    Content = "Key Verified! Loading Kings Hub...",
                    Duration = 3
                })
                task.wait(1)
                Window:Destroy()
                
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Kingshub-s/dfgfdgdfgdfgdfgfdg/main/vbl"))()
            else
                Fluent:Notify({
                    Title = "Error",
                    Content = "Invalid or Expired Key!",
                    Duration = 4
                })
            end
        end)
    end
})
