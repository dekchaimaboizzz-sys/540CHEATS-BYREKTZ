-- =====================================================
-- 540CHEATS v25 | Key + Loading + Full Script
-- =====================================================

local KEY_URL = "https://raw.githubusercontent.com/dekchaimaboizzz-sys/540CHEATS-BYREKTZ/refs/heads/main/keys.txt"
local SCRIPT_KEY_FILE = "540cheats_key.txt"

local FONT = Enum.Font.RobotoMono
local DARK = {
    bg = Color3.fromRGB(12, 12, 15),
    sidebar = Color3.fromRGB(15, 15, 20),
    header = Color3.fromRGB(18, 18, 24),
    headerAccent = Color3.fromRGB(0, 200, 255),
    item = Color3.fromRGB(25, 25, 30),
    text = Color3.fromRGB(220, 220, 230),
    subtext = Color3.fromRGB(120, 120, 135),
    accent = Color3.fromRGB(0, 200, 255),
    border = Color3.fromRGB(35, 35, 45),
    toggleOn = Color3.fromRGB(0, 150, 255),
    toggleOff = Color3.fromRGB(45, 45, 55),
    success = Color3.fromRGB(0, 200, 80),
    danger = Color3.fromRGB(200, 50, 60),
}

local TweenService = game:GetService("TweenService")

-- =====================================================
-- KEY VALIDATION
-- =====================================================
local function validateKey(userKey)
    if not userKey or userKey == "" then return false, "ไม่มี key" end
    local ok, response = pcall(function()
        return game:HttpGet(KEY_URL, true)
    end)
    if not ok then return false, "เชื่อมต่อไม่สำเร็จ" end
    local cleanInput = tostring(userKey):gsub("%s+", "")
    for line in response:gmatch("[^\r\n]+") do
        if line:gsub("%s+", "") == cleanInput then return true end
    end
    return false, "Key ไม่ถูกต้อง"
end

local function getSavedKey()
    if isfile and isfile(SCRIPT_KEY_FILE) then
        local ok, key = pcall(function() return readfile(SCRIPT_KEY_FILE) end)
        if ok and key then return key end
    end
    return nil
end

local function saveKey(key)
    if writefile then
        pcall(function() writefile(SCRIPT_KEY_FILE, key) end)
    end
end

-- =====================================================
-- ★★★ LOADING SCREEN ★★★
-- =====================================================
local function showLoadingScreen(callback)
    local LP = game:GetService("Players").LocalPlayer
    local playerGui = LP:WaitForChild("PlayerGui")
    
    local loadGui = Instance.new("ScreenGui")
    loadGui.Name = "540CHEATS_Loading"
    loadGui.ResetOnSpawn = false
    loadGui.IgnoreGuiInset = true
    loadGui.DisplayOrder = 9999
    loadGui.Parent = playerGui
    
    -- Overlay
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.3
    overlay.BorderSizePixel = 0
    overlay.Parent = loadGui
    
    -- Card
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 420, 0, 200)
    card.Position = UDim2.new(0.5, -210, 0.5, -100)
    card.BackgroundColor3 = DARK.bg
    card.BorderSizePixel = 0
    card.BackgroundTransparency = 1
    card.Parent = loadGui
    local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0, 14); cc.Parent = card
    local cs = Instance.new("UIStroke"); cs.Color = DARK.accent; cs.Thickness = 2; cs.Transparency = 1; cs.Parent = card
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 54)
    header.BackgroundColor3 = DARK.header
    header.BorderSizePixel = 0
    header.BackgroundTransparency = 1
    header.Parent = card
    local hc = Instance.new("UICorner"); hc.CornerRadius = UDim.new(0, 14); hc.Parent = header
    
    local hbBottom = Instance.new("Frame")
    hbBottom.Size = UDim2.new(1, 0, 0, 12)
    hbBottom.Position = UDim2.new(0, 0, 1, -12)
    hbBottom.BackgroundColor3 = DARK.header
    hbBottom.BorderSizePixel = 0
    hbBottom.BackgroundTransparency = 1
    hbBottom.Parent = header
    
    -- Logo container
    local logoBg = Instance.new("Frame")
    logoBg.Size = UDim2.new(0, 34, 0, 34)
    logoBg.Position = UDim2.new(0, 14, 0, 10)
    logoBg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    logoBg.BorderSizePixel = 0
    logoBg.BackgroundTransparency = 1
    logoBg.Parent = header
    local lbgc = Instance.new("UICorner"); lbgc.CornerRadius = UDim.new(0, 8); lbgc.Parent = logoBg
    local lbgs = Instance.new("UIStroke"); lbgs.Color = DARK.headerAccent; lbgs.Thickness = 1; lbgs.Transparency = 1; lbgs.Parent = logoBg
    
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 26, 0, 26)
    icon.Position = UDim2.new(0.5, -13, 0.5, -13)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://86571453491468"
    icon.ImageTransparency = 1
    icon.ScaleType = Enum.ScaleType.Fit
    icon.Parent = logoBg
    
    task.spawn(function()
        local ok, loaded = pcall(function() return icon.IsLoaded end)
        if not ok or not loaded then
            task.wait(0.5)
            if not icon.IsLoaded then
                icon:Destroy()
                local e = Instance.new("TextLabel")
                e.Size = UDim2.new(1, 0, 1, 0); e.BackgroundTransparency = 1
                e.Text = "💠"; e.TextSize = 20; e.Font = FONT; e.TextColor3 = DARK.accent
                e.TextTransparency = 1
                e.Parent = logoBg
                TweenService:Create(e, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
            end
        end
    end)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 200, 0, 18)
    title.Position = UDim2.new(0, 58, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "540CHEATS"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = FONT
    title.TextSize = 14
    title.TextTransparency = 1
    title.Parent = header
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(0, 200, 0, 14)
    subtitle.Position = UDim2.new(0, 58, 0, 29)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "discord.gg/540shop"
    subtitle.TextColor3 = DARK.subtext
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Font = FONT
    subtitle.TextSize = 10
    subtitle.TextTransparency = 1
    subtitle.Parent = header
    
    -- Progress section
    local progressLabel = Instance.new("TextLabel")
    progressLabel.Size = UDim2.new(1, -40, 0, 20)
    progressLabel.Position = UDim2.new(0, 20, 0, 80)
    progressLabel.BackgroundTransparency = 1
    progressLabel.Text = "> Loading..."
    progressLabel.TextColor3 = DARK.accent
    progressLabel.TextXAlignment = Enum.TextXAlignment.Left
    progressLabel.Font = FONT
    progressLabel.TextSize = 12
    progressLabel.TextTransparency = 1
    progressLabel.Parent = card
    
    local percentLabel = Instance.new("TextLabel")
    percentLabel.Size = UDim2.new(1, -40, 0, 20)
    percentLabel.Position = UDim2.new(0, 20, 0, 80)
    percentLabel.BackgroundTransparency = 1
    percentLabel.Text = "0%"
    percentLabel.TextColor3 = DARK.accent
    percentLabel.TextXAlignment = Enum.TextXAlignment.Right
    percentLabel.Font = FONT
    percentLabel.TextSize = 12
    percentLabel.TextTransparency = 1
    percentLabel.Parent = card
    
    -- Progress bar
    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(1, -40, 0, 8)
    barBg.Position = UDim2.new(0, 20, 0, 110)
    barBg.BackgroundColor3 = DARK.toggleOff
    barBg.BorderSizePixel = 0
    barBg.BackgroundTransparency = 1
    barBg.Parent = card
    local bbc = Instance.new("UICorner"); bbc.CornerRadius = UDim.new(1, 0); bbc.Parent = barBg
    
    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = DARK.accent
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    local bfc = Instance.new("UICorner"); bfc.CornerRadius = UDim.new(1, 0); bfc.Parent = barFill
    
    -- Status text
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, -40, 0, 16)
    statusText.Position = UDim2.new(0, 20, 1, -30)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Starting..."
    statusText.TextColor3 = DARK.subtext
    statusText.TextXAlignment = Enum.TextXAlignment.Left
    statusText.Font = FONT
    statusText.TextSize = 10
    statusText.TextTransparency = 1
    statusText.Parent = card
    
    -- Fade in
    task.spawn(function()
        TweenService:Create(card, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(cs, TweenInfo.new(0.3), {Transparency = 0}):Play()
        TweenService:Create(header, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(hbBottom, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(logoBg, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(lbgs, TweenInfo.new(0.3), {Transparency = 0.5}):Play()
        TweenService:Create(title, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(subtitle, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(progressLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(percentLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(barBg, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(statusText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        if not icon.Parent then return end
        TweenService:Create(icon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
    end)
    
    -- Animate progress
    task.spawn(function()
        task.wait(0.4)
        
        local steps = {
            { pct = 15, text = "Loading modules...", wait = 0.3 },
            { pct = 30, text = "Preparing UI...", wait = 0.3 },
            { pct = 50, text = "Loading ESP...", wait = 0.4 },
            { pct = 70, text = "Loading Aimbot...", wait = 0.3 },
            { pct = 85, text = "Applying settings...", wait = 0.3 },
            { pct = 100, text = "Ready!", wait = 0.5 },
        }
        
        for _, step in ipairs(steps) do
            statusText.Text = step.text
            TweenService:Create(barFill, TweenInfo.new(step.wait, Enum.EasingStyle.Quad), {
                Size = UDim2.new(step.pct / 100, 0, 1, 0)
            }):Play()
            
            -- Animate percentage
            local startPct = tonumber(percentLabel.Text:gsub("%%","")) or 0
            local endPct = step.pct
            local duration = step.wait
            local elapsed = 0
            local fps = 30
            for i = 1, math.floor(duration * fps) do
                task.wait(1/fps)
                elapsed = elapsed + 1/fps
                local p = math.clamp(elapsed / duration, 0, 1)
                local curr = math.floor(startPct + (endPct - startPct) * p)
                percentLabel.Text = curr .. "%"
            end
            percentLabel.Text = endPct .. "%"
        end
        
        task.wait(0.3)
        
        -- Fade out
        TweenService:Create(card, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(cs, TweenInfo.new(0.4), {Transparency = 1}):Play()
        TweenService:Create(header, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(hbBottom, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(logoBg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(lbgs, TweenInfo.new(0.4), {Transparency = 1}):Play()
        TweenService:Create(title, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(subtitle, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(progressLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(percentLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(barBg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(statusText, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        if icon and icon.Parent then
            TweenService:Create(icon, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
        end
        TweenService:Create(overlay, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        
        task.wait(0.45)
        loadGui:Destroy()
        
        -- Call main
        if callback then callback() end
    end)
end

-- =====================================================
-- ★★★ KEY PROMPT (v24 theme) ★★★
-- =====================================================
local function showKeyPrompt()
    local LP = game:GetService("Players").LocalPlayer
    local playerGui = LP:WaitForChild("PlayerGui")
    
    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "540CHEATS_Key"
    keyGui.ResetOnSpawn = false
    keyGui.IgnoreGuiInset = true
    keyGui.DisplayOrder = 9999
    keyGui.Parent = playerGui
    
    -- Overlay
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.4
    overlay.BorderSizePixel = 0
    overlay.Parent = keyGui
    
    -- Card
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 420, 0, 280)
    card.Position = UDim2.new(0.5, -210, 0.5, -140)
    card.BackgroundColor3 = DARK.bg
    card.BorderSizePixel = 0
    card.BackgroundTransparency = 1
    card.Parent = keyGui
    local bgc = Instance.new("UICorner"); bgc.CornerRadius = UDim.new(0, 14); bgc.Parent = card
    local bgs = Instance.new("UIStroke"); bgs.Color = DARK.accent; bgs.Thickness = 2; bgs.Transparency = 1; bgs.Parent = card
    
    -- Header (เหมือน v24)
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 54)
    header.BackgroundColor3 = DARK.header
    header.BorderSizePixel = 0
    header.BackgroundTransparency = 1
    header.Parent = card
    local hc = Instance.new("UICorner"); hc.CornerRadius = UDim.new(0, 14); hc.Parent = header
    
    local hbBottom = Instance.new("Frame")
    hbBottom.Size = UDim2.new(1, 0, 0, 12)
    hbBottom.Position = UDim2.new(0, 0, 1, -12)
    hbBottom.BackgroundColor3 = DARK.header
    hbBottom.BorderSizePixel = 0
    hbBottom.BackgroundTransparency = 1
    hbBottom.Parent = header
    
    local accentLine = Instance.new("Frame")
    accentLine.Size = UDim2.new(1, -24, 0, 1)
    accentLine.Position = UDim2.new(0, 12, 1, -1)
    accentLine.BackgroundColor3 = DARK.headerAccent
    accentLine.BorderSizePixel = 0
    accentLine.BackgroundTransparency = 1
    accentLine.Parent = header
    
    local logoBg = Instance.new("Frame")
    logoBg.Size = UDim2.new(0, 34, 0, 34)
    logoBg.Position = UDim2.new(0, 14, 0, 10)
    logoBg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    logoBg.BorderSizePixel = 0
    logoBg.BackgroundTransparency = 1
    logoBg.Parent = header
    local lbgc = Instance.new("UICorner"); lbgc.CornerRadius = UDim.new(0, 8); lbgc.Parent = logoBg
    local lbgs = Instance.new("UIStroke"); lbgs.Color = DARK.headerAccent; lbgs.Thickness = 1; lbgs.Transparency = 1; lbgs.Parent = logoBg
    
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 26, 0, 26)
    icon.Position = UDim2.new(0.5, -13, 0.5, -13)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://86571453491468"
    icon.ImageTransparency = 1
    icon.ScaleType = Enum.ScaleType.Fit
    icon.Parent = logoBg
    
    task.spawn(function()
        local ok, loaded = pcall(function() return icon.IsLoaded end)
        if not ok or not loaded then
            task.wait(0.5)
            if icon.Parent and not icon.IsLoaded then
                icon:Destroy()
                local e = Instance.new("TextLabel")
                e.Size = UDim2.new(1, 0, 1, 0); e.BackgroundTransparency = 1
                e.Text = "💠"; e.TextSize = 20; e.Font = FONT; e.TextColor3 = DARK.accent
                e.TextTransparency = 1
                e.Parent = logoBg
                TweenService:Create(e, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
            end
        end
    end)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 200, 0, 18)
    title.Position = UDim2.new(0, 58, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "540CHEATS"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = FONT
    title.TextSize = 14
    title.TextTransparency = 1
    title.Parent = header
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(0, 200, 0, 14)
    subtitle.Position = UDim2.new(0, 58, 0, 29)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "discord.gg/540shop"
    subtitle.TextColor3 = DARK.subtext
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Font = FONT
    subtitle.TextSize = 10
    subtitle.TextTransparency = 1
    subtitle.Parent = header
    
    -- Desc
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -40, 0, 20)
    desc.Position = UDim2.new(0, 20, 0, 68)
    desc.BackgroundTransparency = 1
    desc.Text = "> Enter your key from discord.gg/540shop"
    desc.TextColor3 = DARK.subtext
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Font = FONT
    desc.TextSize = 11
    desc.TextTransparency = 1
    desc.Parent = card
    
    -- Input (styled like v24 item)
    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, -40, 0, 44)
    inputFrame.Position = UDim2.new(0, 20, 0, 98)
    inputFrame.BackgroundColor3 = DARK.item
    inputFrame.BorderSizePixel = 0
    inputFrame.BackgroundTransparency = 1
    inputFrame.Parent = card
    local ifc = Instance.new("UICorner"); ifc.CornerRadius = UDim.new(0, 8); ifc.Parent = inputFrame
    local ifs = Instance.new("UIStroke"); ifs.Color = DARK.border; ifs.Thickness = 1; ifs.Transparency = 1; ifs.Parent = inputFrame
    
    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -24, 1, 0)
    input.Position = UDim2.new(0, 12, 0, 0)
    input.BackgroundTransparency = 1
    input.Text = ""
    input.PlaceholderText = "540CHEATS-PREMIUM-XXX"
    input.TextColor3 = DARK.text
    input.PlaceholderColor3 = DARK.subtext
    input.Font = FONT
    input.TextSize = 12
    input.TextXAlignment = Enum.TextXAlignment.Left
    input.ClearTextOnFocus = false
    input.TextTransparency = 1
    input.Parent = inputFrame
    
    -- Status
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -40, 0, 20)
    status.Position = UDim2.new(0, 20, 0, 152)
    status.BackgroundTransparency = 1
    status.Text = ""
    status.TextColor3 = DARK.subtext
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.Font = FONT
    status.TextSize = 11
    status.TextTransparency = 1
    status.Parent = card
    
    -- Button (styled like v24 toggleOn)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -40, 0, 48)
    btn.Position = UDim2.new(0, 20, 0, 180)
    btn.BackgroundColor3 = DARK.toggleOn
    btn.BorderSizePixel = 0
    btn.Text = "CONFIRM KEY"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = FONT
    btn.TextSize = 13
    btn.TextTransparency = 1
    btn.BackgroundTransparency = 1
    btn.Parent = card
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 8); bc.Parent = btn
    
    -- Footer
    local footer = Instance.new("TextLabel")
    footer.Size = UDim2.new(1, -40, 0, 16)
    footer.Position = UDim2.new(0, 20, 1, -26)
    footer.BackgroundTransparency = 1
    footer.Text = "540CHEATS © discord.gg/540shop"
    footer.TextColor3 = DARK.subtext
    footer.TextXAlignment = Enum.TextXAlignment.Center
    footer.Font = FONT
    footer.TextSize = 10
    footer.TextTransparency = 1
    footer.Parent = card
    
    -- Fade in
    task.spawn(function()
        TweenService:Create(card, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(bgs, TweenInfo.new(0.3), {Transparency = 0}):Play()
        TweenService:Create(header, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(hbBottom, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(accentLine, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
        TweenService:Create(logoBg, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(lbgs, TweenInfo.new(0.3), {Transparency = 0.5}):Play()
        TweenService:Create(title, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(subtitle, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(desc, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(inputFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(ifs, TweenInfo.new(0.3), {Transparency = 0}):Play()
        TweenService:Create(input, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(status, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
        TweenService:Create(footer, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        if icon.Parent then
            TweenService:Create(icon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
        end
    end)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = DARK.toggleOn}):Play()
    end)
    
    local function trySubmit()
        local key = input.Text:gsub("%s+", "")
        if key == "" then
            status.Text = "! Please enter a key"
            status.TextColor3 = Color3.fromRGB(255, 200, 0)
            return
        end
        
        status.Text = "> Validating..."
        status.TextColor3 = Color3.fromRGB(255, 200, 0)
        btn.Text = "CHECKING..."
        btn.BackgroundColor3 = DARK.toggleOff
        btn.Active = false
        
        task.spawn(function()
            local valid, reason = validateKey(key)
            if valid then
                status.Text = "OK Key valid! Loading..."
                status.TextColor3 = DARK.success
                btn.Text = "SUCCESS"
                btn.BackgroundColor3 = DARK.success
                saveKey(key)
                
                task.wait(0.8)
                keyGui:Destroy()
                
                -- Show loading screen then main script
                showLoadingScreen(function()
                    print("[540CHEATS] Loading main script...")
                    local ok2, err = pcall(runMainScript)
                    if not ok2 then
                        warn("[540CHEATS] Script error: " .. tostring(err))
                    end
                end)
            else
                status.Text = "X " .. (reason or "Invalid key")
                status.TextColor3 = DARK.danger
                btn.Text = "TRY AGAIN"
                btn.BackgroundColor3 = DARK.toggleOn
                btn.Active = true
                input.Text = ""
            end
        end)
    end
    
    btn.MouseButton1Click:Connect(trySubmit)
    input.FocusLost:Connect(function(enter)
        if enter then trySubmit() end
    end)
end

-- =====================================================
-- ★★★ MAIN SCRIPT (v25) ★★★
-- =====================================================
local function runMainScript()
    print("[540CHEATS] Starting main script...")
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local WS = workspace
    local Cam = WS.CurrentCamera
    local LP = Players.LocalPlayer
    local VIM = game:GetService("VirtualInputManager")

    local Drawing = Drawing or (getgenv and getgenv().Drawing)
    if not Drawing then warn("ต้องใช้ Drawing API"); return end

    local CFG = {
        Aimbot = true, InstantLock = true, Smoothness = 0.55,
        FOV = 250, AimbotRange = 3000, Prediction = false, PredAmount = 0.15,
        TargetPart = "Head", ShowFOV = true, AimbotMode = "Hold",
        Trigger = false, TDelay = 0.05,
        ESP = true, Lines = true, Skeleton = true, Box = true,
        HealthBar = true, HitboxCircle = true, Name = true, Distance = true,
        LineOrigin = "top", MaxDistance = 1500,
        SkeletonThickness = 2.5, SkeletonColor = Color3.fromRGB(255, 80, 80),
        AntiAFK = true,
    }

    local aiming = false
    local aimbotToggled = false
    local enemies = {}
    local esp = {}
    local gui, main, minimizedLogo, notif
    local fovCircle, userAvatar

    -- ENEMY SCAN
    task.spawn(function()
        while true do
            task.wait(0.15)
            local list = {}
            local myChar = LP.Character
            for _, obj in ipairs(WS:GetChildren()) do
                if obj:IsA("Model") and obj ~= myChar then
                    local hum = obj:FindFirstChildOfClass("Humanoid")
                    local head = obj:FindFirstChild("Head")
                    local hrp = obj:FindFirstChild("HumanoidRootPart")
                    if hum and head and hrp and hum.Health > 0 then
                        table.insert(list, { model = obj, head = head, hrp = hrp, hum = hum, name = obj.Name })
                    end
                end
            end
            enemies = list
        end
    end)

    -- DRAWING HELPERS
    local function newLine(c, t)
        local l = Drawing.new("Line"); l.Color = c; l.Thickness = t; l.Transparency = 0.3; l.Visible = false; return l
    end
    local function newText(s, c)
        local t = Drawing.new("Text"); t.Size = s; t.Color = c; t.Center = true; t.Outline = true
        t.OutlineColor = Color3.fromRGB(0, 0, 0); t.Visible = false; t.Font = 3
        return t
    end
    local function newCircle(c, t)
        local o = Drawing.new("Circle"); o.Color = c; o.Thickness = t; o.NumSides = 32
        o.Radius = 20; o.Filled = false; o.Transparency = 1; o.Visible = false; return o
    end
    local function newSkelPair(c, t)
        local bg = Drawing.new("Line"); bg.Color = Color3.fromRGB(0, 0, 0); bg.Thickness = t + 2.5; bg.Transparency = 1; bg.Visible = false
        local fg = Drawing.new("Line"); fg.Color = c; fg.Thickness = t; fg.Transparency = 1; fg.Visible = false
        return { bg = bg, fg = fg }
    end
    local function setSkelPair(p, a, b, v)
        if not p then return end
        if v and a and b then
            p.bg.From = a; p.bg.To = b; p.bg.Visible = true
            p.fg.From = a; p.fg.To = b; p.fg.Visible = true
        else p.bg.Visible = false; p.fg.Visible = false end
    end
    local function removeSkelPair(p)
        if not p then return end
        pcall(function() p.bg:Remove() end); pcall(function() p.fg:Remove() end)
    end

    fovCircle = Drawing.new("Circle")
    fovCircle.Color = Color3.fromRGB(0, 220, 255); fovCircle.Thickness = 2; fovCircle.NumSides = 60
    fovCircle.Transparency = 0.6; fovCircle.Filled = false; fovCircle.Visible = true

    local crossH = Drawing.new("Line"); local crossV = Drawing.new("Line"); local crossDot = Drawing.new("Circle")
    crossH.Color = Color3.fromRGB(0, 255, 100); crossV.Color = Color3.fromRGB(0, 255, 100); crossDot.Color = Color3.fromRGB(0, 255, 100)
    crossH.Thickness = 1; crossV.Thickness = 1; crossDot.Thickness = 1; crossDot.NumSides = 12
    crossDot.Radius = 2; crossDot.Filled = true; crossDot.Transparency = 1
    crossH.Visible = false; crossV.Visible = false; crossDot.Visible = false

    -- ESP
    local function createESP(enemy)
        if esp[enemy.model] then return end
        esp[enemy.model] = {
            line = newLine(Color3.fromRGB(255, 255, 255), 1),
            skelHeadUpper = newSkelPair(CFG.SkeletonColor, CFG.SkeletonThickness),
            skelUpperLower = newSkelPair(CFG.SkeletonColor, CFG.SkeletonThickness),
            skelLeftArm = newSkelPair(CFG.SkeletonColor, CFG.SkeletonThickness),
            skelLeftForearm = newSkelPair(CFG.SkeletonColor, CFG.SkeletonThickness),
            skelRightArm = newSkelPair(CFG.SkeletonColor, CFG.SkeletonThickness),
            skelRightForearm = newSkelPair(CFG.SkeletonColor, CFG.SkeletonThickness),
            skelLeftLeg = newSkelPair(CFG.SkeletonColor, CFG.SkeletonThickness),
            skelLeftShin = newSkelPair(CFG.SkeletonColor, CFG.SkeletonThickness),
            skelRightLeg = newSkelPair(CFG.SkeletonColor, CFG.SkeletonThickness),
            skelRightShin = newSkelPair(CFG.SkeletonColor, CFG.SkeletonThickness),
            boxTop = newLine(Color3.fromRGB(255, 255, 255), 1),
            boxBottom = newLine(Color3.fromRGB(255, 255, 255), 1),
            boxLeft = newLine(Color3.fromRGB(255, 255, 255), 1),
            boxRight = newLine(Color3.fromRGB(255, 255, 255), 1),
            hpBarBg = newLine(Color3.fromRGB(30, 30, 30), 3),
            hpBarFill = newLine(Color3.fromRGB(0, 255, 100), 3),
            hitboxCircle = newCircle(Color3.fromRGB(255, 50, 50), 1.5),
            nameText = newText(14, Color3.fromRGB(255, 255, 255)),
            distText = newText(12, Color3.fromRGB(200, 200, 200)),
        }
    end
    local function removeESP(model)
        local e = esp[model]; if not e then return end
        for _, obj in pairs(e) do
            if type(obj) == "table" and obj.bg then removeSkelPair(obj)
            else pcall(function() obj:Remove() end) end
        end
        esp[model] = nil
    end
    local function hideESP(model)
        local e = esp[model]; if not e then return end
        for _, obj in pairs(e) do
            if type(obj) == "table" and obj.bg then obj.bg.Visible = false; obj.fg.Visible = false
            else pcall(function() obj.Visible = false end) end
        end
    end
    local function clearAll() for m, _ in pairs(esp) do removeESP(m) end; esp = {} end
    local function getOrigin()
        local vp = Cam.ViewportSize
        if CFG.LineOrigin == "top" then return Vector2.new(vp.X / 2, 0)
        elseif CFG.LineOrigin == "bottom" then return Vector2.new(vp.X / 2, vp.Y)
        else return Vector2.new(vp.X / 2, vp.Y / 2) end
    end
    local function partPos(part)
        if not part then return nil end
        local sp, on = Cam:WorldToViewportPoint(part.Position)
        if not on then return nil end
        return Vector2.new(sp.X, sp.Y)
    end

    local function getClosest()
        if not CFG.Aimbot then return nil, nil end
        local cl, ce, sh = nil, nil, math.huge
        local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil, nil end
        local center = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
        for _, e in ipairs(enemies) do
            local tp = e.model:FindFirstChild(CFG.TargetPart) or e.model:FindFirstChild("Hitbox_Head") or e.head
            if tp then
                local d3 = (tp.Position - myRoot.Position).Magnitude
                if d3 <= CFG.AimbotRange then
                    local sp, on = Cam:WorldToViewportPoint(tp.Position)
                    if on then
                        local dp = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        if dp <= CFG.FOV and dp < sh then sh = dp; cl = tp; ce = e end
                    end
                end
            end
        end
        return cl, ce
    end
    local function predict(part, enemy)
        if not CFG.Prediction or not enemy or not enemy.hrp then return part.Position end
        return part.Position + enemy.hrp.Velocity * CFG.PredAmount
    end
    local function aimAt(part, enemy)
        if not part then return end
        local tp = predict(part, enemy)
        if CFG.InstantLock then Cam.CFrame = CFrame.new(Cam.CFrame.Position, tp)
        else Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position, tp), (1 - CFG.Smoothness) * 0.3) end
    end

    RunService.RenderStepped:Connect(function()
        if not CFG.ESP then if next(esp) then clearAll() end
        else
            local myChar = LP.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local aliveSet = {}
                for _, en in ipairs(enemies) do aliveSet[en.model] = true end
                for m, _ in pairs(esp) do
                    if not aliveSet[m] then hideESP(m) end
                    if not m.Parent then removeESP(m) end
                end
                local origin = getOrigin()
                for _, enemy in ipairs(enemies) do
                    createESP(enemy)
                    local e = esp[enemy.model]; if not e then continue end
                    local dist = (enemy.head.Position - myRoot.Position).Magnitude
                    if dist > CFG.MaxDistance then hideESP(enemy.model); continue end
                    local head = enemy.model:FindFirstChild("Head")
                    local ut = enemy.model:FindFirstChild("UpperTorso") or enemy.model:FindFirstChild("Torso")
                    local lt = enemy.model:FindFirstChild("LowerTorso") or enemy.model:FindFirstChild("Torso")
                    local lua = enemy.model:FindFirstChild("LeftUpperArm") or enemy.model:FindFirstChild("Left Arm")
                    local lh = enemy.model:FindFirstChild("LeftHand") or enemy.model:FindFirstChild("Left Arm")
                    local rua = enemy.model:FindFirstChild("RightUpperArm") or enemy.model:FindFirstChild("Right Arm")
                    local rh = enemy.model:FindFirstChild("RightHand") or enemy.model:FindFirstChild("Right Arm")
                    local lul = enemy.model:FindFirstChild("LeftUpperLeg") or enemy.model:FindFirstChild("Left Leg")
                    local lf = enemy.model:FindFirstChild("LeftFoot") or enemy.model:FindFirstChild("Left Leg")
                    local rul = enemy.model:FindFirstChild("RightUpperLeg") or enemy.model:FindFirstChild("Right Leg")
                    local rf = enemy.model:FindFirstChild("RightFoot") or enemy.model:FindFirstChild("Right Leg")
                    local pHead = partPos(head); local pUpper = partPos(ut); local pLower = partPos(lt)
                    local pLUA = partPos(lua); local pLH = partPos(lh); local pRUA = partPos(rua); local pRH = partPos(rh)
                    local pLUL = partPos(lul); local pLF = partPos(lf); local pRUL = partPos(rul); local pRF = partPos(rf)
                    local headScreen, onScreen = Cam:WorldToViewportPoint(head.Position)
                    if onScreen and pHead and pUpper then
                        if e.line then e.line.Visible = CFG.Lines; if CFG.Lines then e.line.From = origin; e.line.To = pHead end end
                        setSkelPair(e.skelHeadUpper, pHead, pUpper, CFG.Skeleton)
                        setSkelPair(e.skelUpperLower, pUpper, pLower, CFG.Skeleton)
                        setSkelPair(e.skelLeftArm, pUpper, pLUA, CFG.Skeleton)
                        setSkelPair(e.skelLeftForearm, pLUA, pLH, CFG.Skeleton)
                        setSkelPair(e.skelRightArm, pUpper, pRUA, CFG.Skeleton)
                        setSkelPair(e.skelRightForearm, pRUA, pRH, CFG.Skeleton)
                        setSkelPair(e.skelLeftLeg, pLower, pLUL, CFG.Skeleton)
                        setSkelPair(e.skelLeftShin, pLUL, pLF, CFG.Skeleton)
                        setSkelPair(e.skelRightLeg, pLower, pRUL, CFG.Skeleton)
                        setSkelPair(e.skelRightShin, pRUL, pRF, CFG.Skeleton)
                        if CFG.Box and pHead and (pLF or pRF or pLower) then
                            local botPos = pLF or pRF or pLower
                            local bTop = pHead.Y - 20; local bBot = botPos.Y + 8
                            local w = math.abs(bBot - bTop) * 0.5
                            local bL = pHead.X - w / 2; local bR = pHead.X + w / 2
                            e.boxTop.From = Vector2.new(bL, bTop); e.boxTop.To = Vector2.new(bR, bTop); e.boxTop.Visible = true
                            e.boxBottom.From = Vector2.new(bL, bBot); e.boxBottom.To = Vector2.new(bR, bBot); e.boxBottom.Visible = true
                            e.boxLeft.From = Vector2.new(bL, bTop); e.boxLeft.To = Vector2.new(bL, bBot); e.boxLeft.Visible = true
                            e.boxRight.From = Vector2.new(bR, bTop); e.boxRight.To = Vector2.new(bR, bBot); e.boxRight.Visible = true
                            if CFG.HealthBar and enemy.hum then
                                local hp = math.clamp(enemy.hum.Health / enemy.hum.MaxHealth, 0, 1)
                                local bH = bBot - bTop; local bX = bL - 8
                                e.hpBarBg.From = Vector2.new(bX, bTop); e.hpBarBg.To = Vector2.new(bX, bBot); e.hpBarBg.Visible = true
                                local fTop = bBot - (bH * hp)
                                e.hpBarFill.From = Vector2.new(bX, fTop); e.hpBarFill.To = Vector2.new(bX, bBot); e.hpBarFill.Visible = true
                                e.hpBarFill.Color = hp > 0.6 and Color3.fromRGB(0, 255, 100) or (hp > 0.3 and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(255, 50, 50))
                            else e.hpBarBg.Visible = false; e.hpBarFill.Visible = false end
                        else
                            e.boxTop.Visible = false; e.boxBottom.Visible = false; e.boxLeft.Visible = false
                            e.boxRight.Visible = false; e.hpBarBg.Visible = false; e.hpBarFill.Visible = false
                        end
                        if CFG.HitboxCircle then
                            local hb = enemy.model:FindFirstChild("Hitbox_Head") or head
                            local hbSp, hbOn = Cam:WorldToViewportPoint(hb.Position)
                            if hbOn then
                                local camDist = (Cam.CFrame.Position - hb.Position).Magnitude
                                local rad = (head.Size.Y / 2) * (Cam.ViewportSize.Y / 2) / (camDist * math.tan(math.rad(Cam.FieldOfView / 2)))
                                e.hitboxCircle.Position = Vector2.new(hbSp.X, hbSp.Y); e.hitboxCircle.Radius = math.max(rad, 3); e.hitboxCircle.Visible = true
                                if enemy.hum then
                                    local hp = enemy.hum.Health / enemy.hum.MaxHealth
                                    e.hitboxCircle.Color = hp > 0.6 and Color3.fromRGB(0, 255, 100) or (hp > 0.3 and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(255, 50, 50))
                                end
                            else e.hitboxCircle.Visible = false end
                        else e.hitboxCircle.Visible = false end
                        if CFG.Name then e.nameText.Position = Vector2.new(headScreen.X, headScreen.Y - 55); e.nameText.Text = enemy.name; e.nameText.Visible = true
                        else e.nameText.Visible = false end
                        if CFG.Distance then e.distText.Position = Vector2.new(headScreen.X, headScreen.Y - 38); e.distText.Text = math.floor(dist) .. " studs"; e.distText.Visible = true
                        else e.distText.Visible = false end
                    else hideESP(enemy.model) end
                end
            end
        end
        if CFG.ShowFOV and CFG.ESP then
            fovCircle.Position = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
            fovCircle.Radius = CFG.FOV; fovCircle.Visible = true
        else fovCircle.Visible = false end
        local cx = Cam.ViewportSize.X / 2; local cy = Cam.ViewportSize.Y / 2
        crossH.From = Vector2.new(cx - 8, cy); crossH.To = Vector2.new(cx + 8, cy); crossH.Visible = true
        crossV.From = Vector2.new(cx, cy - 8); crossV.To = Vector2.new(cx, cy + 8); crossV.Visible = true
        crossDot.Position = Vector2.new(cx, cy); crossDot.Visible = true
        local shouldAim = CFG.AimbotMode == "Hold" and aiming or CFG.AimbotMode == "Toggle" and aimbotToggled
        if shouldAim and CFG.Aimbot then
            local p, e = getClosest()
            if p then aimAt(p, e) end
        end
    end)

    local lastTrigger = 0
    task.spawn(function()
        while true do
            task.wait(0.01)
            if CFG.Trigger and tick() - lastTrigger >= CFG.TDelay then
                local t = getClosest()
                if t then
                    local sp, on = Cam:WorldToViewportPoint(t.Position)
                    if on then
                        local ctr = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
                        local dp = (Vector2.new(sp.X, sp.Y) - ctr).Magnitude
                        if dp < 25 then
                            lastTrigger = tick()
                            pcall(function()
                                VIM:SendMouseButtonEvent(ctr.X, ctr.Y, 0, true, game, 0)
                                task.wait(0.01)
                                VIM:SendMouseButtonEvent(ctr.X, ctr.Y, 0, false, game, 0)
                            end)
                        end
                    end
                end
            end
        end
    end)

    LP.Idled:Connect(function()
        if not CFG.AntiAFK then return end
        pcall(function()
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.1)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end)
    end)

    -- ========== UI ==========
    gui = Instance.new("ScreenGui")
    gui.Name = "540CHEATS_v25"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = LP:WaitForChild("PlayerGui")

    main = Instance.new("Frame")
    main.Size = UDim2.new(0, 640, 0, 420)
    main.Position = UDim2.new(0.5, -320, 0.5, -210)
    main.BackgroundColor3 = DARK.bg
    main.BorderSizePixel = 0
    main.Active = true
    main.BackgroundTransparency = 1
    main.Parent = gui
    local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0, 12); mc.Parent = main
    local ms = Instance.new("UIStroke"); ms.Color = DARK.border; ms.Thickness = 1; ms.Transparency = 1; ms.Parent = main

    -- Fade in main
    task.spawn(function()
        TweenService:Create(main, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
        TweenService:Create(ms, TweenInfo.new(0.4), {Transparency = 0}):Play()
    end)

    local HEADER_H = 54
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, HEADER_H)
    header.BackgroundColor3 = DARK.header
    header.BorderSizePixel = 0
    header.Parent = main
    local hc = Instance.new("UICorner"); hc.CornerRadius = UDim.new(0, 12); hc.Parent = header

    local headerBottom = Instance.new("Frame")
    headerBottom.Size = UDim2.new(1, 0, 0, 12)
    headerBottom.Position = UDim2.new(0, 0, 1, -12)
    headerBottom.BackgroundColor3 = DARK.header
    headerBottom.BorderSizePixel = 0
    headerBottom.Parent = header

    local accentLine = Instance.new("Frame")
    accentLine.Size = UDim2.new(1, -24, 0, 1)
    accentLine.Position = UDim2.new(0, 12, 1, -1)
    accentLine.BackgroundColor3 = DARK.headerAccent
    accentLine.BorderSizePixel = 0
    accentLine.BackgroundTransparency = 0.5
    accentLine.Parent = header

    local dragging, dragStart, startPos
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = i.Position; startPos = main.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    local logoBg = Instance.new("Frame")
    logoBg.Size = UDim2.new(0, 34, 0, 34)
    logoBg.Position = UDim2.new(0, 14, 0, 10)
    logoBg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    logoBg.BorderSizePixel = 0
    logoBg.Parent = header
    local lbgc = Instance.new("UICorner"); lbgc.CornerRadius = UDim.new(0, 8); lbgc.Parent = logoBg
    local lbgs = Instance.new("UIStroke"); lbgs.Color = DARK.headerAccent; lbgs.Thickness = 1; lbgs.Transparency = 0.5; lbgs.Parent = logoBg

    local headerIcon = Instance.new("ImageLabel")
    headerIcon.Size = UDim2.new(0, 26, 0, 26)
    headerIcon.Position = UDim2.new(0.5, -13, 0.5, -13)
    headerIcon.BackgroundTransparency = 1
    headerIcon.Image = "rbxassetid://86571453491468"
    headerIcon.ScaleType = Enum.ScaleType.Fit
    headerIcon.Parent = logoBg

    task.spawn(function()
        local ok, loaded = pcall(function() return headerIcon.IsLoaded end)
        if not ok or not loaded then
            task.wait(0.5)
            if not headerIcon.IsLoaded then
                headerIcon:Destroy()
                local e = Instance.new("TextLabel")
                e.Size = UDim2.new(1, 0, 1, 0); e.BackgroundTransparency = 1
                e.Text = "💠"; e.TextSize = 20; e.Font = FONT; e.TextColor3 = DARK.accent
                e.Parent = logoBg
            end
        end
    end)

    local headerTitle = Instance.new("TextLabel")
    headerTitle.Size = UDim2.new(0, 200, 0, 18)
    headerTitle.Position = UDim2.new(0, 58, 0, 10)
    headerTitle.BackgroundTransparency = 1
    headerTitle.Text = "540CHEATS"
    headerTitle.TextColor3 = Color3.new(1, 1, 1)
    headerTitle.TextXAlignment = Enum.TextXAlignment.Left
    headerTitle.Font = FONT
    headerTitle.TextSize = 14
    headerTitle.Parent = header

    local headerSub = Instance.new("TextLabel")
    headerSub.Size = UDim2.new(0, 200, 0, 14)
    headerSub.Position = UDim2.new(0, 58, 0, 29)
    headerSub.BackgroundTransparency = 1
    headerSub.Text = "discord.gg/540shop"
    headerSub.TextColor3 = DARK.subtext
    headerSub.TextXAlignment = Enum.TextXAlignment.Left
    headerSub.Font = FONT
    headerSub.TextSize = 10
    headerSub.Parent = header

    local btnContainer = Instance.new("Frame")
    btnContainer.Size = UDim2.new(0, 68, 0, 30)
    btnContainer.Position = UDim2.new(1, -80, 0, 12)
    btnContainer.BackgroundTransparency = 1
    btnContainer.Parent = header

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 30, 1, 0)
    minBtn.BackgroundColor3 = Color3.fromRGB(28, 38, 55)
    minBtn.BorderSizePixel = 0
    minBtn.Text = "—"
    minBtn.TextColor3 = Color3.fromRGB(200, 210, 230)
    minBtn.Font = FONT
    minBtn.TextSize = 16
    minBtn.Parent = btnContainer
    local mbc = Instance.new("UICorner"); mbc.CornerRadius = UDim.new(0, 6); mbc.Parent = minBtn
    minBtn.MouseEnter:Connect(function() TweenService:Create(minBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 120, 200), TextColor3 = Color3.new(1,1,1)}):Play() end)
    minBtn.MouseLeave:Connect(function() TweenService:Create(minBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28, 38, 55), TextColor3 = Color3.fromRGB(200, 210, 230)}):Play() end)
    minBtn.MouseButton1Click:Connect(function() main.Visible = false; minimizedLogo.Visible = true end)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(0, 38, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(55, 28, 34)
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(230, 180, 190)
    closeBtn.Font = FONT
    closeBtn.TextSize = 18
    closeBtn.Parent = btnContainer
    local cbc = Instance.new("UICorner"); cbc.CornerRadius = UDim.new(0, 6); cbc.Parent = closeBtn
    closeBtn.MouseEnter:Connect(function() TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(200, 50, 60), TextColor3 = Color3.new(1,1,1)}):Play() end)
    closeBtn.MouseLeave:Connect(function() TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(55, 28, 34), TextColor3 = Color3.fromRGB(230, 180, 190)}):Play() end)
    closeBtn.MouseButton1Click:Connect(function()
        pcall(function() fovCircle:Remove() end)
        pcall(function() crossH:Remove() end)
        pcall(function() crossV:Remove() end)
        pcall(function() crossDot:Remove() end)
        clearAll()
        pcall(function() gui:Destroy() end)
        print("[540CHEATS] ปิดสคริปต์แล้ว")
    end)

    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 160, 1, -HEADER_H)
    sidebar.Position = UDim2.new(0, 0, 0, HEADER_H)
    sidebar.BackgroundColor3 = DARK.sidebar
    sidebar.BorderSizePixel = 0
    sidebar.Parent = main

    local tabs = {}
    local pages = {}
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, -90)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = sidebar
    local tl = Instance.new("UIListLayout"); tl.Padding = UDim.new(0, 2); tl.Parent = tabContainer
    local tp = Instance.new("UIPadding"); tp.PaddingTop = UDim.new(0, 12); tp.PaddingLeft = UDim.new(0, 10); tp.PaddingRight = UDim.new(0, 10); tp.Parent = tabContainer

    local function createTab(name, icon)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 34)
        btn.BackgroundColor3 = DARK.item
        btn.BackgroundTransparency = 1
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.Parent = tabContainer
        local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 8); bc.Parent = btn
        local ico = Instance.new("TextLabel")
        ico.Size = UDim2.new(0, 22, 0, 34); ico.Position = UDim2.new(0, 8, 0, 0)
        ico.BackgroundTransparency = 1; ico.Text = icon
        ico.TextColor3 = DARK.subtext; ico.TextXAlignment = Enum.TextXAlignment.Left
        ico.Font = FONT; ico.TextSize = 14; ico.Parent = btn
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -36, 1, 0); lbl.Position = UDim2.new(0, 36, 0, 0)
        lbl.BackgroundTransparency = 1; lbl.Text = name
        lbl.TextColor3 = DARK.subtext; lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = FONT; lbl.TextSize = 12; lbl.Parent = btn

        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, -180, 1, -HEADER_H - 20)
        page.Position = UDim2.new(0, 170, 0, HEADER_H + 10)
        page.BackgroundTransparency = 1; page.BorderSizePixel = 0
        page.ScrollBarThickness = 4; page.ScrollBarImageColor3 = DARK.accent
        page.CanvasSize = UDim2.new(0, 0, 0, 0); page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        page.Visible = false; page.Parent = main
        local pl = Instance.new("UIListLayout"); pl.Padding = UDim.new(0, 8); pl.Parent = page
        local pp = Instance.new("UIPadding"); pp.PaddingTop = UDim.new(0, 5); pp.PaddingRight = UDim.new(0, 8); pp.Parent = page

        tabs[name] = btn; pages[name] = page
        btn.MouseButton1Click:Connect(function()
            for n, t in pairs(tabs) do
                t.BackgroundTransparency = 1
                pages[n].Visible = false
                t:FindFirstChild("TextLabel").TextColor3 = DARK.subtext
            end
            btn.BackgroundTransparency = 0
            btn.BackgroundColor3 = DARK.item
            page.Visible = true
            lbl.TextColor3 = Color3.new(1, 1, 1)
            ico.TextColor3 = DARK.accent
        end)
    end

    createTab("Aimbot", "🎯")
    createTab("ESP", "👁️")
    createTab("Misc", "⚙️")
    createTab("Settings", "🛠️")

    tabs["Aimbot"].BackgroundTransparency = 0
    tabs["Aimbot"].BackgroundColor3 = DARK.item
    pages["Aimbot"].Visible = true
    tabs["Aimbot"]:FindFirstChild("TextLabel").TextColor3 = Color3.new(1, 1, 1)

    local userPanel = Instance.new("Frame")
    userPanel.Size = UDim2.new(1, -20, 0, 60)
    userPanel.Position = UDim2.new(0, 10, 1, -70)
    userPanel.BackgroundColor3 = DARK.item
    userPanel.BorderSizePixel = 0
    userPanel.Parent = sidebar
    local upc = Instance.new("UICorner"); upc.CornerRadius = UDim.new(0, 8); upc.Parent = userPanel
    local ups = Instance.new("UIStroke"); ups.Color = DARK.border; ups.Thickness = 1; ups.Parent = userPanel

    userAvatar = Instance.new("ImageLabel")
    userAvatar.Size = UDim2.new(0, 40, 0, 40)
    userAvatar.Position = UDim2.new(0, 10, 0.5, -20)
    userAvatar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    userAvatar.BorderSizePixel = 0
    userAvatar.Parent = userPanel
    local uac = Instance.new("UICorner"); uac.CornerRadius = UDim.new(1, 0); uac.Parent = userAvatar
    local uas = Instance.new("UIStroke"); uas.Color = DARK.accent; uas.Thickness = 1.5; uas.Parent = userAvatar

    local userName = Instance.new("TextLabel")
    userName.Size = UDim2.new(1, -60, 0, 16)
    userName.Position = UDim2.new(0, 58, 0, 10)
    userName.BackgroundTransparency = 1
    userName.Text = LP.Name
    userName.TextColor3 = Color3.new(1, 1, 1)
    userName.TextXAlignment = Enum.TextXAlignment.Left
    userName.Font = FONT
    userName.TextSize = 11
    userName.TextTruncate = Enum.TextTruncate.AtEnd
    userName.Parent = userPanel

    local userId = Instance.new("TextLabel")
    userId.Size = UDim2.new(1, -60, 0, 14)
    userId.Position = UDim2.new(0, 58, 0, 28)
    userId.BackgroundTransparency = 1
    userId.Text = "ID: " .. LP.UserId
    userId.TextColor3 = DARK.subtext
    userId.TextXAlignment = Enum.TextXAlignment.Left
    userId.Font = FONT
    userId.TextSize = 10
    userId.Parent = userPanel

    task.spawn(function()
        local ok, thumb = pcall(function()
            return Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        end)
        if ok and thumb then userAvatar.Image = thumb end
    end)

    local function makeToggle(parent, label, initial, cb)
        local c = Instance.new("Frame")
        c.Size = UDim2.new(1, 0, 0, 36)
        c.BackgroundColor3 = DARK.item; c.BorderSizePixel = 0
        c.Parent = parent
        local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0, 8); cc.Parent = c
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, -60, 1, 0); l.Position = UDim2.new(0, 14, 0, 0)
        l.BackgroundTransparency = 1; l.Text = label
        l.TextColor3 = DARK.text; l.TextXAlignment = Enum.TextXAlignment.Left
        l.Font = FONT; l.TextSize = 12; l.Parent = c
        local sw = Instance.new("Frame")
        sw.Size = UDim2.new(0, 38, 0, 20); sw.Position = UDim2.new(1, -50, 0.5, -10)
        sw.BackgroundColor3 = initial and DARK.toggleOn or DARK.toggleOff
        sw.BorderSizePixel = 0; sw.Parent = c
        local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(1, 0); sc.Parent = sw
        local k = Instance.new("Frame")
        k.Size = UDim2.new(0, 14, 0, 14)
        k.Position = initial and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        k.BackgroundColor3 = Color3.new(1, 1, 1); k.BorderSizePixel = 0; k.Parent = sw
        local kc = Instance.new("UICorner"); kc.CornerRadius = UDim.new(1, 0); kc.Parent = k
        local st = initial
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1; btn.Text = ""; btn.Parent = c
        btn.MouseButton1Click:Connect(function()
            st = not st
            sw.BackgroundColor3 = st and DARK.toggleOn or DARK.toggleOff
            TweenService:Create(k, TweenInfo.new(0.15), {
                Position = st and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
            }):Play()
            cb(st)
        end)
    end

    local function makeSlider(parent, label, min, max, initial, cb)
        local cont = Instance.new("Frame")
        cont.Size = UDim2.new(1, 0, 0, 50)
        cont.BackgroundColor3 = DARK.item; cont.BorderSizePixel = 0
        cont.Parent = parent
        local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0, 8); cc.Parent = cont
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 0, 18); lbl.Position = UDim2.new(0, 14, 0, 6)
        lbl.BackgroundTransparency = 1
        lbl.Text = label .. ":  " .. string.format("%.2f", initial)
        lbl.TextColor3 = DARK.text; lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = FONT; lbl.TextSize = 11; lbl.Parent = cont
        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(1, -28, 0, 8); bar.Position = UDim2.new(0, 14, 0, 32)
        bar.BackgroundColor3 = DARK.toggleOff; bar.BorderSizePixel = 0; bar.Parent = cont
        local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(1, 0); bc.Parent = bar
        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((initial - min) / (max - min), 0, 1, 0)
        fill.BackgroundColor3 = DARK.accent; fill.BorderSizePixel = 0; fill.Parent = bar
        local fc = Instance.new("UICorner"); fc.CornerRadius = UDim.new(1, 0); fc.Parent = fill
        local dr = false
        local function upd(x)
            local p = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local v = min + (max - min) * p
            fill.Size = UDim2.new(p, 0, 1, 0)
            lbl.Text = label .. ":  " .. string.format("%.2f", v)
            cb(v)
        end
        bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dr = true; upd(input.Position.X) end
        end)
        UIS.InputChanged:Connect(function(input)
            if dr and input.UserInputType == Enum.UserInputType.MouseMovement then upd(input.Position.X) end
        end)
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dr = false end
        end)
    end

    local function makeModeSelector(parent, label, options, initial, cb)
        local cont = Instance.new("Frame")
        cont.Size = UDim2.new(1, 0, 0, 64)
        cont.BackgroundColor3 = DARK.item; cont.BorderSizePixel = 0
        cont.Parent = parent
        local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0, 8); cc.Parent = cont
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 0, 18); lbl.Position = UDim2.new(0, 14, 0, 6)
        lbl.BackgroundTransparency = 1; lbl.Text = label
        lbl.TextColor3 = DARK.text; lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = FONT; lbl.TextSize = 11; lbl.Parent = cont
        local bc2 = Instance.new("Frame")
        bc2.Size = UDim2.new(1, -28, 0, 30)
        bc2.Position = UDim2.new(0, 14, 0, 28)
        bc2.BackgroundTransparency = 1
        bc2.Parent = cont
        local bl = Instance.new("UIListLayout"); bl.FillDirection = Enum.FillDirection.Horizontal; bl.Padding = UDim.new(0, 6); bl.Parent = bc2
        local buttons = {}
        for _, opt in ipairs(options) do
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(0.5, -3, 1, 0)
            b.BackgroundColor3 = (initial == opt) and DARK.accent or DARK.toggleOff
            b.BorderSizePixel = 0
            b.Text = opt
            b.TextColor3 = (initial == opt) and Color3.new(1,1,1) or DARK.text
            b.Font = FONT
            b.TextSize = 11
            b.Parent = bc2
            local bc3 = Instance.new("UICorner"); bc3.CornerRadius = UDim.new(0, 6); bc3.Parent = b
            b.MouseButton1Click:Connect(function()
                for _, bb in ipairs(buttons) do
                    local isActive = (bb.Text == opt)
                    bb.BackgroundColor3 = isActive and DARK.accent or DARK.toggleOff
                    bb.TextColor3 = isActive and Color3.new(1,1,1) or DARK.text
                end
                cb(opt)
            end)
            table.insert(buttons, b)
        end
    end

    makeToggle(pages["Aimbot"], "Aimbot", CFG.Aimbot, function(v) CFG.Aimbot = v end)
    makeToggle(pages["Aimbot"], "Instant Lock", CFG.InstantLock, function(v) CFG.InstantLock = v end)
    makeToggle(pages["Aimbot"], "Prediction", CFG.Prediction, function(v) CFG.Prediction = v end)
    makeToggle(pages["Aimbot"], "Show FOV Circle", CFG.ShowFOV, function(v) CFG.ShowFOV = v end)
    makeModeSelector(pages["Aimbot"], "Aimbot Mode", {"Hold", "Toggle"}, CFG.AimbotMode, function(v) CFG.AimbotMode = v end)
    makeSlider(pages["Aimbot"], "FOV", 50, 800, CFG.FOV, function(v) CFG.FOV = v end)
    makeSlider(pages["Aimbot"], "Smoothness", 0, 1, CFG.Smoothness, function(v) CFG.Smoothness = v end)
    makeSlider(pages["Aimbot"], "Aimbot Range", 500, 5000, CFG.AimbotRange, function(v) CFG.AimbotRange = v end)

    makeToggle(pages["ESP"], "ESP Master", CFG.ESP, function(v) CFG.ESP = v end)
    makeToggle(pages["ESP"], "Lines (Snapline)", CFG.Lines, function(v) CFG.Lines = v end)
    makeToggle(pages["ESP"], "Skeleton", CFG.Skeleton, function(v) CFG.Skeleton = v end)
    makeToggle(pages["ESP"], "Box + HP Bar", CFG.Box, function(v) CFG.Box = v; CFG.HealthBar = v end)
    makeToggle(pages["ESP"], "Hitbox Circle", CFG.HitboxCircle, function(v) CFG.HitboxCircle = v end)
    makeToggle(pages["ESP"], "Show Name", CFG.Name, function(v) CFG.Name = v end)
    makeToggle(pages["ESP"], "Show Distance", CFG.Distance, function(v) CFG.Distance = v end)
    makeSlider(pages["ESP"], "Max Distance", 200, 5000, CFG.MaxDistance, function(v) CFG.MaxDistance = v end)

    makeToggle(pages["Misc"], "Triggerbot [E]", CFG.Trigger, function(v) CFG.Trigger = v end)
    makeSlider(pages["Misc"], "Trigger Delay", 0.01, 0.5, CFG.TDelay, function(v) CFG.TDelay = v end)
    makeToggle(pages["Misc"], "Anti-AFK", CFG.AntiAFK, function(v) CFG.AntiAFK = v end)

    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 160)
    info.BackgroundColor3 = DARK.item; info.BorderSizePixel = 0
    info.Text = "  540CHEATS v25\n\n  > Right Click = Aimbot (Hold)\n  > Q = Toggle Aimbot (Toggle mode)\n  > E = Triggerbot\n  > X = Toggle UI\n  > F1 = Show UI\n\n  - = Minimize | x = Close"
    info.TextColor3 = DARK.text; info.TextXAlignment = Enum.TextXAlignment.Left
    info.TextYAlignment = Enum.TextYAlignment.Top
    info.Font = FONT; info.TextSize = 12
    info.Parent = pages["Settings"]
    local ic = Instance.new("UICorner"); ic.CornerRadius = UDim.new(0, 8); ic.Parent = info

    minimizedLogo = Instance.new("TextButton")
    minimizedLogo.Size = UDim2.new(0, 50, 0, 50)
    minimizedLogo.Position = UDim2.new(0.5, -25, 0.5, -25)
    minimizedLogo.BackgroundColor3 = DARK.bg
    minimizedLogo.BackgroundTransparency = 0.2
    minimizedLogo.BorderSizePixel = 0
    minimizedLogo.Text = ""
    minimizedLogo.Visible = false
    minimizedLogo.Parent = gui
    local mlc = Instance.new("UICorner"); mlc.CornerRadius = UDim.new(0, 10); mlc.Parent = minimizedLogo
    local mls = Instance.new("UIStroke"); mls.Color = DARK.accent; mls.Thickness = 1.5; mls.Transparency = 0.3; mls.Parent = minimizedLogo

    local mlIcon = Instance.new("ImageLabel")
    mlIcon.Size = UDim2.new(0, 36, 0, 36)
    mlIcon.Position = UDim2.new(0.5, -18, 0.5, -18)
    mlIcon.BackgroundTransparency = 1
    mlIcon.Image = "rbxassetid://86571453491468"
    mlIcon.ScaleType = Enum.ScaleType.Fit
    mlIcon.Parent = minimizedLogo

    task.spawn(function()
        local ok, loaded = pcall(function() return mlIcon.IsLoaded end)
        if not ok or not loaded then
            task.wait(0.5)
            if not mlIcon.IsLoaded then
                mlIcon:Destroy()
                local e = Instance.new("TextLabel")
                e.Size = UDim2.new(1, 0, 1, 0); e.BackgroundTransparency = 1
                e.Text = "💠"; e.TextSize = 28; e.Font = FONT; e.TextColor3 = DARK.accent
                e.Parent = minimizedLogo
            end
        end
    end)

    minimizedLogo.MouseButton1Click:Connect(function()
        minimizedLogo.Visible = false
        main.Visible = true
    end)

    local watermark = Instance.new("TextLabel")
    watermark.Size = UDim2.new(0, 320, 0, 30)
    watermark.Position = UDim2.new(1, -340, 1, -50)
    watermark.BackgroundTransparency = 1
    watermark.Text = "540CHEATS | discord.gg/540shop"
    watermark.TextColor3 = DARK.accent
    watermark.TextXAlignment = Enum.TextXAlignment.Right
    watermark.Font = FONT
    watermark.TextSize = 14
    watermark.TextTransparency = 0.2
    watermark.TextStrokeTransparency = 0.4
    watermark.TextStrokeColor3 = Color3.new(0, 0, 0)
    watermark.Parent = gui

    notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 300, 0, 32)
    notif.Position = UDim2.new(0.5, -150, 0, -40)
    notif.BackgroundColor3 = DARK.bg
    notif.BackgroundTransparency = 0.15
    notif.TextColor3 = DARK.accent
    notif.Font = FONT
    notif.TextSize = 13
    notif.Visible = false
    notif.Parent = gui
    local nc = Instance.new("UICorner"); nc.CornerRadius = UDim.new(0, 8); nc.Parent = notif
    local ns = Instance.new("UIStroke"); ns.Color = DARK.accent; ns.Thickness = 1; ns.Parent = notif

    local function showNotif(text)
        notif.Text = "  > " .. text
        notif.Visible = true
        TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -150, 0, 20)}):Play()
        task.delay(1.5, function()
            TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -150, 0, -40)}):Play()
            task.wait(0.4); notif.Visible = false
        end)
    end

    UIS.InputBegan:Connect(function(i, g)
        if i.KeyCode == Enum.KeyCode.Q then
            if CFG.AimbotMode == "Toggle" then
                aimbotToggled = not aimbotToggled
                showNotif("Aimbot: " .. (aimbotToggled and "ON" or "OFF"))
            end
            return
        end
        if i.KeyCode == Enum.KeyCode.E then
            CFG.Trigger = not CFG.Trigger
            showNotif("Triggerbot: " .. (CFG.Trigger and "ON" or "OFF"))
            return
        end
        if i.KeyCode == Enum.KeyCode.X then
            if gui.Enabled then gui.Enabled = false
            else gui.Enabled = true; main.Visible = true; minimizedLogo.Visible = false end
            return
        end
        if i.KeyCode == Enum.KeyCode.F1 then
            gui.Enabled = true; main.Visible = true; minimizedLogo.Visible = false
            return
        end
        if g then return end
        if i.UserInputType == Enum.UserInputType.MouseButton2 then aiming = true end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton2 then aiming = false end
    end)

    print("[540CHEATS] Main script loaded successfully")
end

-- =====================================================
-- MAIN ENTRY
-- =====================================================
print("[540CHEATS] Initializing...")

local savedKey = getSavedKey()
if savedKey then
    print("[540CHEATS] Found saved key — validating...")
    local valid = validateKey(savedKey)
    if valid then
        print("[540CHEATS] OK Saved key valid")
        showLoadingScreen(function()
            local ok, err = pcall(runMainScript)
            if not ok then warn("[540CHEATS] Script error: " .. tostring(err)) end
        end)
    else
        print("[540CHEATS] X Saved key invalid — prompting")
        showKeyPrompt()
    end
else
    print("[540CHEATS] No saved key — prompting")
    showKeyPrompt()
end
