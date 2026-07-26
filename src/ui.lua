print("[Universal] UI Starting...")
local getexec = identifyexecutor or function() return "Unknown" end

local parent = nil
pcall(function() parent = gethui() end)
if not parent then pcall(function() parent = get_hidden_gui() end) end
if not parent then pcall(function() parent = game:GetService("CoreGui") end) end
if not parent then pcall(function() parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end) end
if not parent then parent = game:GetService("StarterGui") end

local uis = game:GetService("UserInputService")
local https = game:GetService("HttpService")
local ts = game:GetService("TweenService")
local rs = game:GetService("RunService")

local COLORS = {
    bg = Color3.fromRGB(12, 12, 15),
    bgLight = Color3.fromRGB(18, 18, 24),
    bgCard = Color3.fromRGB(22, 22, 28),
    bgHover = Color3.fromRGB(30, 30, 38),
    accent = Color3.fromRGB(110, 70, 255),
    accentGlow = Color3.fromRGB(130, 90, 255),
    accentDark = Color3.fromRGB(80, 50, 180),
    text = Color3.fromRGB(230, 230, 240),
    textDim = Color3.fromRGB(120, 120, 140),
    textMuted = Color3.fromRGB(75, 75, 90),
    green = Color3.fromRGB(50, 210, 100),
    yellow = Color3.fromRGB(255, 200, 50),
    red = Color3.fromRGB(240, 60, 70),
    border = Color3.fromRGB(35, 35, 45),
    shadow = Color3.fromRGB(0, 0, 0),
}

local fontMain = Enum.Font.GothamBold
local fontLight = Enum.Font.Gotham

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UniversalByVkojii"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 999
screenGui.Parent = parent

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 380)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
mainFrame.BackgroundColor3 = COLORS.bg
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = COLORS.border
mainStroke.Thickness = 1
mainStroke.Transparency = 0.3
mainStroke.Parent = mainFrame

local mainShadow = Instance.new("ImageLabel")
mainShadow.Name = "Shadow"
mainShadow.Size = UDim2.new(1, 30, 1, 30)
mainShadow.Position = UDim2.new(0, -15, 0, -15)
mainShadow.BackgroundTransparency = 1
mainShadow.Image = "rbxassetid://6015897843"
mainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
mainShadow.ImageTransparency = 0.5
mainShadow.ScaleType = Enum.ScaleType.Slice
mainShadow.SliceCenter = Rect.new(49, 49, 450, 450)
mainShadow.Parent = mainFrame

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 44)
topBar.BackgroundColor3 = COLORS.bgLight
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 12)
topBarCorner.Parent = topBar

local topBarCover = Instance.new("Frame")
topBarCover.Size = UDim2.new(1, 0, 0, 14)
topBarCover.Position = UDim2.new(0, 0, 1, -14)
topBarCover.BackgroundColor3 = COLORS.bgLight
topBarCover.BorderSizePixel = 0
topBarCover.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(0, 300, 1, 0)
titleLabel.Position = UDim2.new(0, 16, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "UNIVERSAL"
titleLabel.TextColor3 = COLORS.text
titleLabel.Font = fontMain
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local titleDot = Instance.new("TextLabel")
titleDot.Size = UDim2.new(0, 8, 0, 8)
titleDot.Position = UDim2.new(0, 120, 0.5, -4)
titleDot.BackgroundColor3 = COLORS.accent
titleDot.BorderSizePixel = 0
titleDot.Text = ""
titleDot.Parent = topBar

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = titleDot

local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Size = UDim2.new(0, 100, 1, 0)
subtitleLabel.Position = UDim2.new(0, 134, 0, 0)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "by vkojii"
subtitleLabel.TextColor3 = COLORS.accent
subtitleLabel.Font = fontLight
subtitleLabel.TextSize = 13
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subtitleLabel.Parent = topBar

local hideBtn = Instance.new("TextButton")
hideBtn.Name = "HideBtn"
hideBtn.Size = UDim2.new(0, 30, 0, 30)
hideBtn.Position = UDim2.new(1, -38, 0, 7)
hideBtn.BackgroundColor3 = COLORS.bgHover
hideBtn.BorderSizePixel = 0
hideBtn.Text = ""
hideBtn.Parent = topBar

local hideBtnCorner = Instance.new("UICorner")
hideBtnCorner.CornerRadius = UDim.new(0, 8)
hideBtnCorner.Parent = hideBtn

local hideBtnX = Instance.new("TextLabel")
hideBtnX.Size = UDim2.new(1, 0, 1, 0)
hideBtnX.BackgroundTransparency = 1
hideBtnX.Text = "×"
hideBtnX.TextColor3 = COLORS.textDim
hideBtnX.Font = fontMain
hideBtnX.TextSize = 18
hideBtnX.Parent = hideBtn

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 48, 0, 48)
toggleBtn.Position = UDim2.new(0, 20, 0, 20)
toggleBtn.BackgroundColor3 = COLORS.accent
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = ""
toggleBtn.Visible = false
toggleBtn.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 14)
toggleCorner.Parent = toggleBtn

local toggleIcon = Instance.new("TextLabel")
toggleIcon.Size = UDim2.new(1, 0, 1, 0)
toggleIcon.BackgroundTransparency = 1
toggleIcon.Text = "U"
toggleIcon.TextColor3 = COLORS.text
toggleIcon.Font = fontMain
toggleIcon.TextSize = 20
toggleIcon.Parent = toggleBtn

local navFrame = Instance.new("Frame")
navFrame.Name = "NavFrame"
navFrame.Size = UDim2.new(0, 130, 1, -44)
navFrame.Position = UDim2.new(0, 0, 0, 44)
navFrame.BackgroundColor3 = COLORS.bgLight
navFrame.BorderSizePixel = 0
navFrame.Parent = mainFrame

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 12)
navCorner.Parent = navFrame

local navCover = Instance.new("Frame")
navCover.Size = UDim2.new(1, 0, 0, 12)
navCover.Position = UDim2.new(0, 0, 0, 0)
navCover.BackgroundColor3 = COLORS.bgLight
navCover.BorderSizePixel = 0
navCover.Parent = navFrame

local navLayout = Instance.new("UIListLayout")
navLayout.SortOrder = Enum.SortOrder.LayoutOrder
navLayout.Padding = UDim.new(0, 2)
navLayout.Parent = navFrame

local navPadding = Instance.new("UIPadding")
navPadding.PaddingTop = UDim.new(0, 8)
navPadding.PaddingLeft = UDim.new(0, 8)
navPadding.PaddingRight = UDim.new(0, 8)
navPadding.Parent = navFrame

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -130, 1, -44)
contentFrame.Position = UDim2.new(0, 130, 0, 44)
contentFrame.BackgroundColor3 = COLORS.bg
contentFrame.BorderSizePixel = 0
contentFrame.ClipsDescendants = true
contentFrame.Parent = mainFrame

local sections = {}
local tabButtons = {}
local curSection = nil

local sectionNames = {"Home", "Game", "GamesList", "Settings"}
local sectionIcons = {"⌂", "◈", "☰", "⚙"}

for i, name in ipairs(sectionNames) do
    local container = Instance.new("Frame")
    container.Name = name .. "Section"
    container.Size = UDim2.new(1, 0, 1, 0)
    container.Position = UDim2.new(0.5, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.Visible = false
    container.Parent = contentFrame

    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "Scroll"
    scrollFrame.Size = UDim2.new(1, -24, 1, -16)
    scrollFrame.Position = UDim2.new(0, 12, 0, 8)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 3
    scrollFrame.ScrollBarImageColor3 = COLORS.accent
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = container

    local scrollLayout = Instance.new("UIListLayout")
    scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
    scrollLayout.Padding = UDim.new(0, 6)
    scrollLayout.Parent = scrollFrame

    local scrollPadding = Instance.new("UIPadding")
    scrollPadding.PaddingTop = UDim.new(0, 4)
    scrollPadding.PaddingBottom = UDim.new(0, 12)
    scrollPadding.Parent = scrollFrame

    pcall(function()
        scrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, scrollLayout.AbsoluteContentSize.Y + 20)
        end)
    end)

    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name .. "Tab"
    tabBtn.Size = UDim2.new(1, 0, 0, 38)
    tabBtn.BackgroundColor3 = COLORS.bgHover
    tabBtn.BackgroundTransparency = 1
    tabBtn.BorderSizePixel = 0
    tabBtn.Text = ""
    tabBtn.LayoutOrder = i
    tabBtn.Parent = navFrame

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabBtn

    local tabIcon = Instance.new("TextLabel")
    tabIcon.Size = UDim2.new(0, 28, 0, 38)
    tabIcon.Position = UDim2.new(0, 4, 0, 0)
    tabIcon.BackgroundTransparency = 1
    tabIcon.Text = sectionIcons[i]
    tabIcon.TextColor3 = COLORS.textDim
    tabIcon.Font = fontMain
    tabIcon.TextSize = 14
    tabIcon.Parent = tabBtn

    local tabLabel = Instance.new("TextLabel")
    tabLabel.Size = UDim2.new(1, -36, 0, 38)
    tabLabel.Position = UDim2.new(0, 32, 0, 0)
    tabLabel.BackgroundTransparency = 1
    tabLabel.Text = name == "GamesList" and "Games List" or name
    tabLabel.TextColor3 = COLORS.textDim
    tabLabel.Font = fontLight
    tabLabel.TextSize = 13
    tabLabel.TextXAlignment = Enum.TextXAlignment.Left
    tabLabel.Parent = tabBtn

    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 3, 0, 20)
    indicator.Position = UDim2.new(0, 0, 0.5, -10)
    indicator.BackgroundColor3 = COLORS.accent
    indicator.BorderSizePixel = 0
    indicator.Transparency = 1
    indicator.Parent = tabBtn

    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(0, 2)
    indCorner.Parent = indicator

    sections[name] = {container = container, scroll = scrollFrame}
    tabButtons[name] = {btn = tabBtn, icon = tabIcon, label = tabLabel, indicator = indicator}

    tabBtn.MouseEnter:Connect(function()
        if curSection ~= name then
            ts:Create(tabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.7}):Play()
            ts:Create(tabLabel, TweenInfo.new(0.15), {TextColor3 = COLORS.text}):Play()
            ts:Create(tabIcon, TweenInfo.new(0.15), {TextColor3 = COLORS.accent}):Play()
        end
    end)

    tabBtn.MouseLeave:Connect(function()
        if curSection ~= name then
            ts:Create(tabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
            ts:Create(tabLabel, TweenInfo.new(0.15), {TextColor3 = COLORS.textDim}):Play()
            ts:Create(tabIcon, TweenInfo.new(0.15), {TextColor3 = COLORS.textDim}):Play()
        end
    end)

    tabBtn.MouseButton1Click:Connect(function()
        if curSection == name then return end
        switchSection(name)
    end)
end

function switchSection(name)
    if curSection then
        local old = sections[curSection]
        local oldTab = tabButtons[curSection]
        old.container:TweenPosition(UDim2.new(0.5, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.25)
        ts:Create(oldTab.btn, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        ts:Create(oldTab.label, TweenInfo.new(0.2), {TextColor3 = COLORS.textDim}):Play()
        ts:Create(oldTab.icon, TweenInfo.new(0.2), {TextColor3 = COLORS.textDim}):Play()
        ts:Create(oldTab.indicator, TweenInfo.new(0.2), {Transparency = 1}):Play()
    end

    local new = sections[name]
    local newTab = tabButtons[name]
    new.container.Visible = true
    new.container:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.25)
    ts:Create(newTab.btn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    ts:Create(newTab.label, TweenInfo.new(0.2), {TextColor3 = COLORS.text}):Play()
    ts:Create(newTab.icon, TweenInfo.new(0.2), {TextColor3 = COLORS.accent}):Play()
    ts:Create(newTab.indicator, TweenInfo.new(0.2), {Transparency = 0}):Play()

    curSection = name
end

hideBtn.MouseButton1Click:Connect(function()
    ts:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    task.delay(0.3, function()
        mainFrame.Visible = false
        toggleBtn.Visible = true
        mainFrame.Size = UDim2.new(0, 520, 0, 380)
        mainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
    end)
end)

toggleBtn.MouseButton1Click:Connect(function()
    toggleBtn.Visible = false
    mainFrame.Visible = true
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    ts:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
        Size = UDim2.new(0, 520, 0, 380),
        Position = UDim2.new(0.5, -260, 0.5, -190)
    }):Play()
end)

local dragging = false
local dragInput, mousePos, framePos

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        mousePos = input.Position
        framePos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

uis.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        mainFrame.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

elements = loadstring(game:HttpGet(getgitpath("src").."elements.lua?v=" .. tick()))()
_G.elements = elements

local function makeCard(parent, order)
    local card = Instance.new("Frame")
    card.Name = "Card"
    card.Size = UDim2.new(1, 0, 0, 0)
    card.AutomaticSize = Enum.AutomaticSize.Y
    card.BackgroundColor3 = COLORS.bgCard
    card.BorderSizePixel = 0
    card.LayoutOrder = order or 0
    card.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = card

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 2)
    layout.Parent = card

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingLeft = UDim.new(0, 10)
    pad.PaddingRight = UDim.new(0, 10)
    pad.PaddingBottom = UDim.new(0, 4)
    pad.Parent = card

    return card
end

local function makeLabel(parent, text, order, fontSize, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 0)
    lbl.AutomaticSize = Enum.AutomaticSize.Y
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color or COLORS.text
    lbl.Font = fontLight
    lbl.TextSize = fontSize or 13
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = order or 0
    lbl.Parent = parent
    return lbl
end

local homeScroll = sections.Home.scroll

local welcomeCard = makeCard(homeScroll, 0)
makeLabel(welcomeCard, "Welcome to Universal", 0, 16, COLORS.text).Font = fontMain
makeLabel(welcomeCard, "by vkojii", 1, 12, COLORS.accent)
makeLabel(welcomeCard, "The best universal script hub.", 2, 12, COLORS.textDim)

local infoCard = makeCard(homeScroll, 1)
makeLabel(infoCard, "Status", 0, 11, COLORS.textMuted)
makeLabel(infoCard, "Executor: " .. getexec(), 1, 13, COLORS.text)
makeLabel(infoCard, "Version: 1.0.0", 2, 13, COLORS.text)
makeLabel(infoCard, "Discord: discord.gg/vkojiii", 3, 13, COLORS.accent)

local linksCard = makeCard(homeScroll, 2)
makeLabel(linksCard, "Links", 0, 11, COLORS.textMuted)

local suggestBtn = Instance.new("TextButton")
suggestBtn.Size = UDim2.new(1, 0, 0, 34)
suggestBtn.LayoutOrder = 10
suggestBtn.BackgroundColor3 = COLORS.accent
suggestBtn.BorderSizePixel = 0
suggestBtn.Text = "Suggest a Game"
suggestBtn.TextColor3 = COLORS.text
suggestBtn.Font = fontMain
suggestBtn.TextSize = 13
suggestBtn.Parent = linksCard

local suggestCorner = Instance.new("UICorner")
suggestCorner.CornerRadius = UDim.new(0, 8)
suggestCorner.Parent = suggestBtn

suggestBtn.MouseEnter:Connect(function()
    ts:Create(suggestBtn, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.accentGlow}):Play()
end)
suggestBtn.MouseLeave:Connect(function()
    ts:Create(suggestBtn, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.accent}):Play()
end)

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(1, 0, 0, 34)
discordBtn.LayoutOrder = 11
discordBtn.BackgroundColor3 = COLORS.bgHover
discordBtn.BorderSizePixel = 0
discordBtn.Text = "Copy Discord Link"
discordBtn.TextColor3 = COLORS.text
discordBtn.Font = fontLight
discordBtn.TextSize = 13
discordBtn.Parent = linksCard

local dcCorner = Instance.new("UICorner")
dcCorner.CornerRadius = UDim.new(0, 8)
dcCorner.Parent = discordBtn

suggestBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/vkojiii")
    suggestBtn.Text = "Link Copied!"
    task.wait(1.5)
    suggestBtn.Text = "Suggest a Game"
end)

discordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/vkojiii")
    discordBtn.Text = "Copied!"
    task.wait(1.5)
    discordBtn.Text = "Copy Discord Link"
end)

switchSection("Home")

local savedConfig = {settings = {disable_3d_rendering = false, auto_rejoin_on_kick = false}}

local gameFile = getgitpath("games") .. tostring(game.PlaceId) .. ".lua"
local ok, gamePath = pcall(function() return game:HttpGet(gameFile) end)
local gameList = https:JSONDecode(game:HttpGet(getgitpath("src").."gameslist.json?v=" .. tick()))

if not ok or not gamePath or gamePath == "" or gamePath == "404: Not Found" then
    elements:Unsupported(sections.Game.container, function()
        switchSection("GamesList")
    end)
else
    pcall(function()
        local gameModule = loadstring(gamePath)()
        gameModule(sections.Game.scroll, savedConfig)
    end)
end

elements:Searchbar(sections.GamesList.scroll)
for _, g in ipairs(gameList) do
    elements:addGame(sections.GamesList.scroll, g["game"], g["status"], function()
        pcall(function() game:GetService("ExperienceService"):LaunchExperience({placeId = g.id}) end)
    end)
end

local dec1 = savedConfig

elements:Toggle("Disable 3D Rendering", sections.Settings.scroll, dec1.settings.disable_3d_rendering, function(v)
    dec1.settings.disable_3d_rendering = v
    rs:Set3dRenderingEnabled(not v)
end)

elements:Toggle("Auto Rejoin (when kicked)", sections.Settings.scroll, dec1.settings.auto_rejoin_on_kick, function(v)
    dec1.settings.auto_rejoin_on_kick = v
    getgenv().autorjjjj = v
end)
