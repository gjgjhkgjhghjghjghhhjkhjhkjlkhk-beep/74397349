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
    data[tostring(game.PlaceId)] = setdata
    pcall(function() writefile("BrainrotPolice/Config.json", game:GetService("HttpService"):JSONEncode(data)) end)

    getgenv().farmActive = false

    local FISH_POS = CFrame.new(44.133, 5.129, -78)

    local function tpTo(pos)
        local char = plr.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = pos
        end
    end

    local function getRod()
        local char = plr.Character
        if char then
            for _, v in ipairs(char:GetChildren()) do
                if v:IsA("Tool") or v.Name:find("Rod") or v.Name:find("Fish") then
                    return v
                end
            end
        end
        return nil
    end

    local function isUnderwater()
        local char = plr.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            return char.HumanoidRootPart.Position.Y < 3
        end
        return false
    end

    elements:Toggle("Auto Farm", section, setdata.autoFarm, function(v)
        setdata.autoFarm = v
        getgenv().farmActive = v
        if v then
            task.spawn(function()
                while getgenv().farmActive do
                    pcall(function()
                        if isUnderwater() then
                            SharkChaseResult:FireServer("Escape")
                            task.wait(1)
                            tpTo(FISH_POS)
                            task.wait(0.5)
                        end

                        tpTo(FISH_POS)
                        task.wait(0.3)

                        FishingZone:FireServer("Enter")
                        task.wait(0.5)

                        FishingFunnel:FireServer("Started")
                        task.wait(0.3)

                        FishingFunnel:FireServer("Thrown")
                        task.wait(0.3)

                        FishingFunnel:FireServer("Landed")
                        task.wait(0.3)

                        local char = plr.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local pos = char.HumanoidRootPart.Position
                            local rod = getRod()
                            FloatCreate:FireServer(
                                CFrame.new(pos.X, pos.Y, pos.Z),
                                rod
                            )
                        end

                        task.wait(0.5)

                        Fishing:FireServer("Started", 1)

                        for i = 1, 20 do
                            if not getgenv().farmActive then break end
                            task.wait(0.5)
                            pcall(function()
                                if isUnderwater() then
                                    SharkChaseResult:FireServer("Escape")
                                    task.wait(1)
                                    tpTo(FISH_POS)
                                end
                            end)
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end)
end