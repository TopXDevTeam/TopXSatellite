Config = {}

Config.Core = "esx" -- esx || qb-core

Core = nil;

if Config.Core == "esx" then
    Core = exports["es_extended"]:getSharedObject()
elseif Config.Core == "qb-core" then
    Core = exports['qb-core']:GetCoreObject()
end

Config.JobColors = {
    ["default"] = "#ffffff",
    ["police"] = "#0000ff",
    ["ambulance"] = "#ff0000",
    ["mechanic"] = "#00ff00",
}

Config.AllowedJobs = {
    "police"
}

Config.VehicleNames = {
    "fbi2",
    "aleutian"
}

Config.Zoom = 200.0

Config.Key = "U"
