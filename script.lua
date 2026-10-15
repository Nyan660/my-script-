local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local isCharging = false
local chargeAmount = 0

-- Max charge value (10 Qi / 10 Quintillion) and speed
local maxCharge = 10000000000000000000 -- 10 Qi
local chargeSpeed = 1000000000000000000 -- Speed multiplier

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- When holding screen or pressing 'E'
    if input.KeyCode == Enum.KeyCode.E or input.UserInputType == Enum.UserInputType.Touch then
        isCharging = true
        chargeAmount = 0
        print("Started charging Aura and values...")
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    -- When releasing
    if input.KeyCode == Enum.KeyCode.E or input.UserInputType == Enum.UserInputType.Touch then
        if isCharging then
            isCharging = false
            print("Released! Total amount reached: " .. chargeAmount)
            
            if chargeAmount >= maxCharge then
                print("Max amount reached!")
            end
            
            chargeAmount = 0
        end
    end
end)

RunService.RenderStepped:Connect(function(deltaTime)
    if isCharging then
        if chargeAmount < maxCharge then
            -- Increment charge while holding
            chargeAmount = chargeAmount + (chargeSpeed * deltaTime * 1000)
            
            if chargeAmount >= maxCharge then
                chargeAmount = maxCharge
                isCharging = false
                print("Reached maximum limit automatically!")
            end
        end
    end
end)
