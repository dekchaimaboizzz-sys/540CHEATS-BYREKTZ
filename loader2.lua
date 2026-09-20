-- =====================================================
-- 540CHEATS | Anime Dice v9 - Recursive HUD Hide
-- =====================================================

local KEY_URL = "https://raw.githubusercontent.com/dekchaimaboizzz-sys/540CHEATS-BYREKTZ/refs/heads/main/keys.txt"

local FONT = Enum.Font.RobotoMono
local DARK = {
    bg = Color3.fromRGB(12, 12, 15), sidebar = Color3.fromRGB(15, 15, 20),
    header = Color3.fromRGB(18, 18, 24), headerAccent = Color3.fromRGB(0, 200, 255),
    item = Color3.fromRGB(25, 25, 30), text = Color3.fromRGB(220, 220, 230),
    subtext = Color3.fromRGB(120, 120, 135), accent = Color3.fromRGB(0, 200, 255),
    border = Color3.fromRGB(35, 35, 45), toggleOn = Color3.fromRGB(0, 150, 255),
    toggleOff = Color3.fromRGB(45, 45, 55), success = Color3.fromRGB(0, 200, 80),
    danger = Color3.fromRGB(200, 50, 60),
}

local TweenService = game:GetService("TweenService")
local function safeTween(i, d, p)
    if not i or not i.Parent then return end
    pcall(function() TweenService:Create(i, TweenInfo.new(d), p):Play() end)
end

local function validateKey(userKey)
    if not userKey or userKey == "" then return false, "ไม่มี key" end
    local ok, response = pcall(function() return game:HttpGet(KEY_URL, true) end)
    if not ok then return false, "เชื่อมต่อไม่สำเร็จ" end
    local clean = tostring(userKey):gsub("%s+", "")
    for line in response:gmatch("[^\r\n]+") do
        if line:gsub("%s+", "") == clean then return true end
    end
    return false, "Key ไม่ถูกต้อง"
end

-- =====================================================
-- ★★★ MAIN — ANIME DICE v9 ★★★
-- =====================================================
local function runMainScript()
    print("[540CHEATS] Anime Dice v9 starting...")

    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local RS = game:GetService("ReplicatedStorage")
    local LP = Players.LocalPlayer
    local PG = LP:WaitForChild("PlayerGui")

    local Network = RS:WaitForChild("Network", 10)
    local SetAutoRoll, RollDice
    if Network and Network:FindFirstChild("RollService") then
        local RSvc = Network.RollService
        if RSvc:FindFirstChild("RE") then SetAutoRoll = RSvc.RE:FindFirstChild("SetAutoRoll") end
        if RSvc:FindFirstChild("RF") then RollDice = RSvc.RF:FindFirstChild("RollDice") end
    end
    print("[540CHEATS] SetAutoRoll:", SetAutoRoll ~= nil, "| RollDice:", RollDice ~= nil)

    local CFG = {
        AutoRoll = false, RollDelay = 0.1,
        AutoHide = true,
        AutoSkip = false, AutoKeep = false,
        AutoUpgrade = false, UpgradeDelay = 1,
        AutoSell = false, AutoRebirth = false,
        RollCount = 0,
    }

    -- ===== บันทึกค่า Visible เดิมของทุก GuiObject =====
    local savedStates = {}

    local function recursiveHide(el, visible)
        if not el then return end
        
        -- ถ้าเป็น GuiObject ให้ set Visible
        if el:IsA("GuiObject") then
            local ok, vis = pcall(function() return el.Visible end)
            if ok then
                if savedStates[el] == nil then
                    savedStates[el] = vis
                end
                pcall(function() el.Visible = visible end)
            end
        end
        
        -- วน child ต่อ (ทั้ง Folder และ GuiObject)
        for _, child in ipairs(el:GetChildren()) do
            recursiveHide(child, visible)
        end
    end

    local function hideHUD()
        savedStates = {}
        local root = PG:FindFirstChild("Root")
        if not root then 
            print("[540CHEATS] Root not found!")
            return 
        end
        local hud = root:FindFirstChild("HUD")
        if not hud then 
            print("[540CHEATS] HUD not found!")
            return 
        end
        recursiveHide(hud, false)
        print("[540CHEATS] HUD hidden ✓")
    end

    local function showHUD()
        local count = 0
        for el, vis in pairs(savedStates) do
            if el and el.Parent then
                pcall(function() el.Visible = vis end)
                count = count + 1
            end
        end
        savedStates = {}
        print("[540CHEATS] HUD shown (" .. count .. " elements)")
    end

    -- ===== DEBUG: แสดงสถานะ HUD ทั้งหมด =====
    local function debugHUD()
        local root = PG:FindFirstChild("Root")
        local hud = root and root:FindFirstChild("HUD")
        if not hud then print("[DEBUG] No HUD"); return end
        print("[DEBUG] HUD children:")
        for _, child in ipairs(hud:GetChildren()) do
            local ok, vis = pcall(function() return child.Visible end)
            print("  " .. child.ClassName .. " | " .. child.Name .. " | Visible: " .. (ok and tostring(vis) or "N/A"))
        end
    end

    -- ===== SILENT CLICK =====
    local function silentClick(btn)
        if not btn then return false end
        local fired = false
        if getconnections then
            pcall(function()
                for _, conn in ipairs(getconnections(btn.Activated)) do
                    if conn.Enabled and conn.Function then
                        pcall(function() task.spawn(conn.Function) end)
                        fired = true
                    end
                end
                for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do
                    if conn.Enabled and conn.Function then
                        pcall(function() task.spawn(conn.Function) end)
                        fired = true
                    end
                end
            end)
        end
        return fired
    end

    local function findButton(name)
        for _, obj in ipairs(PG:GetDescendants()) do
            if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj.Name == name then
                if obj.Visible and obj.AbsoluteSize.X > 0 then return obj end
            end
        end
        return nil
    end

    -- ★ AUTO HIDE
    local lastHideState = nil
    task.spawn(function()
        while true do
            task.wait(0.3)
            local shouldHide = CFG.AutoRoll and CFG.AutoHide
            if shouldHide ~= lastHideState then
                lastHideState = shouldHide
                if shouldHide then
                    hideHUD()
                    task.wait(0.5)
                    debugHUD()
                else
                    showHUD()
                end
            end
        end
    end)

    -- ===== NATIVE AUTO ROLL =====
    local lastAutoRollState = nil
    task.spawn(function()
        while true do
            task.wait(0.5)
            if CFG.AutoRoll ~= lastAutoRollState then
                lastAutoRollState = CFG.AutoRoll
                if SetAutoRoll then
                    pcall(function()
                        SetAutoRoll:FireServer(CFG.AutoRoll)
                        print("[540CHEATS] SetAutoRoll →", CFG.AutoRoll)
                    end)
                end
            end
        end
    end)

    task.spawn(function()
        while true do
            task.wait(CFG.RollDelay)
            if CFG.AutoRoll and RollDice and not SetAutoRoll then
                pcall(function()
                    RollDice:InvokeServer()
                    CFG.RollCount = CFG.RollCount + 1
                end)
            end
        end
    end)

    task.spawn(function()
        while true do
            task.wait(0.2)
            if CFG.AutoSkip then
                local b = findButton("Skip")
                if b and b.Visible then silentClick(b) end
            end
            if CFG.AutoKeep then
                local b = findButton("Keep")
                if b and b.Visible then silentClick(b) end
            end
        end
    end)

    task.spawn(function()
        while true do
            task.wait(CFG.UpgradeDelay)
            if CFG.AutoUpgrade then
                local b = findButton("Upgrades")
                if b then
                    silentClick(b)
                    task.wait(0.5)
                    local h = findButton("Home")
                    if h then silentClick(h) end
                end
            end
        end
    end)

    task.spawn(function()
        while true do
            task.wait(1)
            if CFG.AutoSell then
                local b = findButton("Sell")
                if b and b.Visible then silentClick(b) end
            end
        end
    end)

    task.spawn(function()
        while true do
            task.wait(3)
            if CFG.AutoRebirth then
                local b = findButton("Rebirth")
                if b then silentClick(b) end
            end
        end
    end)

    -- =====================================================
    -- UI
    -- =====================================================
    local gui, main, minimizedLogo, userAvatar

    gui = Instance.new("ScreenGui")
    gui.Name = "540CHEATS_AnimeDice"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = PG

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
    headerTitle.Size = UDim2.new(0, 250, 0, 18)
    headerTitle.Position = UDim2.new(0, 58, 0, 10)
    headerTitle.BackgroundTransparency = 1
    headerTitle.Text = "540CHEATS | Anime Dice v9"
    headerTitle.TextColor3 = Color3.new(1, 1, 1)
    headerTitle.TextXAlignment = Enum.TextXAlignment.Left
    headerTitle.Font = FONT
    headerTitle.TextSize = 14
    headerTitle.Parent = header

    local headerSub = Instance.new("TextLabel")
    headerSub.Size = UDim2.new(0, 250, 0, 14)
    headerSub.Position = UDim2.new(0, 58, 0, 29)
    headerSub.BackgroundTransparency = 1
    headerSub.Text = "recursive-hide"
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
        if SetAutoRoll then pcall(function() SetAutoRoll:FireServer(false) end) end
        showHUD()
        pcall(function() gui:Destroy() end)
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

    createTab("Main", "🎲")
    createTab("Upgrades", "⬆️")
    createTab("Sell", "💰")
    createTab("Settings", "⚙️")

    tabs["Main"].BackgroundTransparency = 0
    tabs["Main"].BackgroundColor3 = DARK.item
    pages["Main"].Visible = true
    tabs["Main"]:FindFirstChild("TextLabel").TextColor3 = Color3.new(1, 1, 1)

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

    makeToggle(pages["Main"], "Auto Roll (Native)", CFG.AutoRoll, function(v) CFG.AutoRoll = v end)
    makeToggle(pages["Main"], "Auto Hide UI (Recursive)", CFG.AutoHide, function(v) CFG.AutoHide = v end)
    makeToggle(pages["Main"], "Auto Skip", CFG.AutoSkip, function(v) CFG.AutoSkip = v end)
    makeToggle(pages["Main"], "Auto Keep", CFG.AutoKeep, function(v) CFG.AutoKeep = v end)
    makeToggle(pages["Main"], "Auto Rebirth", CFG.AutoRebirth, function(v) CFG.AutoRebirth = v end)

    makeToggle(pages["Upgrades"], "Auto Upgrade", CFG.AutoUpgrade, function(v) CFG.AutoUpgrade = v end)
    makeSlider(pages["Upgrades"], "Upgrade Delay", 0.5, 5, CFG.UpgradeDelay, function(v) CFG.UpgradeDelay = v end)

    makeToggle(pages["Sell"], "Auto Sell", CFG.AutoSell, function(v) CFG.AutoSell = v end)

    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 240)
    info.BackgroundColor3 = DARK.item; info.BorderSizePixel = 0
    info.Text = "  540CHEATS | Anime Dice v9\n\n  ✓ Auto Roll (Native Remote)\n  ✓ Auto Hide UI (Recursive)\n  ✓ ซ่อนทุก Frame ใน Root.HUD\n  ✓ Debug print ใน Console\n  ✓ Auto Skip / Keep / Upgrade\n  ✓ Auto Sell / Rebirth\n\n  discord.gg/540shop"
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

    local watermark = Instance.new("TextLabel")
    watermark.Size = UDim2.new(0, 320, 0, 30)
    watermark.Position = UDim2.new(1, -340, 1, -50)
    watermark.BackgroundTransparency = 1
    watermark.Text = "540CHEATS | Anime Dice v9"
    watermark.TextColor3 = DARK.accent
    watermark.TextXAlignment = Enum.TextXAlignment.Right
    watermark.Font = FONT
    watermark.TextSize = 14
    watermark.TextTransparency = 0.2
    watermark.TextStrokeTransparency = 0.4
    watermark.TextStrokeColor3 = Color3.new(0, 0, 0)
    watermark.Parent = gui

    print("[540CHEATS] Anime Dice v9 loaded")
end

-- =====================================================
-- LOADING SCREEN
-- =====================================================
local function showLoadingScreen(callback)
    local ok, loadGui = pcall(function()
        local LP = game:GetService("Players").LocalPlayer
        local gui = Instance.new("ScreenGui")
        gui.Name = "540CHEATS_Loading"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 9999
        gui.Parent = LP:WaitForChild("PlayerGui")
        return gui
    end)
    if not ok or not loadGui then
        if callback then callback() end
        return
    end

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.3
    overlay.BorderSizePixel = 0
    overlay.Parent = loadGui

    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 420, 0, 220)
    card.Position = UDim2.new(0.5, -210, 0.5, -110)
    card.BackgroundColor3 = DARK.bg
    card.BorderSizePixel = 0
    card.Parent = loadGui
    local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0, 14); cc.Parent = card
    local cs = Instance.new("UIStroke"); cs.Color = DARK.accent; cs.Thickness = 2; cs.Parent = card

    local logoIcon = Instance.new("ImageLabel")
    logoIcon.Size = UDim2.new(0, 60, 0, 60)
    logoIcon.Position = UDim2.new(0.5, -30, 0, 20)
    logoIcon.BackgroundTransparency = 1
    logoIcon.Image = "rbxassetid://86571453491468"
    logoIcon.ScaleType = Enum.ScaleType.Fit
    logoIcon.Parent = card

    task.spawn(function()
        task.wait(0.5)
        if logoIcon.Parent and not logoIcon.IsLoaded then
            logoIcon:Destroy()
            local e = Instance.new("TextLabel")
            e.Size = UDim2.new(1, 0, 0, 60); e.Position = UDim2.new(0, 0, 0, 20)
            e.BackgroundTransparency = 1
            e.Text = "💠"; e.TextSize = 40; e.Font = FONT; e.TextColor3 = DARK.accent
            e.Parent = card
        end
    end)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 24)
    title.Position = UDim2.new(0, 0, 0, 90)
    title.BackgroundTransparency = 1
    title.Text = "540CHEATS | Anime Dice v9"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.Font = FONT
    title.TextSize = 20
    title.Parent = card

    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 16)
    subtitle.Position = UDim2.new(0, 0, 0, 115)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "discord.gg/540shop"
    subtitle.TextColor3 = DARK.subtext
    subtitle.TextXAlignment = Enum.TextXAlignment.Center
    subtitle.Font = FONT
    subtitle.TextSize = 11
    subtitle.Parent = card

    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(1, -60, 0, 10)
    barBg.Position = UDim2.new(0, 30, 0, 150)
    barBg.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    barBg.BorderSizePixel = 0
    barBg.Parent = card
    local bbc = Instance.new("UICorner"); bbc.CornerRadius = UDim.new(1, 0); bbc.Parent = barBg

    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = DARK.accent
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    local bfc = Instance.new("UICorner"); bfc.CornerRadius = UDim.new(1, 0); bfc.Parent = barFill

    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, -60, 0, 16)
    statusText.Position = UDim2.new(0, 30, 0, 168)
    statusText.BackgroundTransparency = 1
    statusText.Text = "> Loading..."
    statusText.TextColor3 = DARK.subtext
    statusText.TextXAlignment = Enum.TextXAlignment.Left
    statusText.Font = FONT
    statusText.TextSize = 11
    statusText.Parent = card

    local percentLabel = Instance.new("TextLabel")
    percentLabel.Size = UDim2.new(0, 60, 0, 16)
    percentLabel.Position = UDim2.new(1, -90, 0, 168)
    percentLabel.BackgroundTransparency = 1
    percentLabel.Text = "0%"
    percentLabel.TextColor3 = DARK.accent
    percentLabel.TextXAlignment = Enum.TextXAlignment.Right
    percentLabel.Font = FONT
    percentLabel.TextSize = 11
    percentLabel.Parent = card

    task.spawn(function()
        task.wait(0.3)
        local steps = {
            { pct = 25, text = "> Loading", wait = 0.4 },
            { pct = 50, text = "> Preparing", wait = 0.4 },
            { pct = 75, text = "> Connecting", wait = 0.4 },
            { pct = 100, text = "> Ready!", wait = 0.5 },
        }
        local cur = 0
        for _, step in ipairs(steps) do
            statusText.Text = step.text
            local tgt = step.pct
            local dur = step.wait
            local frames = math.max(1, math.floor(dur * 60))
            for i = 1, frames do
                task.wait(dur / frames)
                local p = i / frames
                local c = math.floor(cur + (tgt - cur) * p)
                percentLabel.Text = c .. "%"
                barFill.Size = UDim2.new(c / 100, 0, 1, 0)
            end
            percentLabel.Text = tgt .. "%"
            barFill.Size = UDim2.new(tgt / 100, 0, 1, 0)
            cur = tgt
        end
        task.wait(0.3)
        pcall(function() loadGui:Destroy() end)
        if callback then callback() end
    end)
end

-- =====================================================
-- KEY PROMPT
-- =====================================================
local function showKeyPrompt()
    local LP = game:GetService("Players").LocalPlayer
    local PG = LP:WaitForChild("PlayerGui")

    for _, g in ipairs(PG:GetChildren()) do
        if g.Name == "540CHEATS_Key" then pcall(function() g:Destroy() end) end
    end

    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "540CHEATS_Key"
    keyGui.ResetOnSpawn = false
    keyGui.IgnoreGuiInset = true
    keyGui.DisplayOrder = 99999
    keyGui.Enabled = true
    pcall(function() keyGui.Parent = PG end)
    if not keyGui.Parent then pcall(function() keyGui.Parent = game:GetService("CoreGui") end) end
    if not keyGui.Parent then return end

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.4
    overlay.BorderSizePixel = 0
    overlay.Parent = keyGui

    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 420, 0, 280)
    card.Position = UDim2.new(0.5, -210, 0.5, -140)
    card.BackgroundColor3 = DARK.bg
    card.BorderSizePixel = 0
    card.Parent = keyGui
    local bgc = Instance.new("UICorner"); bgc.CornerRadius = UDim.new(0, 14); bgc.Parent = card
    local bgs = Instance.new("UIStroke"); bgs.Color = DARK.accent; bgs.Thickness = 2; bgs.Parent = card

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 54)
    header.BackgroundColor3 = DARK.header
    header.BorderSizePixel = 0
    header.Parent = card
    local hc = Instance.new("UICorner"); hc.CornerRadius = UDim.new(0, 14); hc.Parent = header

    local hbBottom = Instance.new("Frame")
    hbBottom.Size = UDim2.new(1, 0, 0, 12)
    hbBottom.Position = UDim2.new(0, 0, 1, -12)
    hbBottom.BackgroundColor3 = DARK.header
    hbBottom.BorderSizePixel = 0
    hbBottom.Parent = header

    local logoBg = Instance.new("Frame")
    logoBg.Size = UDim2.new(0, 34, 0, 34)
    logoBg.Position = UDim2.new(0, 14, 0, 10)
    logoBg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    logoBg.BorderSizePixel = 0
    logoBg.Parent = header
    local lbgc = Instance.new("UICorner"); lbgc.CornerRadius = UDim.new(0, 8); lbgc.Parent = logoBg
    local lbgs = Instance.new("UIStroke"); lbgs.Color = DARK.headerAccent; lbgs.Thickness = 1; lbgs.Transparency = 0.5; lbgs.Parent = logoBg

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 26, 0, 26)
    icon.Position = UDim2.new(0.5, -13, 0.5, -13)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://86571453491468"
    icon.ScaleType = Enum.ScaleType.Fit
    icon.Parent = logoBg

    task.spawn(function()
        task.wait(0.5)
        if icon.Parent and not icon.IsLoaded then
            icon:Destroy()
            local e = Instance.new("TextLabel")
            e.Size = UDim2.new(1, 0, 1, 0); e.BackgroundTransparency = 1
            e.Text = "💠"; e.TextSize = 20; e.Font = FONT; e.TextColor3 = DARK.accent
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
    desc.Parent = card

    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, -40, 0, 44)
    inputFrame.Position = UDim2.new(0, 20, 0, 98)
    inputFrame.BackgroundColor3 = DARK.item
    inputFrame.BorderSizePixel = 0
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
    input.Parent = inputFrame

    local realKey = ""
    local isUpdating = false
    input:GetPropertyChangedSignal("Text"):Connect(function()
        if isUpdating then return end
        isUpdating = true
        local cur = input.Text
        local cl = #cur
        local rl = #realKey
        if cl > rl then
            local add = cur:sub(rl + 1):gsub("%*", "")
            realKey = realKey .. add
        elseif cl < rl then
            realKey = realKey:sub(1, cl)
        else
            local exp = string.rep("*", rl)
            if cur ~= exp and cur ~= "" then realKey = cur:gsub("%*", "") end
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
    footer.Parent = card

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
                    local ok2, err = pcall(runMainScript)
                    if not ok2 then warn("[540CHEATS] Error: " .. tostring(err)) end
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
end

-- =====================================================
-- MAIN ENTRY
-- =====================================================
print("[540CHEATS] Initializing Anime Dice v9...")
showKeyPrompt()
