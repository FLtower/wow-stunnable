-----------------------------
-- Variables
-----------------------------

local A, N = ...
local Utils = N.Utils
local Presets = N.Presets
N.Display = {}

-- List of buttons of control spells
--- @type table | nil
local buttons = nil

-- Working controls based the actual target
--- @type table
local target = { CreatureTypeID = nil, Stun = nil }
N.Display.Target = target

-----------------------------
-- Functions
-----------------------------

-- Retieve the buttons that contains the spell
--- @param spellId number spell by id
--- @return table
local function GetButtonsForSpellId(spellId)
    local slots = C_ActionBar.FindSpellActionButtons(spellId) or {}

    local results = {}

    for _, slot in ipairs(slots) do
        local barIndex = math.floor((slot - 1) / 12) + 1
        local buttonIndex = math.fmod((slot - 1), 12) + 1

        if ElvUI then
            -- if ElvUI addon is enabled
            local E = unpack(ElvUI)
            if E and E.ActionBars and E.ActionBars.handledBars and E.ActionBars.handledBars["bar" .. barIndex] then
                table.insert(results, E.ActionBars.handledBars["bar" .. barIndex].buttons[buttonIndex])
            end
        else
            -- else return wow native button
            local bar = nil
            if barIndex == 1 then bar = "Action"
            elseif barIndex == 6 then bar = "MultiBarBottomLeft"
            elseif barIndex == 5 then bar = "MultiBarBottomRight"
            elseif barIndex == 3 then bar = "MultiBarRight"
            elseif barIndex == 4 then bar = "MultiBarLeft"
            elseif barIndex == 13 then bar = "MultiBar5"
            elseif barIndex == 14 then bar = "MultiBar6"
            elseif barIndex == 15 then bar = "MultiBar7" end
            if bar then
                table.insert(results, _G[bar .. "Button" .. buttonIndex])
            end
        end
    end

    return results
end

-- Init the display by adding two icons to the stun spells
local function Init()
    Utils.PrintMsgDebug("---> Display.Init")

    buttons = {}
    for _, spell in ipairs(Presets.Spells) do
        local results = GetButtonsForSpellId(spell.spellId)
        for _, button in ipairs(results) do
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

                button.stunnableSpell = spell

                table.insert(buttons, button)
            end
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
    Utils.PrintMsgDebug("---> Display.Update stunnable: " .. (target.Stun == nil and "nil" or (target.Stun and "true" or "false")))

    if not buttons then return end

    for _, button in ipairs(buttons) do
        button.stunnableIconOK:Hide()
        button.stunnableIconKO:Hide()

        local usableOnTarget = true
        if target.CreatureTypeID and button.stunnableSpell.usableOn then
            usableOnTarget = table.contains(button.stunnableSpell.usableOn, target.CreatureTypeID)
        end
        if target.CreatureTypeID and button.stunnableSpell.unusableOn then
            usableOnTarget = not table.contains(button.stunnableSpell.unusableOn, target.CreatureTypeID)
        end

        if not usableOnTarget then
            button.stunnableIconKO:Show()
        else
            if target.Stun == true then
                button.stunnableIconOK:Show()
            elseif target.Stun == false then
                button.stunnableIconKO:Show()
            end
        end
    end
end
N.Display.Update = Update