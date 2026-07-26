return function(section, data)
    local elements = _G.elements or loadstring(game:HttpGet(getgitpath("src").."elements.lua"))()

    local RS = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer

    local Handler = RS:WaitForChild("RemoteHandler")
    local FishingZone = Handler:WaitForChild("FishingZone")
    local Fishing = Handler:WaitForChild("Fishing")
    local FloatUpdate = Handler:WaitForChild("FloatUpdate")
    local SharkRunStart = Handler:WaitForChild("SharkRunStart")
    local SharkChaseResult = Handler:WaitForChild("SharkChaseResult")

    local setdata = data[tostring(game.PlaceId)] or {}
    setdata.autoFarm = setdata.autoFarm or false
    setdata.autoSharkEscape = setdata.autoSharkEscape or false
    setdata.autoRejoin = setdata.autoRejoin or false
    data[tostring(game.PlaceId)] = setdata
    pcall(function() writefile("BrainrotPolice/Config.json", game:GetService("HttpService"):JSONEncode(data)) end)

    local statusLabel = elements:Label("Status: Idle", section, 1)

    local function updateStatus(txt)
        statusLabel:FindFirstChildOfClass("TextLabel").Text = "Status: " .. txt
    end

    elements:Toggle("Auto Fish", section, setdata.autoFarm, function(v)
        setdata.autoFarm = v
        if v then
            updateStatus("Auto Fish: ON")
            task.spawn(function()
                while setdata.autoFarm do
                    pcall(function()
                        FishingZone:FireServer("Enter")
                        task.wait(0.5)
                        Fishing:FireServer("Started", 1)
                    end)
                    task.wait(3)
                end
            end)
        else
            updateStatus("Idle")
        end
    end)

    elements:Toggle("Auto Shark Escape", section, setdata.autoSharkEscape, function(v)
        setdata.autoSharkEscape = v
        if v then
            task.spawn(function()
                while setdata.autoSharkEscape do
                    pcall(function()
                        local char = plr.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local pos = char.HumanoidRootPart.Position
                            if pos.Y < 5 then
                                SharkChaseResult:FireServer("Escape")
                                task.wait(0.5)
                            end
                        end
                    end)
                    task.wait(0.3)
                end
            end)
        end
    end)

    elements:Button("TP to Fishing Zone", section, function()
        pcall(function()
            FloatUpdate:FireServer(
                CFrame.new(44.102, 15.459, -155.295, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            )
        end)
    end)

    elements:Button("Escape Shark", section, function()
        pcall(function()
            SharkChaseResult:FireServer("Escape")
        end)
    end)

    elements:Button("TP to Shark Run", section, function()
        pcall(function()
            SharkRunStart:FireServer(
                CFrame.new(44.102, 0, -188, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            )
        end)
    end)
end