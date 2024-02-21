ESX = exports["es_extended"]:getSharedObject()

local time = 0

if not Config.target then 
    Citizen.CreateThread(function()

        for i, e in ipairs(Config.Bells) do

            function onExit(self)
                lib.hideTextUI()
            end

            function insideZone(self)

                if time <= 0 then

                    lib.showTextUI(Config.Ring)

                    if IsControlJustReleased(0,  38) then
                        TriggerServerEvent('es_doorbell:NotifyJob', e.job)
                        time = Config.WaitingTime
                        TriggerEvent("es_doorbell:startwaittime")
                    end

                elseif time >= 0 and time <= Config.WaitingTime then

                    lib.showTextUI(Config.Wait1 ..time.. Config.Wait2)

                end

            end

            local box = lib.zones.box({
                coords = e.coords,
                size = vec3(1, 1, 2),
                inside = insideZone,
                onExit = onExit
            })

        end

    end)
elseif Config.target then
    for i, e in ipairs(Config.Bells) do
        

        exports.ox_target:addSphereZone({
            coords = e.coords,
            radius = 2,
            debug = false,
            options = {
                {
                    icon = 'fa-sharp fa-solid fa-bell',
                    label = Config.targetRing .. ' ' .. e.label,
                    distance = 1.5,
                    onSelect = function(data)
                        if time <= 0 then
                            TriggerServerEvent('es_doorbell:NotifyJob', e.job)
                            time = Config.WaitingTime
                            TriggerEvent("es_doorbell:startwaittime")
                        elseif time >= 0 and time <= Config.WaitingTime then
                            lib.notify({
                                title = Config.Wait1 ..time.. Config.Wait2,
                                type = 'error'
                            })
                        end
                    end
                }
            }
        })
    end
end

RegisterNetEvent("es_doorbell:startwaittime")
AddEventHandler("es_doorbell:startwaittime", function()
    while time >= 0 do
        Citizen.Wait(1000)
        time = time - 1
    end
end)
