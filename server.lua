ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('walking_stick', function(source) 
    TriggerClientEvent('stg_walkingstick', source)
end)
