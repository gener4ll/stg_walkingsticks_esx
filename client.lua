ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local used = false

RegisterNetEvent('stg_walkingstick')
AddEventHandler('stg_walkingstick',function()
	ClearPedTasksImmediately(PlayerPedId())
	Citizen.CreateThread(function()
	  if not used then
		local ped = PlayerPedId()
		local propName = "prop_cs_walking_stick"
		local coords = GetEntityCoords(ped)
		local prop = GetHashKey(propName)
  
		local dict = "cellphone@"
		local name = "cellphone_call_to_text"
		RequestWalking("move_lester_caneup")
		SetPedMovementClipset(ped, "move_lester_caneup", 1.0)
		while not HasAnimDictLoaded(dict) do
		  Citizen.Wait(10)
		  RequestAnimDict(dict)
		end
  
		RequestModel(prop)
		while not HasModelLoaded(prop) do
		  Citizen.Wait(100)
		end
  
		attachProps = CreateObject(prop, coords,  true,  false,  false)
		local netid = ObjToNet(attachProps)
		AttachEntityToEntity(attachProps,ped,GetPedBoneIndex(ped, 57005),0.15, 0.0, -0.00, 0.0, 266.0, 0.0, false, false, false, true, 2, true)
		prop = netid
		used = true
	  else
		RequestWalking("move_m@multiplayer")
		SetPedMovementClipset(PlayerPedId(), "move_m@multiplayer", 1.0)
		used = false
		ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
		SetModelAsNoLongerNeeded(prop)
		SetEntityAsMissionEntity(attachProps, true, false)
		DetachEntity(NetToObj(prop), 1, 1)
		DeleteEntity(NetToObj(prop))
		DeleteEntity(attachProps)
		prop = nil
	  end
end)
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function RequestWalking(set)
	RequestAnimSet(set)
	while not HasAnimSetLoaded(set) do
	  Citizen.Wait(1)
	end 
  end