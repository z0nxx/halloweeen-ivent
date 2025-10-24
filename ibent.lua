local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local function highlightObject(targetObject)
    -- Удаляем предыдущий Highlight, если он есть
    for _, child in pairs(targetObject:GetChildren()) do
        if child:IsA("Highlight") then
            child:Destroy()
        end
    end
    -- Добавляем новый Highlight
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 255, 0) -- Желтый цвет заливки
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0) -- Красный контур
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = targetObject
end

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
                -- Подсвечиваем объект
                highlightObject(targetObject:IsA("Model") and targetObject.PrimaryPart or targetObject)
                
                -- Телепортируем игрока
                if targetObject:IsA("BasePart") then
                    humanoidRootPart.CFrame = CFrame.new(targetObject.Position + Vector3.new(0, 3, 0))
                elseif targetObject:IsA("Model") and targetObject.PrimaryPart then
                    humanoidRootPart.CFrame = targetObject.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
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
    wait(1) -- Задержка 1 секунда на каждом объекте
end
