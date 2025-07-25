-----------------------------
-- Variables
-----------------------------

local A, N = ...
N.Utils = {}

-----------------------------
-- Functions
-----------------------------

-- Write message on default chat with prefix
--- @param str string string to write
--- @param isDebug boolean is debug enabled
local function PrintMsg(str, isDebug)
	print("[|cff91ffdc" .. A .. (isDebug and " (Debug)" or "") .. "|r] : " .. str)
end
N.Utils.PrintMsg = PrintMsg

-- Write message on default chat with prefix if debug is enabled
--- @param str string string to write
local function PrintMsgDebug(str)
	if N.DEBUG then PrintMsg(str, true) end
end
N.Utils.PrintMsgDebug = PrintMsgDebug

-- Add color, blizzard way, to string
--- @param str string string to write
--- @param color? string color in hexa foramt argb
--- @return string
local function StrInColor(str, color)
	if not color then color = "ff91ffdc" end
	return "|c" .. color .. str .. "|r"
end
N.Utils.StrInColor = StrInColor

-- Test if a table contains a value
--- @param value any value to test
function table:contains(value)
	for i = 1, #self do
		if (self[i] == value) then
			return true
		end
  	end
  	return false
end