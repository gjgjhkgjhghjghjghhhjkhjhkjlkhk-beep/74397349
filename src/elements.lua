local stuff = {}
local ok, gl = pcall(function()
    return game:GetService("HttpService"):JSONDecode(game:HttpGet(getgitpath("src").. "gameslist.json"))
end)
local gameList = ok and gl or {}

local COLORS = {
    bg = Color3.fromRGB(12, 12, 15),
    bgLight = Color3.fromRGB(18, 18, 24),
    bgCard = Color3.fromRGB(22, 22, 28),
    bgHover = Color3.fromRGB(30, 30, 38),
    accent = Color3.fromRGB(110, 70, 255),
    accentGlow = Color3.fromRGB(130, 90, 255),
    text = Color3.fromRGB(230, 230, 240),
    textDim = Color3.fromRGB(120, 120, 140),
    textMuted = Color3.fromRGB(75, 75, 90),
    green = Color3.fromRGB(50, 210, 100),
    yellow = Color3.fromRGB(255, 200, 50),
    red = Color3.fromRGB(240, 60, 70),
    border = Color3.fromRGB(35, 35, 45),
}

local fontMain = Enum.Font.GothamBold
local fontLight = Enum.Font.Gotham

local ts = game:GetService("TweenService")

local function makeCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

local function makeStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or COLORS.border
    s.Thickness = thickness or 1
    s.Transparency = 0.5
    s.Parent = parent
    return s
end

function stuff:Label(str, parent)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 30)
    card.BackgroundColor3 = COLORS.bgCard
    card.BorderSizePixel = 0
    card.Parent = parent

    makeCorner(card)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = str
    lbl.TextColor3 = COLORS.text
    lbl.Font = fontLight
    lbl.TextSize = 13
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = card

    return card
end

function stuff:Button(str, parent, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = COLORS.bgCard
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = parent

    makeCorner(btn)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -16, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = str
    label.TextColor3 = COLORS.text
    label.Font = fontLight
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = btn

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 20, 1, 0)
    arrow.Position = UDim2.new(1, -28, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "›"
    arrow.TextColor3 = COLORS.textDim
    arrow.Font = fontMain
    arrow.TextSize = 18
    arrow.Parent = btn

    btn.MouseEnter:Connect(function()
        ts:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.bgHover}):Play()
        ts:Create(arrow, TweenInfo.new(0.15), {TextColor3 = COLORS.accent}):Play()
    end)
    btn.MouseLeave:Connect(function()
        ts:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.bgCard}):Play()
        ts:Create(arrow, TweenInfo.new(0.15), {TextColor3 = COLORS.textDim}):Play()
    end)

    btn.MouseButton1Click:Connect(cb)
end

function stuff:Toggle(str, parent, def, cb)
    local card = Instance.new("TextButton")
    card.Size = UDim2.new(1, 0, 0, 44)
    card.BackgroundColor3 = COLORS.bgCard
    card.BorderSizePixel = 0
    card.Text = ""
    card.Parent = parent

    makeCorner(card)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = str
    label.TextColor3 = COLORS.text
    label.Font = fontLight
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 40, 0, 22)
    toggleBg.Position = UDim2.new(1, -52, 0.5, -11)
    toggleBg.BackgroundColor3 = def and COLORS.green or COLORS.red
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = card

    makeCorner(toggleBg, 11)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = def and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = COLORS.text
    knob.BorderSizePixel = 0
    knob.Parent = toggleBg

    makeCorner(knob, 9)

    local isTog = def
    task.defer(function() cb(isTog) end)

    card.MouseEnter:Connect(function()
        ts:Create(card, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.bgHover}):Play()
    end)
    card.MouseLeave:Connect(function()
        ts:Create(card, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.bgCard}):Play()
    end)

    card.MouseButton1Click:Connect(function()
        isTog = not isTog
        if isTog then
            ts:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.green}):Play()
            ts:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -20, 0.5, -9)}):Play()
        else
            ts:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.red}):Play()
            ts:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 2, 0.5, -9)}):Play()
        end
        cb(isTog)
    end)
end

function stuff:Textbox(str, parent, def, cb)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 64)
    card.BackgroundColor3 = COLORS.bgCard
    card.BorderSizePixel = 0
    card.Parent = parent

    makeCorner(card)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -16, 0, 20)
    label.Position = UDim2.new(0, 12, 0, 6)
    label.BackgroundTransparency = 1
    label.Text = str
    label.TextColor3 = COLORS.text
    label.Font = fontLight
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    local inputBg = Instance.new("Frame")
    inputBg.Size = UDim2.new(1, -24, 0, 28)
    inputBg.Position = UDim2.new(0, 12, 0, 30)
    inputBg.BackgroundColor3 = COLORS.bg
    inputBg.BorderSizePixel = 0
    inputBg.Parent = card

    makeCorner(inputBg, 6)
    makeStroke(inputBg, COLORS.border)

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -12, 1, 0)
    input.Position = UDim2.new(0, 6, 0, 0)
    input.BackgroundTransparency = 1
    input.Text = def or ""
    input.TextColor3 = COLORS.text
    input.PlaceholderText = "Enter value..."
    input.PlaceholderColor3 = COLORS.textMuted
    input.Font = fontLight
    input.TextSize = 13
    input.ClearTextOnFocus = false
    input.Parent = inputBg

    input.Focused:Connect(function()
        ts:Create(inputBg, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.bgHover}):Play()
    end)

    input.FocusLost:Connect(function()
        ts:Create(inputBg, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.bg}):Play()
        cb(input.Text)
    end)
end

function stuff:Unsupported(parent, cb)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 120)
    card.BackgroundColor3 = COLORS.bgCard
    card.BorderSizePixel = 0
    card.Parent = parent

    makeCorner(card)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -16, 0, 22)
    title.Position = UDim2.new(0, 8, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "Game not supported yet"
    title.TextColor3 = COLORS.text
    title.Font = fontMain
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = card

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -16, 0, 18)
    desc.Position = UDim2.new(0, 8, 0, 34)
    desc.BackgroundTransparency = 1
    desc.Text = "Suggest it on our Discord server!"
    desc.TextColor3 = COLORS.textDim
    desc.Font = fontLight
    desc.TextSize = 12
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = card

    local suggestBtn = Instance.new("TextButton")
    suggestBtn.Size = UDim2.new(0.5, -14, 0, 32)
    suggestBtn.Position = UDim2.new(0, 8, 1, -42)
    suggestBtn.BackgroundColor3 = COLORS.accent
    suggestBtn.BorderSizePixel = 0
    suggestBtn.Text = "Suggest Game"
    suggestBtn.TextColor3 = COLORS.text
    suggestBtn.Font = fontMain
    suggestBtn.TextSize = 12
    suggestBtn.Parent = card

    makeCorner(suggestBtn)

    local glBtn = Instance.new("TextButton")
    glBtn.Size = UDim2.new(0.5, -14, 0, 32)
    glBtn.Position = UDim2.new(0.5, 6, 1, -42)
    glBtn.BackgroundColor3 = COLORS.bgHover
    glBtn.BorderSizePixel = 0
    glBtn.Text = "Games List"
    glBtn.TextColor3 = COLORS.text
    glBtn.Font = fontLight
    glBtn.TextSize = 12
    glBtn.Parent = card

    makeCorner(glBtn)

    suggestBtn.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/vkojiii")
        suggestBtn.Text = "Copied!"
        task.wait(1.5)
        suggestBtn.Text = "Suggest Game"
    end)

    glBtn.MouseButton1Click:Connect(cb)
end

function stuff:addGame(parent, gname, gstate, cb)
    local btn = Instance.new("TextButton")
    btn.Name = "GameElement"
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = COLORS.bgCard
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = parent

    makeCorner(btn)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0, 12, 0.5, -4)
    dot.BackgroundColor3 = gstate == "🟢" and COLORS.green or (gstate == "🟡" and COLORS.yellow or COLORS.red)
    dot.BorderSizePixel = 0
    dot.Parent = btn

    makeCorner(dot, 4)

    local name = Instance.new("TextLabel")
    name.Size = UDim2.new(1, -50, 1, 0)
    name.Position = UDim2.new(0, 28, 0, 0)
    name.BackgroundTransparency = 1
    name.Text = gname
    name.TextColor3 = COLORS.text
    name.Font = fontLight
    name.TextSize = 13
    name.TextXAlignment = Enum.TextXAlignment.Left
    name.Parent = btn

    local launch = Instance.new("TextLabel")
    launch.Size = UDim2.new(0, 20, 1, 0)
    launch.Position = UDim2.new(1, -28, 0, 0)
    launch.BackgroundTransparency = 1
    launch.Text = "›"
    launch.TextColor3 = COLORS.textDim
    launch.Font = fontMain
    launch.TextSize = 18
    launch.Parent = btn

    btn.MouseEnter:Connect(function()
        ts:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.bgHover}):Play()
        ts:Create(launch, TweenInfo.new(0.15), {TextColor3 = COLORS.accent}):Play()
    end)
    btn.MouseLeave:Connect(function()
        ts:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.bgCard}):Play()
        ts:Create(launch, TweenInfo.new(0.15), {TextColor3 = COLORS.textDim}):Play()
    end)

    btn.MouseButton1Click:Connect(cb)
end

function stuff:Searchbar(parent)
    local searchFrame = Instance.new("Frame")
    searchFrame.Name = "SearchFrame"
    searchFrame.Size = UDim2.new(1, 0, 0, 42)
    searchFrame.BackgroundColor3 = COLORS.bgCard
    searchFrame.BorderSizePixel = 0
    searchFrame.Parent = parent

    makeCorner(searchFrame)

    local searchIcon = Instance.new("TextLabel")
    searchIcon.Size = UDim2.new(0, 28, 1, 0)
    searchIcon.Position = UDim2.new(0, 8, 0, 0)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Text = "⌕"
    searchIcon.TextColor3 = COLORS.textMuted
    searchIcon.Font = fontMain
    searchIcon.TextSize = 16
    searchIcon.Parent = searchFrame

    local searchInput = Instance.new("TextBox")
    searchInput.Size = UDim2.new(1, -16, 1, 0)
    searchInput.Position = UDim2.new(0, 32, 0, 0)
    searchInput.BackgroundTransparency = 1
    searchInput.Text = ""
    searchInput.PlaceholderText = "Search games..."
    searchInput.PlaceholderColor3 = COLORS.textMuted
    searchInput.TextColor3 = COLORS.text
    searchInput.Font = fontLight
    searchInput.TextSize = 13
    searchInput.ClearTextOnFocus = false
    searchInput.Parent = searchFrame

    searchInput:GetPropertyChangedSignal("Text"):Connect(function()
        for _, v in pairs(parent:GetChildren()) do
            if v.Name == "GameElement" then
                v:Destroy()
            end
        end

        for _, v in pairs(gameList) do
            if v["game"]:lower():find(searchInput.Text:lower()) then
                stuff:addGame(parent, v["game"], v["status"], function()
                    pcall(function() game:GetService("ExperienceService"):LaunchExperience({placeId = v["id"]}) end)
                end)
            end
        end
    end)
end

function stuff:CredHead(parent, txt)
    local head = Instance.new("TextLabel")
    head.Size = UDim2.new(1, 0, 0, 26)
    head.BackgroundTransparency = 1
    head.Text = "> " .. txt
    head.TextColor3 = COLORS.accent
    head.Font = fontMain
    head.TextSize = 14
    head.TextXAlignment = Enum.TextXAlignment.Left
    head.Parent = parent
end

function stuff:CredPerson(parent, txt)
    local person = Instance.new("TextLabel")
    person.Size = UDim2.new(1, 0, 0, 20)
    person.BackgroundTransparency = 1
    person.Text = "      + " .. txt
    person.TextColor3 = COLORS.textDim
    person.Font = fontLight
    person.TextSize = 13
    person.TextXAlignment = Enum.TextXAlignment.Left
    person.Parent = parent
end

return stuff
