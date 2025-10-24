local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local function teleportPlayerToCandyCorn()
    local eggHuntFolder = Workspace:FindFirstChild("EggHunt_Baby1")
    if not eggHuntFolder then
        return
    end

    local candyCornObjects = {}
    for _, object in pairs(eggHuntFolder:GetChildren()) do
        if object.Name:match("^BABY_CandyCorn_") then
            table.insert(candyCornObjects, object)
        end
    end

    if #candyCornObjects == 0 then
        return
    end

    local randomObject = candyCornObjects[math.random(1, #candyCornObjects)]
    
    if randomObject:IsA("BasePart") then
        humanoidRootPart.CFrame = CFrame.new(randomObject.Position + Vector3.new(0, 2, 0))
    elseif randomObject:IsA("Model") and randomObject.PrimaryPart then
        humanoidRootPart.CFrame = randomObject.PrimaryPart.CFrame + Vector3.new(0, 2, 0)
    end

    humanoid.Jump = true
end

while true do
    teleportPlayerToCandyCorn()
    wait(0.2)
end
