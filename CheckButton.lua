local function Probe(region)
    return region:GetObjectType() == "CheckButton" and (region:GetName() ~= nil or Vimp_Validate(region:GetRegions()) or Vimp_Validate(region:GetChildren()))
end

local function Describe(...)
    local region, strings = ...
    local speak = false
    if not strings then
        region = Vimp_Reader:GetFocus()
        strings = {}
        speak = true
    end
    local stringCount = #strings
    Vimp_Strings(strings, region:GetRegions())
    Vimp_Strings(strings, region:GetChildren())
    if #strings == stringCount then
        table.insert(strings, region:GetName())
    end
    if not speak then
        return strings
    end
    table.insert(strings, "Check Button")
    table.insert(strings, region:GetChecked() and "Checked" or "Not checked")
    if not region:IsEnabled() then
        table.insert(strings, "Disabled")
    end
    Vimp_Say(strings)
end

local function Next(backward)
    error("This function must never be called", 2)
end

local function Activate()
    local focus = Vimp_Reader:GetFocus()
    if not focus:IsEnabled() then
        Vimp_Say("Disabled!")
        return
    end
    local strings = {focus:GetChecked() and "Uncheck" or "Check"}
    Describe(focus, strings)
    Vimp_Say(strings)
    focus:Click()
end

local function Dismiss()
    error("This function must never be called", 2)
end

Vimp_Driver:Create(Probe, Describe, Next, Activate, Dismiss)
