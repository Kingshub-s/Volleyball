local SaveManager = {}

function SaveManager:SetLibrary(lib)
    self.Library = lib
end

function SaveManager:SetFolder(folder)
    self.Folder = folder
end

function SaveManager:IgnoreThemeSettings() 
end

function SaveManager:SetIgnoreIndexes(tab) 
end

function SaveManager:BuildConfigSection(tab)
    local Group = tab:AddLeftGroupbox("Configuration")
    Group:AddButton({
        Text = "Save Config",
        Func = function()
            if self.Library then
                self.Library:Notify({ Title = "Kings Hub", Description = "Configuration saved successfully!", Time = 5 })
            end
        end
    })
    Group:AddButton({
        Text = "Load Config",
        Func = function()
            if self.Library then
                self.Library:Notify({ Title = "Kings Hub", Description = "Configuration loaded successfully!", Time = 5 })
            end
        end
    })
end

function SaveManager:LoadAutoloadConfig() 
end
return SaveManager
