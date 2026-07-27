return function(section, data)
    local elements = _G.elements

    local RS = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer
    local Handler = RS:WaitForChild("RemoteHandler", 10)

    local setdata = data[tostring(game.PlaceId)] or {}
    setdata.autoFarm = setdata.autoFarm or false
    setdata.autoRebirth = setdata.autoRebirth or false
    data[tostring(game.PlaceId)] = setdata

    local function getRemote(name)
        local r = nil
        pcall(function() r = Handler:WaitForChild(name, 5) end)
        return r
    end

    local FishingZone = getRemote("FishingZone")
    local Fishing = getRemote("Fishing")
    local FishingFunnel = getRemote("FishingFunnel")
    local FloatCreate = getRemote("FloatCreate")
    local FloatDestroy = getRemote("FloatDestroy")
    local SharkChaseResult = getRemote("SharkChaseResult")
    local RebirthRemote = getRemote("Rebirth")

    if not RebirthRemote then
        pcall(function()
            for _, v in ipairs(Handler:GetChildren()) do
                if v.Name:lower():find("rebirth") or v.Name:lower():find("reborn") then
                    RebirthRemote = v
                    break
                end
            end
        end)
    end

    getgenv().farmActive = false
    getgenv().rebirthActive = false

    local function pressE()
        pcall(function()
            local vim = game:GetService("VirtualInputManager")
            vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.1)
            vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        end)
        pcall(function()
            keypress(0x45)
            task.wait(0.1)
            keyrelease(0x45)
        end)
        pcall(function()
            mouse1press()
            task.wait(0.1)
            mouse1release()
        end)
    end

    local sharkCaught = Instance.new("BindableEvent")
    pcall(function()
        local SharkChaseStart = getRemote("SharkChaseStart")
        if SharkChaseStart then
            SharkChaseStart.OnClientEvent:Connect(function(info)
                sharkCaught:Fire(info)
            end)
        end
    end)

    local function doFishingCycle()
        if not FishingZone then return end

        pcall(function()
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(44, 5, -85)
                char:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, 0, 0)
            end
        end)
        task.wait(0.5)

        pcall(function() FishingZone:FireServer("Enter") end)
        task.wait(1)

        pressE()
        task.wait(0.5)

        if not getgenv().farmActive then return end

        pcall(function() FishingFunnel:FireServer("Started") end)
        task.wait(0.4)
        pcall(function() FishingFunnel:FireServer("Thrown") end)
        task.wait(0.4)
        pcall(function() FishingFunnel:FireServer("Landed") end)
        task.wait(0.5)

        pcall(function()
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local pos = char.HumanoidRootPart.Position
                local rod = nil
                for _, v in ipairs(char:GetChildren()) do
                    if v:IsA("Tool") or v.Name:find("Rod") or v.Name:find("Fish") then
                        rod = v
                        break
                    end
                end
                FloatCreate:FireServer(CFrame.new(pos.X, pos.Y, pos.Z), rod)
            end
        end)

        task.wait(0.5)
        pcall(function() Fishing:FireServer("Started", 1) end)

        local sharkInfo = nil
        local conn
        conn = sharkCaught.Event:Connect(function(info)
            sharkInfo = info
        end)

        for i = 1, 30 do
            if not getgenv().farmActive then break end
            if sharkInfo then break end
            task.wait(0.5)
        end

        conn:Disconnect()

        if sharkInfo then
            task.wait(0.5)
            pcall(function()
                local ch = plr.Character
                if ch and ch:FindFirstChild("HumanoidRootPart") then
                    local p = ch.HumanoidRootPart.Position
                    ch.HumanoidRootPart.CFrame = CFrame.new(p.X + 100, p.Y + 50, p.Z + 100)
                    ch.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                end
            end)
            task.wait(1)
            pcall(function() SharkChaseResult:FireServer("Escape") end)
            task.wait(2)
        end

        pcall(function() FloatDestroy:FireServer() end)
        task.wait(0.5)
    end

    elements:Toggle("Auto Farm", section, setdata.autoFarm, function(v)
        setdata.autoFarm = v
        getgenv().farmActive = v
        if v then
            task.spawn(function()
                while getgenv().farmActive do
                    pcall(doFishingCycle)
                    task.wait(1)
                end
            end)
        end
    end)

    elements:Toggle("Auto Rebirth", section, setdata.autoRebirth, function(v)
        setdata.autoRebirth = v
        getgenv().rebirthActive = v
        if v then
            task.spawn(function()
                while getgenv().rebirthActive do
                    pcall(function()
                        if RebirthRemote then
                            RebirthRemote:FireServer()
                        end
                    end)
                    task.wait(3)
                end
            end)
        end
    end)
end