-----------------------------
-- Variables
-----------------------------

local A, N = ...
N.Presets = {}

-----------------------------
-- Lists
-----------------------------

N.Presets.Spells = {
    { spellId = 853, auraId = 853, type = "Stun" }, -- Paladin - Hammer of Justice
    { spellId = 115750, auraId = 105421, type = "Disorient" }, -- Paladin - Blinding Light
    { spellId = 107570, auraId = 132168, type = "Stun" }, -- Warrior - Shockwave
    { spellId = 46968, auraId = 132169, type = "Stun" }, -- Warrior - Storm Bolt
    { spellId = 408, auraId = 408, type = "Stun" }, -- Rogue - Kidney Shot
    { spellId = 474421, auraId = 24394, type = "Stun" }, -- Hunter - Intimidation
    { spellId = 119381, auraId = 119381, type = "Stun" }, -- Monk - Leg Sweep
    { spellId = 192058, auraId = 118905, type = "Stun" }, -- Shaman - Capacitor Totem
    { spellId = 221562, auraId = 221562, type = "Stun" } -- DK - Asphyxiate
}