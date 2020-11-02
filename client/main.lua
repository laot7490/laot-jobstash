local Keys = {["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118}

local player = {}

player.discordID = nil

function DrawText3D(x, y, z, text, scale) 
	local onScreen, _x, _y = World3dToScreen2d(x, y, z) 
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) 
	SetTextScale(scale, scale) 
	SetTextFont(4) 
	SetTextProportional(1) 
	SetTextEntry("STRING") SetTextCentre(true) 
	SetTextColour(255, 255, 255, 215) 
	AddTextComponentString(text) 
	DrawText(_x, _y) 
end

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for k, v in pairs(LAOT.SelfStash) do
			if ESX.PlayerData.job then
				if ESX.PlayerData.job.name == v["job"] then
					local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
					local dst = GetDistanceBetweenCoords(x, y, z, v["coords"].x, v["coords"].y, v["coords"].z, true)

					if dst <= 8 then
						DrawMarker(27, v["coords"].x, v["coords"].y, v["coords"].z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 40, 200, 0.0, false, true, 0.0, nil, nil, false)
						DrawText3D(v["coords"].x, v["coords"].y, v["coords"].z, "~w~[~b~E~w~] Kisisel Depo", 0.50)
						if dst <= 2 and IsControlJustPressed(0, Keys["E"]) then
							OpenStash(v["type"], ESX.PlayerData.identifier)
						end
					end
				end
			end
		end
	end
end)

OpenStash = function(type, owner)	
	TriggerEvent("disc-inventoryhud:openInventory", {
		["type"] = type,
		["owner"] = owner,
	})
end
