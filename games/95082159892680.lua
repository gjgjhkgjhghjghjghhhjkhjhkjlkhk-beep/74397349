return function(section, data)
    local elements = _G.elements
    if not elements then warn("[Universal] Elements not loaded") return end

    local plr = game:GetService("Players").LocalPlayer
    local RS = game:GetService("ReplicatedStorage")

    local setdata = data[tostring(game.PlaceId)] or {}
    setdata.farming = setdata.farming or false
    setdata.winstage = setdata.winstage or 1
    data[tostring(game.PlaceId)] = setdata

    local farming = false
    local winStage = setdata.winstage

    elements:Label("Currently supports up to 5 stages.", section)

    elements:Textbox("Win Stage", section, tostring(winStage), function(v)
        winStage = tonumber(v) or 1
        setdata.winstage = winStage
    end)

    elements:Toggle("Autofarm", section, setdata.farming, function(v)
        farming = v
        setdata.farming = v

        if not v then return end

        task.spawn(function()
            while farming do
                pcall(function()
                    local remotes = RS:WaitForChild("Remotes", 5)
                    if remotes then
                        local updateSpeed = remotes:WaitForChild("UpdateSpeed", 5)
                        if updateSpeed then
                            updateSpeed:FireServer("Walking")
                        end
                    end
                end)
                task.wait()
            end
        end)

        task.spawn(function()
            while farming do
                pcall(function()
                    local char = plr.Character
                    if not char then return end
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if not hum then return end

                    hum:MoveTo(Vector3.new(2, 9, 282))
                    hum.MoveToFinished:Wait()

                    if winStage >= 1 then
                        pcall(function()
                            hum:MoveTo(workspace.Structure.Stage2.WinBlock1.Position)
                            hum.MoveToFinished:Wait()
                        end)
                        task.wait(1)
                    end
                    if not farming or winStage <= 1 then return end

                    pcall(function()
                        hum:MoveTo(Vector3.new(70, 9, 398))
                        hum.MoveToFinished:Wait()
                        hum:MoveTo(Vector3.new(1, 9, 505))
                        hum.MoveToFinished:Wait()
                    end)

                    if winStage >= 2 then
                        pcall(function()
                            hum:MoveTo(workspace.Structure.Stage3.WinBlock2.Position)
                            hum.MoveToFinished:Wait()
                        end)
                        task.wait(1)
                    end
                    if not farming or winStage <= 2 then return end

                    pcall(function()
                        hum:MoveTo(Vector3.new(19, 9, 541))
                        hum.MoveToFinished:Wait()
                        hum:MoveTo(Vector3.new(20, 77, 754))
                        hum.MoveToFinished:Wait()
                    end)

                    if winStage >= 3 then
                        pcall(function()
                            hum:MoveTo(workspace.Structure.Stage4.WinBlock3.Position)
                            hum.MoveToFinished:Wait()
                        end)
                        task.wait(1)
                    end
                    if not farming or winStage <= 3 then return end

                    pcall(function()
                        hum:MoveTo(Vector3.new(1, 77, 817))
                        hum.MoveToFinished:Wait()
                        hum:MoveTo(Vector3.new(1, 77, 1042))
                        hum.MoveToFinished:Wait()
                    end)

                    if winStage >= 4 then
                        pcall(function()
                            hum:MoveTo(workspace.Structure.Stage5.WinBlock4.Position)
                            hum.MoveToFinished:Wait()
                        end)
                        task.wait(1)
                    end
                    if not farming or winStage <= 4 then return end

                    pcall(function()
                        hum:MoveTo(Vector3.new(2, 77, 1363))
                        hum.MoveToFinished:Wait()
                    end)

                    if winStage >= 5 then
                        pcall(function()
                            hum:MoveTo(workspace.Structure.Stage6.WinBlock5.Position)
                            hum.MoveToFinished:Wait()
                        end)
                        task.wait(1)
                    end
                end)
                task.wait(0.5)
            end
        end)
    end)
end