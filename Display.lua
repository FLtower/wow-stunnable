-----------------------------
-- Variables
-----------------------------

local A, N = ...
local Utils = N.Utils
local Presets = N.Presets
N.Display = {}

-- Main frame for this addon
--- @type any[]
local buttons = nil

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

    local barIndex = math.floor(slot / 12) + 1
    local buttonIndex = math.fmod(slot, 12) -- or 'slot % 12'

    -- if ElvUI addon is enabled
    if ElvUI then
        local E = unpack(ElvUI)
        return E.ActionBars.handledBars["bar" .. barIndex].buttons[buttonIndex]
    end

    -- else return wow button
    -- TO FIX
end

-- Init the display by adding two icons to the stun spells
local function InitDisplay()
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
N.Display.InitDisplay = InitDisplay

-- Function used to check if target is stunnable
--- @param value? boolean is target stunnable
local function UpdateDisplay(value)
    Utils.PrintMsgDebug("--> UpdateDisplay " .. (value == nil and "nil" or (value and "true" or "false")))

    for _, button in ipairs(buttons) do
        button.stunnableIconOK:Hide()
        button.stunnableIconKO:Hide()
        if value == true then
            button.stunnableIconOK:Show()
        elseif value == false then
            button.stunnableIconKO:Show()
        end
    end
end
N.Display.UpdateDisplay = UpdateDisplay
