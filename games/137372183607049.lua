return function(section, data)
    local elements = _G.elements or loadstring(game:HttpGet(getgitpath("src").."elements.lua"))()

    local RS = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer

    local Handler = RS:WaitForChild("RemoteHandler")
    local FishingZone = Handler:WaitForChild("FishingZone")
    local Fishing = Handler:WaitForChild("Fishing")
    local SharkChaseResult = Handler:WaitForChild("SharkChaseResult")

    local setdata = data[tostring(game.PlaceId)] or {}
    setdata.autoFarm = setdata.autoFarm or false
    data[tostring(game.PlaceId)] = setdata
    pcall(function() writefile("BrainrotPolice/Config.json", game:GetService("HttpService"):JSONEncode(data)) end)

    getgenv().farmActive = false

    elements:Toggle("Auto Farm", section, setdata.autoFarm, function(v)
        setdata.autoFarm = v
        getgenv().farmActive = v
        if v then
            task.spawn(function()
                while getgenv().farmActive do
                    pcall(function()
                        FishingZone:FireServer("Enter")
                        task.wait(0.3)
                        Fishing:FireServer("Started", 1)
                        task.wait(0.3)
                        SharkChaseResult:FireServer("Escape")
                    end)
                    task.wait(3)
                end
            end)
        end
    end)
end