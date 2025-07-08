-----------------------------
-- Variables
-----------------------------

local A, N = ...
local Utils = N.Utils
N.Presets = {}

-----------------------------
-- Lists
-----------------------------

-- CreatureTypeID https://warcraft.wiki.gg/wiki/API_UnitCreatureType

N.Presets.Spells = {
    -- Paladin
    { spellId = 853, auraId = 853, type = "Stun" }, -- Paladin - Hammer of Justice
    { spellId = 115750, auraId = 105421, type = "Disorient" }, -- Paladin - Blinding Light
    { spellId = 20066, auraId = 20066, type = "Repentance", usableOn = { 2, 3, 5, 6, 7 } }, -- Paladin - Repentance -- Real type is "Incapacitate" -- TO FIX : check auraId
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
    { spellId = 6770, auraId = 6770, type = "Sap", usableOn = { 1, 2, 3, 7 } }, -- Rogue - Sap -- Real type is "Incapacitate"
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
    { spellId = 33786, auraId = 33786, type = "Disorient" }, -- Druid - Cyclone
    -- Mage
    { spellId = 120, auraId = 212792, type = "Slow" }, -- Mage - Cone of Cold
    { spellId = 122, auraId = 122, type = "Root" }, -- Mage - Frost Nova
    { spellId = 157997, auraId = 157997, type = "Root" }, -- Mage - Ice Nova
    { spellId = 113724, auraId = 82691, type = "Incapacitate" }, -- Mage - Ring of Frost
    { spellId = 31661, auraId = 31661, type = "Disorient" }, -- Mage - Dragon's Breath
    { spellId = 118, auraId = 118, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 383121, auraId = 383121, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Mass Polymorph
    { spellId = 161372, auraId = 161372, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 28272, auraId = 28272, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 161354, auraId = 161354, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 277792, auraId = 277792, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 460392, auraId = 460392, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 61305, auraId = 61305, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 161353, auraId = 161353, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 61780, auraId = 61780, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 28271, auraId = 28271, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 161355, auraId = 161355, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 391622, auraId = 391622, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 277787, auraId = 277787, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 126819, auraId = 126819, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 321395, auraId = 321395, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    { spellId = 61721, auraId = 61721, type = "Polymorph", usableOn = { 1, 7, 8 } }, -- Mage - Polymorph
    -- Shaman
    { spellId = 2484, auraId = 3600, type = "Slow" }, -- Shaman - Earthbind Totem
    { spellId = 51485, auraId = 64695, type = "Root" }, -- Shaman - Earthgrab Totem
    { spellId = 192058, auraId = 118905, type = "Stun" }, -- Shaman - Capacitor Totem
    { spellId = 51490, auraId = 51490, type = "Slow" }, -- Shaman - Thunderstorm
    { spellId = 305483, auraId = 305485, type = "Stun" }, -- Shaman - Lightning Lasso
    -- Priest
    { spellId = 453, auraId = 453, type = "Mind Soothe", usableOn = { 2, 7 } }, -- Priest - Mind Soothe
    { spellId = 8122, auraId = 8122, type = "Disorient" }, -- Priest - Psychic Scream
    { spellId = 9484, auraId = 9484, type = "Shackle Undead", usableOn = { 6 } }, -- Priest - Shackle Undead -- Real type is "Stun" -- TO FIX : check auraId
    { spellId = 205364, auraId = 205364, type = "Mind Control", unusableOn = { 3, 6, 9 } }, -- Priest - Dominate Mind -- Real type is "Charm"
    { spellId = 605, auraId = 605, type = "Mind Control", unusableOn = { 3, 6, 9 } }, -- Priest - Mind Control -- Real type is "Possess"
    { spellId = 64044, auraId = 64044, type = "Stun" }, -- Priest - Psychic Horror
    -- Warlock
    { spellId = 5782, auraId = 118699, type = "Fear" }, -- Warlock - Fear -- Fear as Disorient
    { spellId = 6789, auraId = 6789, type = "Fear" }, -- Warlock - Mortal Coil -- Fear as Incapacitate
    { spellId = 5484, auraId = 5484, type = "Fear" }, -- Warlock - Howl of Terror -- Fear as Disorient
    { spellId = 30283, auraId = 30283, type = "Stun" }, -- Warlock - Shadowfury
    { spellId = 384069, auraId = 384069, type = "Slow" }, -- Warlock - Shadowflame
    -- Monk
    { spellId = 115078, auraId = 115078, type = "Incapacitate" }, -- Monk - Paralysis
    { spellId = 119381, auraId = 119381, type = "Stun" }, -- Monk - Leg Sweep
    -- Demon Hunter
    { spellId = 211881, auraId = 211881, type = "Stun" }, -- DH - Fel Eruption
    { spellId = 179057, auraId = 179057, type = "Stun" }, -- DH - Chaos Nova
    { spellId = 207684, auraId = 207685, type = "Disorient" }, -- DH - Sigil of Misery
    { spellId = 202137, auraId = 204490, type = "Silence" }, -- DH - Sigil of Silence
    { spellId = 217832, auraId = 217832, type = "Imprison", usableOn = { 1, 3, 7 } }, -- DH - Imprison -- Real type is "Incapacitate"
    -- Death Knight
    { spellId = 45524, auraId = 45524, type = "Slow" }, -- DK - Chains of Ice
    { spellId = 221562, auraId = 221562, type = "Stun" }, -- DK - Asphyxiate
    { spellId = 207167, auraId = 207167, type = "Disorient" }, -- DK - Blinding Sleet
    { spellId = 111673, auraId = 111673, type = "Control Undead", usableOn = { 6 } } -- DK - Control Undead -- Real type is "Charm" -- TO FIX : check auraId
}

N.Presets.Mobs = {}

-----------------------------
-- Functions
-----------------------------

-- If MDT is installed, get the mobs from the mythic dungeons
--- @return table | nil
local function GetMobs()
    Utils.PrintMsgDebug("---> GetMDTMobs")

    local mobs = {}

    if MDT then
        for key, _ in pairs(MDT.dungeonList) do
            if MDT.dungeonEnemies[key] then
                for _, value in pairs(MDT.dungeonEnemies[key]) do
                    local mobId = value["id"]
                    local slow = value["characteristics"] and value["characteristics"]["Slow"]
                    local stun = value["characteristics"] and value["characteristics"]["Stun"]
                    mobs[mobId] = { Slow = stun or slow or false, Stun = stun or false }
                end
            end
        end
    end

    return mobs
end
N.Presets.GetMobs = GetMobs