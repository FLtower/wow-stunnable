--[[
    Stunnable
        Version:    1.0 - 2025/05/27
        Author:     Zaki
]]--

-----------------------------
-- Variables
-----------------------------

-- A is addon name string and N is namespace table
local A, N = ...
local Utils = N.Utils
local Presets = N.Presets
local Display = N.Display

-- Main frame for this addon
--- @type Frame
local frame = nil

-- Debugging mode on/off
--- @type boolean
N.DEBUG = false

-----------------------------
-- Functions
-----------------------------

-- Check if a spell is a stun spell and if yes returns its type
--- @param spellId any the value to check
--- @return "Slow" | "Stun" | nil
local function IsStunSpell(spellId)
    for _, spell in ipairs(Presets.Spells) do
        if spell.spellId == spellId or spell.auraId == spellId then
            return spell.type == "Slow" and "Slow" or "Stun"
        end
    end
    return nil
end

-- Function used to check if target is stunnable
--- @param npcID? number ID of unit to test
local function IsStunnable(npcID)
    if not npcID then return end

    local value = { Slow = nil, Stun = nil }
    if StunnableDB and StunnableDB.Mobs and StunnableDB.Mobs[npcID] ~= nil then
        Utils.PrintMsgDebug("---> IsStunnable npcID: " .. npcID .. " found in DB")
        value = StunnableDB.Mobs[npcID]
    elseif Presets and Presets.Mobs and Presets.Mobs[npcID] ~= nil then
        Utils.PrintMsgDebug("---> IsStunnable npcID: " .. npcID .. " found in Presets")
        value = Presets.Mobs[npcID]
    end

    Display.Target.Slow = value.Slow
    Display.Target.Stun = value.Stun
    Display.Update()
end

-- Function used to save mob stunnable status
--- @param npcID number ID of unit to test
--- @param type "Slow" | "Stun" type of the control
--- @param value boolean the stunnable value
local function SaveMob(npcID, type, value)
    if not npcID then return end

    if not StunnableDB then StunnableDB = {} end
    if not StunnableDB.Mobs then StunnableDB.Mobs = {} end
    if not StunnableDB.Mobs[npcID] then StunnableDB.Mobs[npcID] = {} end

    StunnableDB.Mobs[npcID][type] = value
    if value and type == "Stun" then
        StunnableDB.Mobs[npcID]["Slow"] = value
    end

    Utils.PrintMsgDebug("---> SaveMob npcID: " .. npcID .. " " .. type .. " = " .. (value and "true" or false))

    if Display.Target[type] == nil then
        IsStunnable(npcID)
    end
end

-- Callback function after PLAYER_TARGET_CHANGED event
local function OnPlayerTargetChanged()
    Utils.PrintMsgDebug("--> OnPlayerTargetChanged")
    if UnitExists("target") and not UnitIsPlayer("target") and UnitCanAttack("player", "target") then
        local targetGUID = UnitGUID("target")
        local _, targetCreatureTypeID = UnitCreatureType("target")
        if targetGUID and targetCreatureTypeID then
            Display.Target.CreatureTypeID = targetCreatureTypeID
            local npcID = tonumber(select(6, strsplit("-", targetGUID)), 10)
            IsStunnable(npcID)
        end
    else
        Display.Target.CreatureTypeID = nil
        Display.Target.Slow = nil
        Display.Target.Stun = nil
        Display.Update()
    end
end

-- Callback function after COMBAT_LOG_EVENT_UNFILTERED event
--- @param subEvent string subEvent
--- @param destGUID string GUID of unit to gets the aura
--- @param spellID? string ID of the spell
local function OnCombatLogEventUnfiltered(subEvent, destGUID, spellID)
    -- Utils.PrintMsgDebug("--> OnCombatLogEventUnfiltered")

    if not subEvent or not destGUID or not spellID then return end
    if subEvent ~= "SPELL_AURA_APPLIED" and subEvent ~= "SPELL_MISSED" then return end

    local stunSpellType = IsStunSpell(tonumber(spellID))
    if not stunSpellType then return end

    local npcID = tonumber(select(6, strsplit("-", destGUID)), 10)
    if not npcID then return end

    if subEvent == "SPELL_AURA_APPLIED" then
        Utils.PrintMsgDebug("Spell aura applied " .. spellID .. " to " .. npcID)
        SaveMob(npcID, stunSpellType, true)
    end
    if subEvent == "SPELL_MISSED" then
        Utils.PrintMsgDebug("Spell missed " .. spellID .. " to " .. npcID)
        SaveMob(npcID, stunSpellType, false)
    end
end

-- Callback function after ACTIONBAR_SLOT_CHANGED event
local function OnActionbarSlotChanged()
    Utils.PrintMsgDebug("--> OnActionbarSlotChanged")
    Display.Clear()
    Display.Init()
    Display.Update()
end

-- Callback function after PLAYER_LOGIN event
local function OnPlayerLogin()
    Utils.PrintMsgDebug("--> OnPlayerLogin")
    Presets.Mobs = Presets.GetMobs()
    Display.Init()
end

-- Called by slash command
--- @param arguments table list of arguments from text splitted by space
local function SlashCmd(arguments)
    
end

-----------------------------
-- Implementation
-----------------------------

SLASH_STUNNABLE1 = "/stunnable"
SlashCmdList["STUNNABLE"] = function(msg, editbox)
    Utils.PrintMsgDebug("--> Slash command")
    local arguments = {}
    for k, v in string.gmatch(msg, "%a+") do
        arguments[k] = v
    end
    SlashCmd(arguments)
end

frame = CreateFrame("FRAME", "Stunnable", UIParent)
frame:RegisterEvent("PLAYER_LOGIN") -- Fired on connection/reload
frame:RegisterEvent("PLAYER_TARGET_CHANGED") -- Fired whenever the player's target is changed
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") -- Used to parse all events the moment they happen
frame:RegisterEvent("ACTIONBAR_SLOT_CHANGED") -- Used to update the icons positions on spells
frame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
        Utils.PrintMsgDebug("-> Event PLAYER_LOGIN")
		OnPlayerLogin()
	end
    if event == "PLAYER_TARGET_CHANGED" then
        Utils.PrintMsgDebug("-> Event PLAYER_TARGET_CHANGED")
		OnPlayerTargetChanged()
	end
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        -- Utils.PrintMsgDebug("-> Event COMBAT_LOG_EVENT_UNFILTERED")
        local _, subEvent, _, _, _, _, _, destGUID, _, _, _, spellID = CombatLogGetCurrentEventInfo()
		OnCombatLogEventUnfiltered(subEvent, destGUID, spellID)
	end
    if event == "ACTIONBAR_SLOT_CHANGED" then
        Utils.PrintMsgDebug("-> Event ACTIONBAR_SLOT_CHANGED")
        OnActionbarSlotChanged()
	end
end)