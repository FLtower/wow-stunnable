-----------------------------
-- Variables
-----------------------------

local A, N = ...
local Utils = N.Utils
N.Presets = {}

-----------------------------
-- Lists
-----------------------------

N.Presets.Spells = {
    -- Paladin
    { spellId = 853, auraId = 853, type = "Stun" }, -- Paladin - Hammer of Justice
    { spellId = 115750, auraId = 105421, type = "Disorient" }, -- Paladin - Blinding Light
    -- Warrior
    { spellId = 107570, auraId = 132169, type = "Stun" }, -- Warrior - Storm Bolt
    { spellId = 46968, auraId = 132168, type = "Stun" }, -- Warrior - Shockwave
    -- Rogue
    { spellId = 408, auraId = 408, type = "Stun" }, -- Rogue - Kidney Shot
    { spellId = 1833, auraId = 1833, type = "Stun" }, -- Rogue - Cheap Shot
    { spellId = 1776, auraId = 1776, type = "Incapacitate" }, -- Rogue - Gouge
    { spellId = 2094, auraId = 2094, type = "Disorient" }, -- Rogue - Blind
    -- Hunter
    { spellId = 474421, auraId = 24394, type = "Stun" }, -- Hunter - Intimidation
    -- Monk
    { spellId = 115078, auraId = 115078, type = "Incapacitate" }, -- Monk - Paralysis
    { spellId = 119381, auraId = 119381, type = "Stun" }, -- Monk - Leg Sweep
    -- Shaman
    { spellId = 192058, auraId = 118905, type = "Stun" }, -- Shaman - Capacitor Totem
    -- Death Knight
    { spellId = 221562, auraId = 221562, type = "Stun" } -- DK - Asphyxiate
}

N.Presets.Mobs = {}

-----------------------------
-- Functions
-----------------------------

-- If MDT is installed, get the mobs from the mythic dungeons
--- @return table | nil
local function GetMobs()
    Utils.PrintMsgDebug("--> GetMDTMobs")

    local mobs = {}

    if MDT then
        for key, _ in pairs(MDT.dungeonList) do
            if MDT.dungeonEnemies[key] then
                for _, value in pairs(MDT.dungeonEnemies[key]) do
                    local mobId = value["id"]
                    local stunnable = value["characteristics"] and value["characteristics"]["Stun"]
                    mobs[mobId] = stunnable or false
                end
            end
        end
    end

    return mobs
end
N.Presets.GetMobs = GetMobs