-----------------------------
-- Variables
-----------------------------

local A, N = ...
local Utils = N.Utils
local Presets = N.Presets
N.Display = {}

-- List of buttons of control spells
--- @type any[] | nil
local buttons = nil

-- Is stunnable
--- @type table
local controls = { Stun = nil }
N.Display.Controls = controls

-----------------------------
-- Functions
-----------------------------

-- Retieve the button that contains the spell
--- @param spellId number spell by id
--- @return any
function GetButtonForSpellId(spellId)
    local slots = C_ActionBar.FindSpellActionButtons(spellId)
    if not slots then return end

    local slot = slots[1]
    if not slot then return end

    local barIndex = math.floor((slot - 1) / 12) + 1
    local buttonIndex = math.fmod((slot - 1), 12) + 1

    -- if ElvUI addon is enabled
    if ElvUI then
        local E = unpack(ElvUI)
        if not E or not E.ActionBars or not E.ActionBars.handledBars or not E.ActionBars.handledBars["bar" .. barIndex] then return end
        return E.ActionBars.handledBars["bar" .. barIndex].buttons[buttonIndex]
    end

    -- else return wow button
    -- TO FIX
end

-- Init the display by adding two icons to the stun spells
local function Init()
    Utils.PrintMsgDebug("---> Display.Init")

    buttons = {}
    for _, spell in ipairs(Presets.Spells) do
        local button = GetButtonForSpellId(spell.spellId)
        if button then
            local iconOK = "Interface/AddOns/Stunnable/Assets/Icons/Check.tga"
            button.stunnableIconOK = button:CreateTexture(nil, "ARTWORK")
            button.stunnableIconOK:SetPoint("BOTTOMRIGHT", -1, 1);
            button.stunnableIconOK:SetSize(24, 24)
            button.stunnableIconOK:SetTexture(iconOK)
            button.stunnableIconOK:Hide()

            local iconKO = "Interface/AddOns/Stunnable/Assets/Icons/Cross.tga"
            button.stunnableIconKO = button:CreateTexture(nil, "ARTWORK")
            button.stunnableIconKO:SetPoint("BOTTOMRIGHT", -1, 1);
            button.stunnableIconKO:SetSize(24, 24)
            button.stunnableIconKO:SetTexture(iconKO)
            button.stunnableIconKO:Hide()

            table.insert(buttons, button)
        end
    end
end
N.Display.Init = Init

-- Clear the display by hiding the icons and reseting the buttons list
local function Clear()
    Utils.PrintMsgDebug("---> Display.Clear")
    
    if not buttons then return end

    for _, button in ipairs(buttons) do
        if button.stunnableIconOK then
            button.stunnableIconOK:Hide()
            button.stunnableIconOK = nil
        end
        if button.stunnableIconKO then
            button.stunnableIconKO:Hide()
            button.stunnableIconKO = nil
        end
    end

    buttons = nil
end
N.Display.Clear = Clear

-- Hide/show icons depending on the stunnable value of the target
local function Update()
    Utils.PrintMsgDebug("---> Display.Update stunnable: " .. (controls.Stun == nil and "nil" or (controls.Stun and "true" or "false")))

    if not buttons then return end

    for _, button in ipairs(buttons) do
        button.stunnableIconOK:Hide()
        button.stunnableIconKO:Hide()
        if controls.Stun == true then
            button.stunnableIconOK:Show()
        elseif controls.Stun == false then
            button.stunnableIconKO:Show()
        end
    end
end
N.Display.Update = Update