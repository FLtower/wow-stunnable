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

-- Main frame for this addon
--- @type Frame
local frame = nil

-- Debugging mode on/off
--- @type boolean
N.DEBUG = true

-----------------------------
-- Functions
-----------------------------

-- Callback function after PLAYER_LOGIN event
local function OnPlayerLogin()
    Utils.PrintMsgDebug("--> OnPlayerLogin")
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
frame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
        Utils.PrintMsgDebug("--> Event PLAYER_LOGIN")
		OnPlayerLogin()
	end
end)