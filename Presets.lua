-----------------------------
-- Variables
-----------------------------

local A, N = ...
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