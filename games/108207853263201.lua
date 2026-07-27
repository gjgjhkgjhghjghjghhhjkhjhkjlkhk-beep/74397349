-- "Rizz Tower" because its the first result when searching 'vkojiii'

return function(section, data)
    local elements = _G.elements

    getgenv().WinFarm = false

    local plr = game:GetService("Players").LocalPlayer

    local setdata = data[tostring(game.PlaceId)] or {}
    setdata.winfarm = setdata.winfarm or false
    data[tostring(game.PlaceId)] = setdata
    pcall(function() end)

    elements:Toggle("Win Farm", section, setdata.winfarm, function(bool)
        getgenv().setconfig("winfarm", bool)
        if bool then
            getgenv().WinFarm = true

            while getgenv().WinFarm do
                pcall(function()
                    plr.Character:MoveTo(Vector3.new(1, 477, -315))
                    task.wait()
                    firetouchinterest(plr.Character.Head, workspace.TeleportWin.Reward, true)
                    task.wait()
                    firetouchinterest(plr.Character.Head, workspace.TeleportWin.Reward, false)
                    task.wait()
                end)
            end
        else
            getgenv().WinFarm = false
        end
    end)
end