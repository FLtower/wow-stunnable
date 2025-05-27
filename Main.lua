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
local Presets = N.Presets
local Utils = N.Utils

-- Main frame for this addon
--- @type Frame
local frame = nil

-- Debugging mode on/off
--- @type boolean
N.DEBUG = true

-----------------------------
-- Functions
-----------------------------

-- Function used to check if target is stunnable
--- @param guid? string GUID of unit to test
local function IsStunnable(guid)
    if not guid then return end

    if not StunnableDB or not StunnableDB.Mobs then return end
    local value = StunnableDB.Mobs[guid]
    Utils.PrintMsgDebug("--> IsStunnable " .. guid .. ": " .. (value and "true" or "false"))
end

-- Function used to save mob stunnable status
--- @param guid? string GUID of unit to test
local function SaveMob(guid, value)
    if not guid then return end

    Utils.PrintMsgDebug("--> SaveMob " .. guid .. ": " .. (value and "true" or "false"))

    if not StunnableDB then StunnableDB = {} end
    if not StunnableDB.Mobs then StunnableDB.Mobs = {} end
    StunnableDB.Mobs[guid] = value
end

-- Callback function after PLAYER_LOGIN event
local function OnPlayerLogin()
    Utils.PrintMsgDebug("--> OnPlayerLogin")
end

-- Callback function after PLAYER_TARGET_CHANGED event
local function OnPlayerTargetChanged()
    Utils.PrintMsgDebug("--> OnPlayerTargetChanged")
    if UnitExists("target") and UnitCanAttack("player", "target") then
        local targetGUID = UnitGUID("target")
        IsStunnable(targetGUID)
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
    if not Utils.TableHasValue(Presets.Spells, tonumber(spellID)) then return end

    if subEvent == "SPELL_AURA_APPLIED" then
        Utils.PrintMsgDebug("Spell aura applied " .. spellID .. " to " .. destGUID)
        SaveMob(destGUID, true)
    end
    if subEvent == "SPELL_MISSED" then
        Utils.PrintMsgDebug("Spell missed " .. spellID .. " to " .. destGUID)
        SaveMob(destGUID, false)
    end
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
frame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
        Utils.PrintMsgDebug("--> Event PLAYER_LOGIN")
		OnPlayerLogin()
	end
    if event == "PLAYER_TARGET_CHANGED" then
        Utils.PrintMsgDebug("--> Event PLAYER_TARGET_CHANGED")
		OnPlayerTargetChanged()
	end
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        -- Utils.PrintMsgDebug("--> Event COMBAT_LOG_EVENT_UNFILTERED")
        local _, subEvent, _, _, _, _, _, destGUID, _, _, _, spellID = CombatLogGetCurrentEventInfo()
		OnCombatLogEventUnfiltered(subEvent, destGUID, spellID)
	end
end)