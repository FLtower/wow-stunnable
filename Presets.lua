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
    { spellId = 5246, auraId = 5246, type = "Disorient" }, -- Warrior - Intimidating Shout
    { spellId = 12323, auraId = 12323, type = "Slow" }, -- Warrior - Piercing Howl
    { spellId = 107570, auraId = 132169, type = "Stun" }, -- Warrior - Storm Bolt
    { spellId = 46968, auraId = 132168, type = "Stun" }, -- Warrior - Shockwave
    -- Rogue
    { spellId = 408, auraId = 408, type = "Stun" }, -- Rogue - Kidney Shot
    { spellId = 1833, auraId = 1833, type = "Stun" }, -- Rogue - Cheap Shot
    { spellId = 1776, auraId = 1776, type = "Incapacitate" }, -- Rogue - Gouge
    { spellId = 2094, auraId = 2094, type = "Disorient" }, -- Rogue - Blind
    -- Hunter
    { spellId = 19577, auraId = 24394, type = "Stun" }, -- Hunter - Intimidation
    { spellId = 474421, auraId = 24394, type = "Stun" }, -- Hunter - Intimidation
    { spellId = 195645, auraId = 195645, type = "Slow" }, -- Hunter - Wing Clip
    { spellId = 5116, auraId = 5116, type = "Slow" }, -- Hunter - Concussive Shot
    { spellId = 187650, auraId = 3355, type = "Incapacitate" }, -- Hunter - Freezing Trap
    { spellId = 187698, auraId = 135299, type = "Slow" }, -- Hunter - Tar Trap
    { spellId = 109248, auraId = 117526, type = "Stun" }, -- Hunter - Binding Shot
    { spellId = 213691, auraId = 213691, type = "Incapacitate" }, -- Hunter - Scatter Shot
    { spellId = 186387, auraId = 186387, type = "Slow" }, -- Hunter - Bursting Shot
    -- Druid
    { spellId = 5211, auraId = 5211, type = "Stun" }, -- Druid - Mighty Bash
    { spellId = 22570, auraId = 203123, type = "Stun" }, -- Druid - Maim
    { spellId = 99, auraId = 99, type = "Incapacitate" }, -- Druid - Incapacitating Roar
    { spellId = 339, auraId = 339, type = "Root" }, -- Druid - Entangling Roots
    { spellId = 102359, auraId = 102359, type = "Root" }, -- Druid - Mass Entanglement
    { spellId = 102793, auraId = 127797, type = "Slow" }, -- Druid - Ursol's Vortex
    { spellId = 132469, auraId = 61391, type = "Slow" }, -- Druid - Typhoon
    --{ spellId = 33786, auraId = 33786, type = "Disorient" }, -- Druid - Cyclone
    { spellId = 78675, auraId = 81261, type = "Silence" }, -- Druid - Solar Beam
    -- Shaman
    { spellId = 2484, auraId = 3600, type = "Slow" }, -- Shaman - Earthbind Totem
    { spellId = 51485, auraId = 64695, type = "Root" }, -- Shaman - Earthgrab Totem
    { spellId = 192058, auraId = 118905, type = "Stun" }, -- Shaman - Capacitor Totem
    { spellId = 51490, auraId = 51490, type = "Slow" }, -- Shaman - Thunderstorm
    { spellId = 305483, auraId = 305485, type = "Stun" }, -- Shaman - Lightning Lasso
    -- Monk
    { spellId = 115078, auraId = 115078, type = "Incapacitate" }, -- Monk - Paralysis
    { spellId = 119381, auraId = 119381, type = "Stun" }, -- Monk - Leg Sweep
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