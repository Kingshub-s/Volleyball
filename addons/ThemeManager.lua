local ThemeManager = {}

function ThemeManager:SetLibrary(lib)
    self.Library = lib
end

function ThemeManager:SetFolder(folder)
    self.Folder = folder
end

function ThemeManager:ApplyToTab(tab)
    local Group = tab:AddLeftGroupbox("Theme Settings")
    Group:AddLabel("Default Theme Enabled")
end

return ThemeManager
