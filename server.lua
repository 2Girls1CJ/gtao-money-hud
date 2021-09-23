ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('gtaOHud:GetAccountData', function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)

    local money = xPlayer.getAccount("money").money
    local bank = xPlayer.getAccount("bank").money

    cb({cash = money, bank = bank})
end)