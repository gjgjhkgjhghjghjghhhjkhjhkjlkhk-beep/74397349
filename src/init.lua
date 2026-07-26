if not game:IsLoaded() then
    game.Loaded:Wait()
end
local env = getgenv()

local BASE = "https://raw.githubusercontent.com/gjgjhkgjhghjghjghhhjkhjhkjlkhk-beep/74397349/main/"

function env.import(id)
    return game:GetObjects(id)[1]
end

function env.getgitpath(where)
    if where == "src" then
        return BASE .. "src/"
    elseif where == "games" then
        return BASE .. "games/"
    end
end

function env.setconfig(key, value)
    env._config = env._config or {}
    env._config[tostring(game.PlaceId)] = env._config[tostring(game.PlaceId)] or {}
    env._config[tostring(game.PlaceId)][key] = value
end

game:GetService("GuiService").ErrorMessageChanged:Connect(function()
    if env.autorjjjj then
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
end)

game:GetService("GuiService"):SetGameplayPausedNotificationEnabled(false)

loadstring(game:HttpGet(BASE .. "src/ui.lua"))()

if queue_on_teleport then
    queue_on_teleport('loadstring(game:HttpGet("' .. BASE .. 'main.lua"))()')
end
