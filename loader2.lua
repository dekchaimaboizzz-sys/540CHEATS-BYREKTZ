-- =====================================================
-- 540CHEATS | Anime Dice Edition
-- =====================================================

local KEY_URL = "https://raw.githubusercontent.com/dekchaimaboizzz-sys/540CHEATS-BYREKTZ/refs/heads/main/keys.txt"

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

local function safeTween(instance, duration, props)
    if not instance or not instance.Parent then return end
    pcall(function()
        TweenService:Create(instance, TweenInfo.new(duration), props):Play()
    end)
end

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

-- =====================================================
-- ★★★ MAIN SCRIPT — ANIME DICE ★★★
-- =====================================================
local function runMainScript()
    print("[540CHEATS] Anime Dice script starting...")

    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local WS = workspace
    local LP = Players.LocalPlayer

    local VIM = nil
    pcall(function() VIM = game:GetService("VirtualInputManager") end)

    local CFG = {
        -- Auto Roll
        AutoRoll = false,
        RollDelay = 0.5,
        
        -- Auto Upgrade
        AutoUpgrade = false,
        UpgradeDelay = 1,
        
        -- Auto Sell
        AutoSell = false,
        SellRarity = "Common",
        
        -- Auto Rebirth
        AutoRebirth = false,
        
        -- Webhook
        Webhook = "",
        
        -- ESP (optional)
        ESP = false,
    }

    local gui, main, minimizedLogo, notif
    local userAvatar

    -- =====================================================
    -- ★★★ AUTO FUNCTIONS ★★★
    -- =====================================================

    -- Auto Roll
    task.spawn(function()
        while true do
            task.wait(CFG.RollDelay)
            if CFG.AutoRoll then
                pcall(function()
                    -- หาปุ่ม Roll
                    local rollBtn = nil
                    for _, obj in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                        if obj:IsA("TextButton") and (obj.Text:lower():find("roll") or obj.Text:lower():find("spin")) then
                            rollBtn = obj
                            break
                        end
                    end
                    if rollBtn then
                        rollBtn:Click()
                        print("[540CHEATS] Auto Roll")
                    end
                end)
            end
        end
    end)

    -- Auto Upgrade
    task.spawn(function()
        while true do
            task.wait(CFG.UpgradeDelay)
            if CFG.AutoUpgrade then
                pcall(function()
                    local upgradeBtn = nil
                    for _, obj in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                        if obj:IsA("TextButton") and obj.Text:lower():find("upgrade") then
                            upgradeBtn = obj
                            break
                        end
                    end
                    if upgradeBtn then
                        upgradeBtn:Click()
                        print("[540CHEATS] Auto Upgrade")
                    end
                end)
            end
        end
    end)

    -- Auto Sell
    task.spawn(function()
        while true do
            task.wait(1)
            if CFG.AutoSell then
                pcall(function()
                    local sellBtn = nil
                    for _, obj in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                        if obj:IsA("TextButton") and obj.Text:lower():find("sell") then
                            sellBtn = obj
                            break
                        end
                    end
                    if sellBtn then
                        sellBtn:Click()
                        print("[540CHEATS] Auto Sell")
                    end
                end)
            end
        end
    end)

    -- Auto Rebirth
    task.spawn(function()
        while true do
            task.wait(5)
            if CFG.AutoRebirth then
                pcall(function()
                    local rebirthBtn = nil
                    for _, obj in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                        if obj:IsA("TextButton") and obj.Text:lower():find("rebirth") then
                            rebirthBtn = obj
                            break
                        end
                    end
                    if rebirthBtn then
                        rebirthBtn:Click()
                        print("[540CHEATS] Auto Rebirth")
                    end
                end)
            end
        end
    end)

    -- =====================================================
    -- ★★★ UI — VALEN HUB STYLE ★★★
    -- =====================================================
    gui = Instance.new("ScreenGui")
    gui.Name = "540CHEATS_AnimeDice"
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
    main.Parent = gui
    local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0, 12); mc.Parent = main
    local ms = Instance.new("UIStroke"); ms.Color = DARK.border; ms.Thickness = 1; ms.Parent = main

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
        task.wait(0.5)
        if headerIcon.Parent and not headerIcon.IsLoaded then
            headerIcon:Destroy()
            local e = Instance.new("TextLabel")
            e.Size = UDim2.new(1, 0, 1, 0); e.BackgroundTransparency = 1
            e.Text = "💠"; e.TextSize = 20; e.Font = FONT; e.TextColor3 = DARK.accent
            e.Parent = logoBg
        end
    end)

    local headerTitle = Instance.new("TextLabel")
    headerTitle.Size = UDim2.new(0, 200, 0, 18)
    headerTitle.Position = UDim2.new(0, 58, 0, 10)
    headerTitle.BackgroundTransparency = 1
    headerTitle.Text = "540CHEATS | Anime Dice"
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
    closeBtn.MouseButton1Click:Connect(function()
        pcall(function() gui:Destroy() end)
        print("[540CHEATS] ปิดสคริปต์แล้ว")
    end)

    -- Sidebar
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

    createTab("Main", "🎲")
    createTab("Upgrades", "⬆️")
    createTab("Sell", "💰")
    createTab("Settings", "⚙️")

    tabs["Main"].BackgroundTransparency = 0
    tabs["Main"].BackgroundColor3 = DARK.item
    pages["Main"].Visible = true
    tabs["Main"]:FindFirstChild("TextLabel").TextColor3 = Color3.new(1, 1, 1)

    -- User Panel
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
        pcall(function()
            local thumb = Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
            if thumb then userAvatar.Image = thumb end
        end)
    end)

    -- UI Helpers
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
            safeTween(k, 0.15, {Position = st and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)})
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

    -- Main Tab
    makeToggle(pages["Main"], "Auto Roll", CFG.AutoRoll, function(v) CFG.AutoRoll = v end)
    makeSlider(pages["Main"], "Roll Delay", 0.1, 2, CFG.RollDelay, function(v) CFG.RollDelay = v end)
    makeToggle(pages["Main"], "Auto Rebirth", CFG.AutoRebirth, function(v) CFG.AutoRebirth = v end)

    -- Upgrades Tab
    makeToggle(pages["Upgrades"], "Auto Upgrade", CFG.AutoUpgrade, function(v) CFG.AutoUpgrade = v end)
    makeSlider(pages["Upgrades"], "Upgrade Delay", 0.5, 5, CFG.UpgradeDelay, function(v) CFG.UpgradeDelay = v end)

    -- Sell Tab
    makeToggle(pages["Sell"], "Auto Sell", CFG.AutoSell, function(v) CFG.AutoSell = v end)

    -- Settings Tab
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 160)
    info.BackgroundColor3 = DARK.item; info.BorderSizePixel = 0
    info.Text = "  540CHEATS | Anime Dice\n\n  > Auto Roll: เปิด/ปิด\n  > Auto Upgrade: เปิด/ปิด\n  > Auto Sell: เปิด/ปิด\n  > Auto Rebirth: เปิด/ปิด\n\n  discord.gg/540shop"
    info.TextColor3 = DARK.text; info.TextXAlignment = Enum.TextXAlignment.Left
    info.TextYAlignment = Enum.TextYAlignment.Top
    info.Font = FONT; info.TextSize = 12
    info.Parent = pages["Settings"]
    local ic = Instance.new("UICorner"); ic.CornerRadius = UDim.new(0, 8); ic.Parent = info

    -- Minimized Logo
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
        task.wait(0.5)
        if mlIcon.Parent and not mlIcon.IsLoaded then
            mlIcon:Destroy()
            local e = Instance.new("TextLabel")
            e.Size = UDim2.new(1, 0, 1, 0); e.BackgroundTransparency = 1
            e.Text = "💠"; e.TextSize = 28; e.Font = FONT; e.TextColor3 = DARK.accent
            e.Parent = minimizedLogo
        end
    end)

    minimizedLogo.MouseButton1Click:Connect(function()
        minimizedLogo.Visible = false
        main.Visible = true
    end)

    -- Watermark
    local watermark = Instance.new("TextLabel")
    watermark.Size = UDim2.new(0, 320, 0, 30)
    watermark.Position = UDim2.new(1, -340, 1, -50)
    watermark.BackgroundTransparency = 1
    watermark.Text = "540CHEATS | Anime Dice"
    watermark.TextColor3 = DARK.accent
    watermark.TextXAlignment = Enum.TextXAlignment.Right
    watermark.Font = FONT
    watermark.TextSize = 14
    watermark.TextTransparency = 0.2
    watermark.TextStrokeTransparency = 0.4
    watermark.TextStrokeColor3 = Color3.new(0, 0, 0)
    watermark.Parent = gui

    print("[540CHEATS] Anime Dice script loaded successfully")
end

-- =====================================================
-- ★★★ LOADING SCREEN ★★★
-- =====================================================
local function showLoadingScreen(callback)
    local ok, loadGui = pcall(function()
        local LP = game:GetService("Players").LocalPlayer
        local playerGui = LP:WaitForChild("PlayerGui")
        local gui = Instance.new("ScreenGui")
        gui.Name = "540CHEATS_Loading"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 9999
        gui.Parent = playerGui
        return gui
    end)
    if not ok or not loadGui then
        if callback then callback() end
        return
    end

    local isDestroyed = false
    local card, overlay, title, subtitle, barBg, barFill
    local statusText, percentLabel, footer, logoIcon

    local setup = pcall(function()
        overlay = Instance.new("Frame")
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        overlay.BackgroundTransparency = 0.3
        overlay.BorderSizePixel = 0
        overlay.Parent = loadGui

        card = Instance.new("Frame")
        card.Size = UDim2.new(0, 420, 0, 220)
        card.Position = UDim2.new(0.5, -210, 0.5, -110)
        card.BackgroundColor3 = DARK.bg
        card.BorderSizePixel = 0
        card.Parent = loadGui
        local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0, 14); cc.Parent = card
        local cs = Instance.new("UIStroke"); cs.Color = DARK.accent; cs.Thickness = 2; cs.Parent = card

        logoIcon = Instance.new("ImageLabel")
        logoIcon.Size = UDim2.new(0, 60, 0, 60)
        logoIcon.Position = UDim2.new(0.5, -30, 0, 20)
        logoIcon.BackgroundTransparency = 1
        logoIcon.Image = "rbxassetid://86571453491468"
        logoIcon.ScaleType = Enum.ScaleType.Fit
        logoIcon.Parent = card

        task.spawn(function()
            task.wait(0.5)
            if isDestroyed or not logoIcon or not logoIcon.Parent then return end
            if not logoIcon.IsLoaded then
                pcall(function() logoIcon:Destroy() end)
                local e = Instance.new("TextLabel")
                e.Size = UDim2.new(1, 0, 0, 60); e.Position = UDim2.new(0, 0, 0, 20)
                e.BackgroundTransparency = 1
                e.Text = "💠"; e.TextSize = 40; e.Font = FONT; e.TextColor3 = DARK.accent
                e.Parent = card
            end
        end)

        title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 24)
        title.Position = UDim2.new(0, 0, 0, 90)
        title.BackgroundTransparency = 1
        title.Text = "540CHEATS | Anime Dice"
        title.TextColor3 = Color3.new(1, 1, 1)
        title.TextXAlignment = Enum.TextXAlignment.Center
        title.Font = FONT
        title.TextSize = 20
        title.Parent = card

        subtitle = Instance.new("TextLabel")
        subtitle.Size = UDim2.new(1, 0, 0, 16)
        subtitle.Position = UDim2.new(0, 0, 0, 115)
        subtitle.BackgroundTransparency = 1
        subtitle.Text = "discord.gg/540shop"
        subtitle.TextColor3 = DARK.subtext
        subtitle.TextXAlignment = Enum.TextXAlignment.Center
        subtitle.Font = FONT
        subtitle.TextSize = 11
        subtitle.Parent = card

        barBg = Instance.new("Frame")
        barBg.Size = UDim2.new(1, -60, 0, 10)
        barBg.Position = UDim2.new(0, 30, 0, 150)
        barBg.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        barBg.BorderSizePixel = 0
        barBg.Parent = card
        local bbc = Instance.new("UICorner"); bbc.CornerRadius = UDim.new(1, 0); bbc.Parent = barBg

        barFill = Instance.new("Frame")
        barFill.Size = UDim2.new(0, 0, 1, 0)
        barFill.BackgroundColor3 = DARK.accent
        barFill.BorderSizePixel = 0
        barFill.Parent = barBg
        local bfc = Instance.new("UICorner"); bfc.CornerRadius = UDim.new(1, 0); bfc.Parent = barFill

        statusText = Instance.new("TextLabel")
        statusText.Size = UDim2.new(1, -60, 0, 16)
        statusText.Position = UDim2.new(0, 30, 0, 168)
        statusText.BackgroundTransparency = 1
        statusText.Text = "> Loading..."
        statusText.TextColor3 = DARK.subtext
        statusText.TextXAlignment = Enum.TextXAlignment.Left
        statusText.Font = FONT
        statusText.TextSize = 11
        statusText.Parent = card

        percentLabel = Instance.new("TextLabel")
        percentLabel.Size = UDim2.new(0, 60, 0, 16)
        percentLabel.Position = UDim2.new(1, -90, 0, 168)
        percentLabel.BackgroundTransparency = 1
        percentLabel.Text = "0%"
        percentLabel.TextColor3 = DARK.accent
        percentLabel.TextXAlignment = Enum.TextXAlignment.Right
        percentLabel.Font = FONT
        percentLabel.TextSize = 11
        percentLabel.Parent = card

        footer = Instance.new("TextLabel")
        footer.Size = UDim2.new(1, -60, 0, 14)
        footer.Position = UDim2.new(0, 30, 1, -24)
        footer.BackgroundTransparency = 1
        footer.Text = "540CHEATS © discord.gg/540shop"
        footer.TextColor3 = DARK.subtext
        footer.TextXAlignment = Enum.TextXAlignment.Left
        footer.Font = FONT
        footer.TextSize = 9
        footer.Parent = card
    end)

    if not setup then
        pcall(function() loadGui:Destroy() end)
        if callback then callback() end
        return
    end

    task.spawn(function()
        task.wait(0.3)
        if isDestroyed then return end

        local steps = {
            { pct = 25, text = "> Loading Anime Dice modules", wait = 0.4 },
            { pct = 50, text = "> Preparing UI", wait = 0.4 },
            { pct = 75, text = "> Loading Auto Roll", wait = 0.4 },
            { pct = 100, text = "> Ready!", wait = 0.5 },
        }

        local currentPct = 0
        for _, step in ipairs(steps) do
            if isDestroyed then return end
            if statusText and statusText.Parent then statusText.Text = step.text end
            local targetPct = step.pct
            local startPct = currentPct
            local duration = step.wait
            local frames = math.max(1, math.floor(duration * 60))

            for i = 1, frames do
                if isDestroyed then return end
                task.wait(duration / frames)
                local p = i / frames
                local curr = math.floor(startPct + (targetPct - startPct) * p)
                if percentLabel and percentLabel.Parent then percentLabel.Text = curr .. "%" end
                if barFill and barFill.Parent then barFill.Size = UDim2.new(curr / 100, 0, 1, 0) end
            end

            if percentLabel and percentLabel.Parent then percentLabel.Text = targetPct .. "%" end
            if barFill and barFill.Parent then barFill.Size = UDim2.new(targetPct / 100, 0, 1, 0) end
            currentPct = targetPct
        end

        task.wait(0.3)
        isDestroyed = true
        pcall(function() loadGui:Destroy() end)
        if callback then callback() end
    end)
end

-- =====================================================
-- ★★★ KEY PROMPT ★★★
-- =====================================================
local function showKeyPrompt()
    print("[540CHEATS] Showing key prompt...")

    local LP = game:GetService("Players").LocalPlayer
    local playerGui = LP:WaitForChild("PlayerGui")

    for _, g in ipairs(playerGui:GetChildren()) do
        if g.Name == "540CHEATS_Key" then
            pcall(function() g:Destroy() end)
        end
    end

    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "540CHEATS_Key"
    keyGui.ResetOnSpawn = false
    keyGui.IgnoreGuiInset = true
    keyGui.DisplayOrder = 99999
    keyGui.Enabled = true

    local parentOk = pcall(function() keyGui.Parent = playerGui end)
    if not parentOk or not keyGui.Parent then
        pcall(function() keyGui.Parent = game:GetService("CoreGui") end)
    end

    if not keyGui.Parent then
        warn("[540CHEATS] ไม่สามารถสร้าง Key GUI ได้")
        return
    end

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.4
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1
    overlay.Parent = keyGui

    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 420, 0, 280)
    card.Position = UDim2.new(0.5, -210, 0.5, -140)
    card.BackgroundColor3 = DARK.bg
    card.BorderSizePixel = 0
    card.ZIndex = 10
    card.Parent = keyGui
    local bgc = Instance.new("UICorner"); bgc.CornerRadius = UDim.new(0, 14); bgc.Parent = card
    local bgs = Instance.new("UIStroke"); bgs.Color = DARK.accent; bgs.Thickness = 2; bgs.Parent = card

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 54)
    header.BackgroundColor3 = DARK.header
    header.BorderSizePixel = 0
    header.ZIndex = 11
    header.Parent = card
    local hc = Instance.new("UICorner"); hc.CornerRadius = UDim.new(0, 14); hc.Parent = header

    local hbBottom = Instance.new("Frame")
    hbBottom.Size = UDim2.new(1, 0, 0, 12)
    hbBottom.Position = UDim2.new(0, 0, 1, -12)
    hbBottom.BackgroundColor3 = DARK.header
    hbBottom.BorderSizePixel = 0
    hbBottom.ZIndex = 11
    hbBottom.Parent = header

    local logoBg = Instance.new("Frame")
    logoBg.Size = UDim2.new(0, 34, 0, 34)
    logoBg.Position = UDim2.new(0, 14, 0, 10)
    logoBg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    logoBg.BorderSizePixel = 0
    logoBg.ZIndex = 12
    logoBg.Parent = header
    local lbgc = Instance.new("UICorner"); lbgc.CornerRadius = UDim.new(0, 8); lbgc.Parent = logoBg
    local lbgs = Instance.new("UIStroke"); lbgs.Color = DARK.headerAccent; lbgs.Thickness = 1; lbgs.Transparency = 0.5; lbgs.Parent = logoBg

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 26, 0, 26)
    icon.Position = UDim2.new(0.5, -13, 0.5, -13)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://86571453491468"
    icon.ScaleType = Enum.ScaleType.Fit
    icon.ZIndex = 13
    icon.Parent = logoBg

    task.spawn(function()
        task.wait(0.5)
        if icon.Parent and not icon.IsLoaded then
            icon:Destroy()
            local e = Instance.new("TextLabel")
            e.Size = UDim2.new(1, 0, 1, 0); e.BackgroundTransparency = 1
            e.Text = "💠"; e.TextSize = 20; e.Font = FONT; e.TextColor3 = DARK.accent
            e.ZIndex = 13
            e.Parent = logoBg
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
    title.ZIndex = 12
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
    subtitle.ZIndex = 12
    subtitle.Parent = header

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -40, 0, 20)
    desc.Position = UDim2.new(0, 20, 0, 68)
    desc.BackgroundTransparency = 1
    desc.Text = "> Enter your key from discord.gg/540shop"
    desc.TextColor3 = DARK.subtext
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Font = FONT
    desc.TextSize = 11
    desc.ZIndex = 11
    desc.Parent = card

    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, -40, 0, 44)
    inputFrame.Position = UDim2.new(0, 20, 0, 98)
    inputFrame.BackgroundColor3 = DARK.item
    inputFrame.BorderSizePixel = 0
    inputFrame.ZIndex = 11
    inputFrame.Parent = card
    local ifc = Instance.new("UICorner"); ifc.CornerRadius = UDim.new(0, 8); ifc.Parent = inputFrame
    local ifs = Instance.new("UIStroke"); ifs.Color = DARK.border; ifs.Thickness = 1; ifs.Parent = inputFrame

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
    input.ZIndex = 12
    input.Parent = inputFrame

    local realKey = ""
    local isUpdating = false

    input:GetPropertyChangedSignal("Text"):Connect(function()
        if isUpdating then return end
        isUpdating = true

        local current = input.Text
        local currentLen = #current
        local realLen = #realKey

        if currentLen > realLen then
            local added = current:sub(realLen + 1)
            added = added:gsub("%*", "")
            realKey = realKey .. added
        elseif currentLen < realLen then
            realKey = realKey:sub(1, currentLen)
        else
            local expectedMask = string.rep("*", realLen)
            if current ~= expectedMask and current ~= "" then
                realKey = current:gsub("%*", "")
            end
        end

        input.Text = string.rep("*", #realKey)
        isUpdating = false
    end)

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -40, 0, 20)
    status.Position = UDim2.new(0, 20, 0, 152)
    status.BackgroundTransparency = 1
    status.Text = ""
    status.TextColor3 = DARK.subtext
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.Font = FONT
    status.TextSize = 11
    status.ZIndex = 11
    status.Parent = card

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -40, 0, 48)
    btn.Position = UDim2.new(0, 20, 0, 180)
    btn.BackgroundColor3 = DARK.toggleOn
    btn.BorderSizePixel = 0
    btn.Text = "CONFIRM KEY"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = FONT
    btn.TextSize = 13
    btn.ZIndex = 11
    btn.Parent = card
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 8); bc.Parent = btn

    local footer = Instance.new("TextLabel")
    footer.Size = UDim2.new(1, -40, 0, 16)
    footer.Position = UDim2.new(0, 20, 1, -26)
    footer.BackgroundTransparency = 1
    footer.Text = "540CHEATS © discord.gg/540shop"
    footer.TextColor3 = DARK.subtext
    footer.TextXAlignment = Enum.TextXAlignment.Center
    footer.Font = FONT
    footer.TextSize = 10
    footer.ZIndex = 11
    footer.Parent = card

    btn.MouseEnter:Connect(function()
        safeTween(btn, 0.15, {BackgroundColor3 = Color3.fromRGB(0, 180, 255)})
    end)
    btn.MouseLeave:Connect(function()
        safeTween(btn, 0.15, {BackgroundColor3 = DARK.toggleOn})
    end)

    local function trySubmit()
        local key = realKey:gsub("%s+", "")
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

                task.wait(2)
                pcall(function() keyGui:Destroy() end)

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
                realKey = ""
            end
        end)
    end

    btn.MouseButton1Click:Connect(trySubmit)
    input.FocusLost:Connect(function(enter)
        if enter then trySubmit() end
    end)

    print("[540CHEATS] Key prompt ready")
end

-- =====================================================
-- MAIN ENTRY
-- =====================================================
print("[540CHEATS] Initializing...")
print("[540CHEATS] Anime Dice Edition")

showKeyPrompt()
