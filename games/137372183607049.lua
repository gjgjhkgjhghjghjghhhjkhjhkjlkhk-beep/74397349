return function(section, data)
    local elements = _G.elements or loadstring(game:HttpGet(getgitpath("src").."elements.lua"))()

    local RS = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer

    local Handler = RS:WaitForChild("RemoteHandler")
    local FishingZone = Handler:WaitForChild("FishingZone")
    local Fishing = Handler:WaitForChild("Fishing")
    local FishingFunnel = Handler:WaitForChild("FishingFunnel")
    local FloatCreate = Handler:WaitForChild("FloatCreate")
    local FloatUpdate = Handler:WaitForChild("FloatUpdate")
    local FloatDestroy = Handler:WaitForChild("FloatDestroy")
    local SharkChaseResult = Handler:WaitForChild("SharkChaseResult")

    local setdata = data[tostring(game.PlaceId)] or {}
    setdata.autoFarm = setdata.autoFarm or false
    setdata.autoRebirth = setdata.autoRebirth or false
    data[tostring(game.PlaceId)] = setdata
    pcall(function() writefile("BrainrotPolice/Config.json", game:GetService("HttpService"):JSONEncode(data)) end)

    getgenv().farmActive = false
    getgenv().rebirthActive = false

    local RebirthRemote = nil
    pcall(function()
        RebirthRemote = Handler:WaitForChild("Rebirth", 3)
    end)
    if not RebirthRemote then
        pcall(function()
            for _, v in ipairs(Handler:GetChildren()) do
                if v.Name:lower():find("rebirth") or v.Name:lower():find("reborn") or v.Name:lower():find("reset") then
                    RebirthRemote = v
                    break
                end
            end
        end)
    end

    local function tpTo(cf)
        pcall(function()
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = cf
                char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    end

    local function pressE()
        pcall(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    obj.HoldDuration = 0
                    obj:InputHoldBegin()
                    task.wait(0.1)
                    obj:InputHoldEnd()
                end
            end
        end)
        pcall(function()
            local vim = game:GetService("VirtualInputManager")
            local cam = workspace.CurrentCamera
            local cx, cy = cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2
            vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.15)
            vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        end)
        pcall(function()
            keypress(0x45)
            task.wait(0.15)
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
        local SharkChaseStart = Handler:WaitForChild("SharkChaseStart", 5)
        if SharkChaseStart then
            SharkChaseStart.OnClientEvent:Connect(function(info)
                sharkCaught:Fire(info)
            end)
        end
    end)

    local function doFishingCycle()
        pcall(function()
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(44, 5, -85)
                char:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, 0, 0)
            end
        end)
        task.wait(0.5)

        FishingZone:FireServer("Enter")
        task.wait(1)

        pressE()
        task.wait(0.5)

        if not getgenv().farmActive then return end

        FishingFunnel:FireServer("Started")
        task.wait(0.4)
        FishingFunnel:FireServer("Thrown")
        task.wait(0.4)
        FishingFunnel:FireServer("Landed")
        task.wait(0.5)

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
            FloatCreate:FireServer(
                CFrame.new(pos.X, pos.Y, pos.Z),
                rod
            )
        end

        task.wait(0.5)
        Fishing:FireServer("Started", 1)

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
            SharkChaseResult:FireServer("Escape")
            task.wait(2)
        end

        pcall(function()
            FloatDestroy:FireServer()
        end)
        task.wait(0.5)
    end

    elements:Toggle("Auto Farm", section, setdata.autoFarm, function(v)
        setdata.autoFarm = v
        getgenv().farmActive = v
        if v then
            task.spawn(function()
                while getgenv().farmActive do
                    pcall(function()
                        doFishingCycle()
                    end)
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
                        else
                            pcall(function()
                                for _, v in ipairs(Handler:GetChildren()) do
                                    if v.Name:lower():find("rebirth") or v.Name:lower():find("reborn") then
                                        v:FireServer()
                                        break
                                    end
                                end
                            end)
                        end
                    end)
                    task.wait(3)
                end
            end)
        end
    end)
end