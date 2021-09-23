ESX = nil
local isShowing = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


RegisterCommand(Config.DefaultCommand, function()
    if not ESX.IsPlayerLoaded() then return end

    if not isShowing then
        ESX.TriggerServerCallback("gtaOHud:GetAccountData", function(accounts) 
            if accounts ~= nil then
                isShowing = true
                SetMultiplayerBankCash()
                SetMultiplayerWalletCash()

                StatSetInt("BANK_BALANCE", accounts.bank, true) -- Bank
                StatSetInt("MP0_WALLET_BALANCE", accounts.cash, true) -- Money

                Citizen.SetTimeout(5000, function()
                    RemoveMultiplayerBankCash()
                    RemoveMultiplayerWalletCash()
                    isShowing = false
                end)
            end
        end)
    end
end, false)



RegisterKeyMapping(Config.DefaultCommand, 'Show cash and bank', 'keyboard', Config.DefaultKey)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	ExecuteCommand(Config.DefaultCommand)
end)
