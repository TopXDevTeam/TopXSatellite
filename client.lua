local ToggleView = false

RegisterCommand("TopXSatellite", function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local model = GetEntityModel(vehicle)

    local isAllowedVehicle = false
    local isAllowedJob = false
    local playerJob = nil
    if Config.Core == "esx" then
        playerJob = Core.GetPlayerData().job.name
    elseif Config.Core == "qb-core" then
        playerJob = Core.Functions.GetPlayerData().job.name
    end

    for _, job in pairs(Config.AllowedJobs) do
        if playerJob == job then
            isAllowedJob = true
            break
        end
    end

    for _, VehicleModel in pairs(Config.VehicleNames) do
        if GetDisplayNameFromVehicleModel(model) == VehicleModel:upper() then
            isAllowedVehicle = true
            break
        end
    end

    if not isAllowedVehicle or not isAllowedJob then
        return
    end

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        ToggleView = not ToggleView
        if ToggleView then
            StartChangeCam()
        else
            StopChangeCam()
        end
    end
end, false)


RegisterKeyMapping('TopXSatellite', 'Radar', 'keyboard', Config.Key)

Citizen.CreateThread(function()
    while true do
        if ToggleView then
            if Config.Core == "esx" then
                Core.TriggerServerCallback('TopXSatellite:Server:GetPlayers', function(players)
                    local playerData = {}

                    for _, data in ipairs(players) do
                        local onScreen, x, y = GetScreenCoordFromWorldCoord(data.coords.x, data.coords.y, data.coords.z)
                        if onScreen then
                            GetPlayerJobColor(data.job)
                            table.insert(playerData, { x = x * 100, y = y * 100, color = GetPlayerJobColor(data.job) })
                        end
                    end

                    SendNUIMessage({
                        type = 'updateLocations',
                        players = playerData
                    })
                end)
            elseif Config.Core == "qb-core" then
                Core.Functions.TriggerCallback('TopXSatellite:Server:GetPlayers', function(players)
                    local playerData = {}
                    for _, data in ipairs(players) do
                        local onScreen, x, y = GetScreenCoordFromWorldCoord(data.coords.x, data.coords.y, data.coords.z)
                        if onScreen then
                            GetPlayerJobColor(data.job)
                            table.insert(playerData, { x = x * 100, y = y * 100, color = GetPlayerJobColor(data.job) })
                        end
                    end

                    SendNUIMessage({
                        type = 'updateLocations',
                        players = playerData
                    })
                end)
            end
        else
            SendNUIMessage({
                type = 'close',
            })
        end
        Citizen.Wait(100)
    end
end)

function StartChangeCam()
    local pos = GetEntityCoords(PlayerPedId())
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, Config.Zoom, 270.00, 0.00, 0.00, 80.00, 0, 0)
    ClearTimecycleModifier()
    ClearExtraTimecycleModifier()
    SetExtraTimecycleModifier('yell_tunnel_nodirect')
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
end

function StopChangeCam()
    ClearTimecycleModifier()
    ClearExtraTimecycleModifier()
    RenderScriptCams(false, true, 500, true, true)
end

function GetPlayerJobColor(PlayerJob)
    for job, color in pairs(Config.JobColors) do
        if job == PlayerJob then
            return color
        end
    end
    return Config.JobColors["default"]
end
