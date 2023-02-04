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
print("[CLIENT - DEBUG] : " .. filename() .. ".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

-- // Zone

local zeit = 0
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
            debug = false,
            options = {
                {
                    icon = 'fa-sharp fa-solid fa-bell',
                    label = Config.targetRing .. ' ' .. s.label,
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


---@param FileName string
---@param Volume string
---@return nil
function PlayNUISound(FileName, Volume)
    SendNUIMessage({
        Type = "playSound",
        File = FileName or "",
        Volume = Volume or 1
    })
end

--TODO: Play NUI Sound from Coords (currently static)