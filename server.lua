if Config.Core == "esx" then
    Core.RegisterServerCallback('TopXSatellite:Server:GetPlayers', function(src, cb)
        local players = GetPlayers()
        local playersData = {}
        for _, playerId in ipairs(players) do
            local xPlayer = Core.GetPlayerFromId(playerId)
            if xPlayer then
                local ped = GetPlayerPed(playerId)
                local playerCoords = GetEntityCoords(ped)
                table.insert(playersData, {
                    id = tonumber(playerId),
                    job = xPlayer.job.name,
                    coords = playerCoords
                })
            end
        end
        cb(playersData)
    end)
elseif Config.Core == "qb-core" then
    Core.Functions.CreateCallback('TopXSatellite:Server:GetPlayers', function(src, cb)
        local players = GetPlayers()
        local playersData = {}
        for _, playerId in ipairs(players) do
            local xPlayer = Core.Functions.GetPlayer(playerId)
            if xPlayer then
                local ped = GetPlayerPed(playerId)
                local playerCoords = GetEntityCoords(ped)
                table.insert(playersData, {
                    id = tonumber(playerId),
                    job = xPlayer.job.name,
                    coords = playerCoords
                })
            end
        end
        cb(playersData)
    end)
end
