-- 540CHEATS | v22 - Fixed Loaded Event
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local WS = workspace
local Cam = WS.CurrentCamera
local LP = Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

local CFG = {
    Aimbot = true, InstantLock = true, FOV = 250, MaxD = 3000,
    ESP = true, Name = true, Dist = true, HP = true, Colored = true,
    Trigger = false, TDelay = 0.05,
}

local aiming = false
local cache = {}
local enemies = {}

local DARK = {
    main = Color3.fromRGB(0, 150, 255),
    accent = Color3.fromRGB(0, 200, 255),
    bg = Color3.fromRGB(12, 12, 15),
    sidebar = Color3.fromRGB(15, 15, 20),
    item = Color3.fromRGB(25, 25, 30),
    text = Color3.fromRGB(220, 220, 230),
    subtext = Color3.fromRGB(120, 120, 135),
    border = Color3.fromRGB(35, 35, 45),
}

local gui = Instance.new("ScreenGui")
gui.Name = "540CHEATS_UI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = LP:WaitForChild("PlayerGui")

-- FOV
local fov = Instance.new("Frame")
fov.AnchorPoint = Vector2.new(0.5, 0.5)
fov.Position = UDim2.new(0.5, 0, 0.5, 0)
fov.Size = UDim2.new(0, CFG.FOV * 2, 0, CFG.FOV * 2)
fov.BackgroundTransparency = 1
fov.Parent = gui
local fc = Instance.new("UICorner"); fc.CornerRadius = UDim.new(1, 0); fc.Parent = fov
local fs = Instance.new("UIStroke"); fs.Color = DARK.accent; fs.Thickness = 2; fs.Transparency = 0.4; fs.Parent = fov

-- Crosshair
local cross = Instance.new("Frame")
cross.AnchorPoint = Vector2.new(0.5, 0.5)
cross.Position = UDim2.new(0.5, 0, 0.5, 0)
cross.Size = UDim2.new(0, 6, 0, 6)
cross.BackgroundColor3 = DARK.accent
cross.BorderSizePixel = 0
cross.Parent = gui
local cc2 = Instance.new("UICorner"); cc2.CornerRadius = UDim.new(1, 0); cc2.Parent = cross

-- Main
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 640, 0, 420)
main.Position = UDim2.new(0.5, -320, 0.5, -210)
main.BackgroundColor3 = DARK.bg
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui
local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0, 10); mc.Parent = main
local ms = Instance.new("UIStroke"); ms.Color = DARK.border; ms.Thickness = 1; ms.Parent = main

local dragging = false
local dragStart, startPos
main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = main.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local d = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 170, 1, 0)
sidebar.BackgroundColor3 = DARK.sidebar
sidebar.BorderSizePixel = 0
sidebar.Parent = main
local sbc = Instance.new("UICorner"); sbc.CornerRadius = UDim.new(0, 10); sbc.Parent = sidebar

-- Logo
local logoFrame = Instance.new("Frame")
logoFrame.Size = UDim2.new(1, 0, 0, 70)
logoFrame.BackgroundTransparency = 1
logoFrame.Parent = sidebar

local logoIcon = Instance.new("ImageLabel")
logoIcon.Size = UDim2.new(0, 44, 0, 44)
logoIcon.Position = UDim2.new(0, 12, 0, 12)
logoIcon.BackgroundTransparency = 1
logoIcon.Image = "rbxassetid://86571453491468"
logoIcon.ScaleType = Enum.ScaleType.Fit
logoIcon.Parent = logoFrame

-- ตรวจโหลดด้วย pcall — ไม่ใช้ Loaded event
task.delay(2, function()
    local ok, loaded = pcall(function() return logoIcon.IsLoaded end)
    if not ok or not loaded then
        logoIcon:Destroy()
        local emojiIcon = Instance.new("TextLabel")
        emojiIcon.Size = UDim2.new(0, 44, 0, 44)
        emojiIcon.Position = UDim2.new(0, 12, 0, 12)
        emojiIcon.BackgroundTransparency = 1
        emojiIcon.Text = "💠"
        emojiIcon.TextSize = 30
        emojiIcon.Font = Enum.Font.GothamBold
        emojiIcon.TextColor3 = Color3.fromRGB(0, 200, 255)
        emojiIcon.Parent = logoFrame
    end
end)

local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(0, 110, 0, 20)
logoText.Position = UDim2.new(0, 60, 0, 14)
logoText.BackgroundTransparency = 1
logoText.Text = "540CHEATS"
logoText.TextColor3 = Color3.new(1, 1, 1)
logoText.TextXAlignment = Enum.TextXAlignment.Left
logoText.Font = Enum.Font.GothamBold
logoText.TextSize = 14
logoText.Parent = logoFrame

local logoSub = Instance.new("TextLabel")
logoSub.Size = UDim2.new(0, 110, 0, 14)
logoSub.Position = UDim2.new(0, 60, 0, 34)
logoSub.BackgroundTransparency = 1
logoSub.Text = "discord.gg/540shop"
logoSub.TextColor3 = DARK.subtext
logoSub.TextXAlignment = Enum.TextXAlignment.Left
logoSub.Font = Enum.Font.Gotham
logoSub.TextSize = 10
logoSub.Parent = logoFrame

local sep = Instance.new("Frame")
sep.Size = UDim2.new(1, -20, 0, 1)
sep.Position = UDim2.new(0, 10, 0, 68)
sep.BackgroundColor3 = DARK.border
sep.BorderSizePixel = 0
sep.Parent = sidebar

-- Tabs
local tabs = {}
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 1, -120)
tabContainer.Position = UDim2.new(0, 0, 0, 78)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = sidebar
local tl = Instance.new("UIListLayout"); tl.Padding = UDim.new(0, 2); tl.Parent = tabContainer
local tp = Instance.new("UIPadding"); tp.PaddingLeft = UDim.new(0, 8); tp.PaddingRight = UDim.new(0, 8); tp.Parent = tabContainer

local pages = {}

local function createTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = DARK.item
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = tabContainer
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 6); bc.Parent = btn

    local ico = Instance.new("TextLabel")
    ico.Size = UDim2.new(0, 24, 0, 34)
    ico.Position = UDim2.new(0, 8, 0, 0)
    ico.BackgroundTransparency = 1
    ico.Text = icon
    ico.TextColor3 = DARK.subtext
    ico.TextXAlignment = Enum.TextXAlignment.Left
    ico.Font = Enum.Font.GothamBold
    ico.TextSize = 14
    ico.Parent = btn

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -36, 1, 0)
    lbl.Position = UDim2.new(0, 36, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = DARK.subtext
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.Parent = btn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -190, 1, -40)
    page.Position = UDim2.new(0, 180, 0, 24)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = DARK.main
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = main
    local pl = Instance.new("UIListLayout"); pl.Padding = UDim.new(0, 8); pl.Parent = page
    local pp = Instance.new("UIPadding"); pp.PaddingTop = UDim.new(0, 8); pp.PaddingRight = UDim.new(0, 8); pp.Parent = page

    tabs[name] = btn
    pages[name] = page

    btn.MouseButton1Click:Connect(function()
        for n, t in pairs(tabs) do
            t.BackgroundTransparency = 1
            pages[n].Visible = false
            t:FindFirstChildOfClass("TextLabel").TextColor3 = DARK.subtext
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
createTab("Trigger", "🔫")
createTab("Settings", "⚙️")

tabs["Aimbot"].BackgroundTransparency = 0
tabs["Aimbot"].BackgroundColor3 = DARK.item
pages["Aimbot"].Visible = true
tabs["Aimbot"]:FindFirstChildOfClass("TextLabel").TextColor3 = Color3.new(1, 1, 1)

local function makeToggle(parent, label, initial, cb)
    local cont = Instance.new("Frame")
    cont.Size = UDim2.new(1, 0, 0, 40)
    cont.BackgroundColor3 = DARK.item
    cont.BorderSizePixel = 0
    cont.Parent = parent
    local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0, 6); cc.Parent = cont

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = DARK.text
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.Parent = cont

    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 36, 0, 18)
    switch.Position = UDim2.new(1, -48, 0.5, -9)
    switch.BackgroundColor3 = initial and DARK.main or Color3.fromRGB(45, 45, 55)
    switch.BorderSizePixel = 0
    switch.Parent = cont
    local swc = Instance.new("UICorner"); swc.CornerRadius = UDim.new(1, 0); swc.Parent = switch

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = initial and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.BorderSizePixel = 0
    knob.Parent = switch
    local kc = Instance.new("UICorner"); kc.CornerRadius = UDim.new(1, 0); kc.Parent = knob

    local st = initial
    switch.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            st = not st
            switch.BackgroundColor3 = st and DARK.main or Color3.fromRGB(45, 45, 55)
            TweenService:Create(knob, TweenInfo.new(0.15), {
                Position = st and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
            }):Play()
            cb(st)
        end
    end)
end

local function makeSlider(parent, label, min, max, initial, cb)
    local cont = Instance.new("Frame")
    cont.Size = UDim2.new(1, 0, 0, 48)
    cont.BackgroundColor3 = DARK.item
    cont.BorderSizePixel = 0
    cont.Parent = parent
    local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0, 6); cc.Parent = cont

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 0, 18)
    lbl.Position = UDim2.new(0, 12, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = label .. ":  " .. string.format("%.2f", initial)
    lbl.TextColor3 = DARK.text
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.Parent = cont

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -24, 0, 6)
    bar.Position = UDim2.new(0, 12, 0, 30)
    bar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    bar.BorderSizePixel = 0
    bar.Parent = cont
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(1, 0); bc.Parent = bar

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((initial - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = DARK.main
    fill.BorderSizePixel = 0
    fill.Parent = bar
    local fc2 = Instance.new("UICorner"); fc2.CornerRadius = UDim.new(1, 0); fc2.Parent = fill

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

makeToggle(pages["Aimbot"], "Aimbot (Right Click)", CFG.Aimbot, function(v) CFG.Aimbot = v end)
makeToggle(pages["Aimbot"], "Instant Lock", CFG.InstantLock, function(v) CFG.InstantLock = v end)
makeSlider(pages["Aimbot"], "FOV", 50, 800, CFG.FOV, function(v) CFG.FOV = v; fov.Size = UDim2.new(0, v * 2, 0, v * 2) end)
makeSlider(pages["Aimbot"], "Max Distance", 100, 5000, CFG.MaxD, function(v) CFG.MaxD = v end)

makeToggle(pages["ESP"], "ESP (Highlight)", CFG.ESP, function(v) CFG.ESP = v end)
makeToggle(pages["ESP"], "Show Name", CFG.Name, function(v) CFG.Name = v end)
makeToggle(pages["ESP"], "Show Distance", CFG.Dist, function(v) CFG.Dist = v end)
makeToggle(pages["ESP"], "Show Health Bar", CFG.HP, function(v) CFG.HP = v end)
makeToggle(pages["ESP"], "Distance Colored", CFG.Colored, function(v) CFG.Colored = v end)

makeToggle(pages["Trigger"], "Triggerbot (Q)", CFG.Trigger, function(v) CFG.Trigger = v end)
makeSlider(pages["Trigger"], "Delay", 0.01, 0.5, CFG.TDelay, function(v) CFG.TDelay = v end)

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, 0, 0, 100)
info.BackgroundColor3 = DARK.item
info.BorderSizePixel = 0
info.Text = "  💠 540CHEATS v22\n\n  🖱️ Right Click = Aimbot\n  ⌨️ Q = Triggerbot\n  ⌨️ X = Toggle UI"
info.TextColor3 = DARK.text
info.TextXAlignment = Enum.TextXAlignment.Left
info.TextYAlignment = Enum.TextYAlignment.Top
info.Font = Enum.Font.Gotham
info.TextSize = 11
info.Parent = pages["Settings"]
local ic = Instance.new("UICorner"); ic.CornerRadius = UDim.new(0, 6); ic.Parent = info

local brandBox = Instance.new("TextLabel")
brandBox.Size = UDim2.new(1, 0, 0, 50)
brandBox.BackgroundColor3 = DARK.item
brandBox.BorderSizePixel = 0
brandBox.Text = "  💬 discord.gg/540shop"
brandBox.TextColor3 = DARK.accent
brandBox.TextXAlignment = Enum.TextXAlignment.Left
brandBox.TextYAlignment = Enum.TextYAlignment.Top
brandBox.Font = Enum.Font.GothamBold
brandBox.TextSize = 12
brandBox.Parent = pages["Settings"]
local brc = Instance.new("UICorner"); brc.CornerRadius = UDim.new(0, 6); brc.Parent = brandBox

task.spawn(function()
    while true do
        task.wait(0.3)
        local list = {}
        local my = LP.Character
        for _, obj in ipairs(WS:GetChildren()) do
            if obj:IsA("Model") and obj ~= my then
                local h = obj:FindFirstChildOfClass("Humanoid")
                local hd = obj:FindFirstChild("Head")
                local hrp = obj:FindFirstChild("HumanoidRootPart")
                if h and hd and hrp and h.Health > 0 then
                    table.insert(list, { model = obj, head = hd, hrp = hrp, hum = h, name = obj.Name })
                end
            end
        end
        enemies = list
    end
end)

local function getColor(d)
    if d < 50 then return Color3.fromRGB(0, 255, 100)
    elseif d < 150 then return Color3.fromRGB(255, 255, 0)
    elseif d < 400 then return Color3.fromRGB(255, 150, 0)
    else return Color3.fromRGB(255, 50, 50) end
end

local function makeESP(e)
    local key = e.model
    if cache[key] and cache[key].bb and cache[key].bb.Parent then return end
    local hl = Instance.new("Highlight")
    hl.Name = "_540_ESP"
    hl.FillColor = Color3.fromRGB(0, 255, 100)
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.7
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = e.model
    hl.Parent = e.model

    local bb = Instance.new("BillboardGui")
    bb.Adornee = e.head
    bb.Size = UDim2.new(0, 180, 0, 55)
    bb.StudsOffset = Vector3.new(0, 2.5, 0)
    bb.AlwaysOnTop = true
    bb.LightInfluence = 0
    bb.MaxDistance = 2000
    bb.Parent = e.model

    local nl = Instance.new("TextLabel", bb)
    nl.Size = UDim2.new(1, 0, 0.4, 0)
    nl.BackgroundTransparency = 1
    nl.TextColor3 = Color3.fromRGB(255, 255, 255)
    nl.TextStrokeTransparency = 0
    nl.TextStrokeColor3 = Color3.new(0, 0, 0)
    nl.Font = Enum.Font.GothamBold
    nl.TextScaled = true
    nl.Text = e.name

    local dl = Instance.new("TextLabel", bb)
    dl.Size = UDim2.new(1, 0, 0.3, 0)
    dl.Position = UDim2.new(0, 0, 0.4, 0)
    dl.BackgroundTransparency = 1
    dl.TextColor3 = Color3.fromRGB(0, 255, 100)
    dl.TextStrokeTransparency = 0
    dl.TextStrokeColor3 = Color3.new(0, 0, 0)
    dl.Font = Enum.Font.GothamBold
    dl.TextScaled = true
    dl.Text = "0m"

    local hpb = Instance.new("Frame", bb)
    hpb.Size = UDim2.new(0.7, 0, 0.15, 0)
    hpb.Position = UDim2.new(0.15, 0, 0.72, 0)
    hpb.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    hpb.BorderSizePixel = 0
    local hpc = Instance.new("UICorner", hpb); hpc.CornerRadius = UDim.new(1, 0)
    local hpf = Instance.new("Frame", hpb)
    hpf.Size = UDim2.new(1, 0, 1, 0)
    hpf.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    hpf.BorderSizePixel = 0
    local hpcf = Instance.new("UICorner", hpf); hpcf.CornerRadius = UDim.new(1, 0)

    cache[key] = { hl = hl, bb = bb, nl = nl, dl = dl, hpf = hpf }
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if not CFG.ESP then
            for k, d in pairs(cache) do
                if d.hl then pcall(function() d.hl:Destroy() end) end
                if d.bb then pcall(function() d.bb:Destroy() end) end
            end
            cache = {}
        else
            local my = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            for k, d in pairs(cache) do
                if not k.Parent then
                    if d.hl then pcall(function() d.hl:Destroy() end) end
                    if d.bb then pcall(function() d.bb:Destroy() end) end
                    cache[k] = nil
                end
            end
            for _, e in ipairs(enemies) do
                makeESP(e)
                local d = cache[e.model]
                if d and my then
                    local dist = math.floor((e.head.Position - my.Position).Magnitude)
                    local col = CFG.Colored and getColor(dist) or Color3.fromRGB(0, 255, 100)
                    if d.hl then d.hl.FillColor = col end
                    if d.dl then d.dl.TextColor3 = col end
                    if CFG.Name then d.nl.Text = e.name; d.nl.Visible = true else d.nl.Visible = false end
                    if CFG.Dist then d.dl.Text = dist .. "m"; d.dl.Visible = true else d.dl.Visible = false end
                    if CFG.HP and e.hum then
                        local hp = math.clamp(e.hum.Health / e.hum.MaxHealth, 0, 1)
                        d.hpf.Size = UDim2.new(hp, 0, 1, 0)
                        d.hpf.BackgroundColor3 = hp > 0.6 and Color3.fromRGB(0, 255, 100) or (hp > 0.3 and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(255, 50, 50))
                    end
                end
            end
        end
    end
end)

local function closest()
    if not CFG.Aimbot then return nil end
    local cl, sh = nil, math.huge
    local my = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not my then return nil end
    local ctr = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
    for _, e in ipairs(enemies) do
        local d3 = (e.head.Position - my.Position).Magnitude
        if d3 <= CFG.MaxD then
            local sp, on = Cam:WorldToViewportPoint(e.head.Position)
            if on then
                local dp = (Vector2.new(sp.X, sp.Y) - ctr).Magnitude
                if dp <= CFG.FOV and dp < sh then sh = dp; cl = e.head end
            end
        end
    end
    return cl
end

local function aimAt(t)
    if not t then return end
    if CFG.InstantLock then
        Cam.CFrame = CFrame.new(Cam.CFrame.Position, t.Position)
    else
        Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position, t.Position), 0.3)
    end
end

local lt = 0
local function trig()
    if not CFG.Trigger then return end
    if tick() - lt < CFG.TDelay then return end
    local t = closest()
    if not t then return end
    local sp, on = Cam:WorldToViewportPoint(t.Position)
    if not on then return end
    local ctr = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
    local dp = (Vector2.new(sp.X, sp.Y) - ctr).Magnitude
    if dp < 25 then
        lt = tick()
        pcall(function()
            VIM:SendMouseButtonEvent(ctr.X, ctr.Y, 0, true, game, 0)
            task.wait(0.01)
            VIM:SendMouseButtonEvent(ctr.X, ctr.Y, 0, false, game, 0)
        end)
    end
end

UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.UserInputType == Enum.UserInputType.MouseButton2 then aiming = true end
    if i.KeyCode == Enum.KeyCode.Q then CFG.Trigger = not CFG.Trigger end
    if i.KeyCode == Enum.KeyCode.X then main.Visible = not main.Visible end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton2 then aiming = false end
end)

RunService.RenderStepped:Connect(function()
    if aiming and CFG.Aimbot then aimAt(closest()) end
    if CFG.Trigger then trig() end
end)

print("[540CHEATS v22] โหลดสำเร็จ — Fixed Loaded Event")
