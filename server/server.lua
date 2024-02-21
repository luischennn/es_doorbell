ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('es_doorbell:NotifyJob')
AddEventHandler('es_doorbell:NotifyJob', function(pJob)

    local xPlayers = ESX.GetExtendedPlayers('job', pJob)

    for i, xPlayer in ipairs(xPlayers) do
        TriggerClientEvent('ox_lib:notify', xPlayer.source, {title = Config.Bell, description = Config.SomeoneRang, duration = 5000})
    end

end)
