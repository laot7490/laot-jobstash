ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

if LAOT.discStashAuto then
    Citizen.CreateThread(function()
        TriggerEvent('disc-inventoryhud:RegisterInventory', {
            name = 'pdStash',
            label = "pdKisisel",
            slots = 100,
            weight = 100
        })
    end)
end