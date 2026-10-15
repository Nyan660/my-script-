local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create GUI Menu
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuraChargeGui"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 140)
frame.Position = UDim2.new(0.5, -130, 0.75, -70)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "Aura & Charge Menu (10Qi)"
titleLabel.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 40)
statusLabel.Position = UDim2.new(0, 0, 0, 30)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.SourceSans
statusLabel.Text = "Status: OFF\nAura: 0 / 10Qi"
statusLabel.Parent = frame

-- On / Off Button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 200, 0, 35)
toggleButton.Position = UDim2.new(0.5, -100, 0, 85)
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 16
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Text = "Toggle: OFF"
toggleButton.Parent = frame

local scriptEnabled = false
local isCharging = false
local chargeAmount = 0
local maxCharge = 10000000000000000000 -- 10 Qi
local chargeSpeed = 1000000000000000000

-- Toggle button click event
toggleButton.MouseButton1Click:Connect(function()
    scriptEnabled = not scriptEnabled
    if scriptEnabled then
        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        toggleButton.Text = "Toggle: ON"
        statusLabel.Text = "Status: ON (Hold E / Touch)\nAura: 0 / 10Qi"
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        toggleButton.Text = "Toggle: OFF"
        statusLabel.Text = "Status: OFF\nAura: 0 / 10Qi"
        isCharging = false
        chargeAmount = 0
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not scriptEnabled or gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.E or input.UserInputType == Enum.UserInputType.Touch then
        isCharging = true
        chargeAmount = 0
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not scriptEnabled then return end
    
    if input.KeyCode == Enum.KeyCode.E or input.UserInputType == Enum.UserInputType.Touch then
        if isCharging then
            isCharging = false
            chargeAmount = 0
            statusLabel.Text = "Status: ON (Released)\nAura: 0 / 10Qi"
        end
    end
end)

RunService.RenderStepped:Connect(function(deltaTime)
    if scriptEnabled and isCharging then
        if chargeAmount < maxCharge then
            chargeAmount = chargeAmount + (chargeSpeed * deltaTime * 1000)
            if chargeAmount >= maxCharge then
                chargeAmount = maxCharge
                isCharging = false
            end
            statusLabel.Text = "Status: Charging...\nAura: " .. math.floor(chargeAmount)
        end
    end
end)
