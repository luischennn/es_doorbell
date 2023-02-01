ESX = exports["es_extended"]:getSharedObject()

-- // Zone

local zeit = 0
local soundid = GetSoundId()
if not Config.target then 
    Citizen.CreateThread(function()

        for __, s in ipairs(Config.Bells) do

            function onExit(self)
                lib.hideTextUI()
            end
            
            function insideZone(self)

                if zeit <= 0 then

                    lib.showTextUI(Config.Ring)

                    if IsControlJustReleased(0,  38) then
                        TriggerServerEvent('es_doorbell:NotifyJob', s.job)
                        zeit = Config.WaitingTime
                        TriggerEvent("es_doorbell:startwaittime")
                    end

                elseif zeit >= 0 and zeit <= Config.WaitingTime then

                    lib.showTextUI(Config.Wait1 ..zeit.. Config.Wait2)

                end

            end

            local box = lib.zones.box({
                coords = s.coords,
                size = vec3(1, 1, 2),
                inside = insideZone,
                onExit = onExit
            })

        end

    end)
elseif Config.target then
    for __, s in ipairs(Config.Bells) do
        

        exports.ox_target:addSphereZone({
            coords = s.coords,
            radius = 2,
            debug = true,
            options = {
                {
                    icon = 'fa-solid fa-circle',
                    label = Config.Ring .. s.job,
                    distance = 1.5,
                    onSelect = function(data)
                        if zeit <= 0 then
                            TriggerServerEvent('es_doorbell:NotifyJob', s.job)
                            zeit = Config.WaitingTime
                            TriggerEvent("es_doorbell:startwaittime")
                        elseif zeit >= 0 and zeit <= Config.WaitingTime then
                            lib.notify({
                                id = 'odota',
                                title = Config.Wait1 ..zeit.. Config.Wait2,
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
    while zeit >= 0 do
        Citizen.Wait(1000)
        zeit = zeit - 1
    end
end)
