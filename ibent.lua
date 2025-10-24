local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local function teleportPlayerToCandyCorn(number)
    local folders = {
        "EggHunt_Baby1",
        "EggHunt_Medium1",
        "EggHunt_Easy1",
        "EggHunt_Hard1",
        "EggHunt_Extreme1"
    }
    local prefixes = {
        "BABY_CandyCorn_",
        "NORMAL_CandyCorn_",
        "EASY_CandyCorn_",
        "HARD_CandyCorn_",
        "EXTREME_CandyCorn_"
    }

    for i, folderName in ipairs(folders) do
        local folder = Workspace:FindFirstChild(folderName)
        if folder then
            local objectName = prefixes[i] .. number
            local targetObject = folder:FindFirstChild(objectName)
            if targetObject then
                if targetObject:IsA("BasePart") then
                    humanoidRootPart.CFrame = CFrame.new(targetObject.Position + Vector3.new(0, 2, 0))
                elseif targetObject:IsA("Model") and targetObject.PrimaryPart then
                    humanoidRootPart.CFrame = targetObject.PrimaryPart.CFrame + Vector3.new(0, 2, 0)
                end
                humanoid.Jump = true
                return true
            end
        end
    end
    return false
end

for i = 1, 100 do
    local success = teleportPlayerToCandyCorn(i)
    if not success then
        warn("Object with number " .. i .. " not found in any folder")
    end
    wait(0.2)
end
