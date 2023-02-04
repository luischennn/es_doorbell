-- ════════════════════════════════════════════════════════════════════════════════════ --
-- ESX Import
-- ════════════════════════════════════════════════════════════════════════════════════ --

ESX = exports["es_extended"]:getSharedObject()

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("^6[Server - DEBUG] ^0: "..filename()..".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

RegisterNetEvent('es_doorbell:NotifyJob')
AddEventHandler('es_doorbell:NotifyJob', function(job)
    local xPlayers = ESX.GetPlayers()
    for key, source in pairs(xPlayers) do
        ::xPlayer_nil::
        local xPlayer = ESX.GetPlayerFromId(source)
        Citizen.Wait(10)
        -- Check if xPlayer is nil (e.g. if player just joined the Server)
        if xPlayer == nil then 
            goto xPlayer_nil 
        end
        SendMessage(xPlayer, 'success')
        if xPlayer.getJob().name == job then
            SendMessage(xPlayer, 'inform')
        end
    end
end)


---Added Message function to remove code repetition and improve readability
---@param xPlayer integer
---@param _type string
function SendMessage(xPlayer, _type)
    TriggerClientEvent('ox_lib:notify', xPlayer.source, {title = Config.Bell, description = Config.SomeoneRang, duration = 5000, type = _type})
end
