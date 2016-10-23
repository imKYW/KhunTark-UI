local _, ns = ...
local oUF = ns.oUF or oUF

-- Tag Function -------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- Gradation Health Color
local healthColor = function(value)    
    local r, g, b = 0, 0, 0

    if value > 0 then value = value / 100
    else
        value = 0
    end
    if value > 0.5 then
        r = (1 - value) * 2
        g = 1
    else
        r = 1
        g = value * 2
    end
    return r, g, b
end

-- Power Color
oUF.colors.power['MANA'] = { 0.37, 0.6, 1 } -- Recoloring for looks good
oUF.colors.power['RAGE'] = { 0.9,  0.3,  0.23 } -- Recoloring for looks good
oUF.colors.power['RUNIC_POWER'] = { 0, 0.81, 1 } -- Recoloring for looks good

local powerColor = function(unit)
    if not unit then return end    
    local _, power, r, g, b = UnitPowerType(unit)
    local color = PowerBarColor[power]

    if color then
        r, g, b = color.r, color.g, color.b
    end
    return r, g, b
end

-- Hex to RGB
local hex = function(r, g, b)
    if not r then return '|cffFFFFFF' end
    if(type(r) == 'table') then
        if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
    end    
    return ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
end

-- Shortcut Number
local scNumber = function(value)
    if value >= 1e9 then
        return ('%.fb'):format(value / 1e9)
    elseif value >= 1e6 then
        return ('%.fm'):format(value / 1e6)
    elseif (value >= 1e3) then
        return ('%.fk'):format(value / 1e3)
    else
        return ('%d'):format(value)
    end
end

-- Shortcut String
local scString = function(string, i, dots)
    local bytes = string:len()

    if bytes <= i then
        return string
    else
        local len, pos = 0, 1
        while pos <= bytes do
            len = len + 1
            local c = string:byte(pos)
            if c > 0 and c <= 127 then
                pos = pos + 1
            elseif c >= 194 and c <= 223 then
                pos = pos + 2
            elseif c >= 224 and c <= 239 then
                pos = pos + 3
            elseif c >= 240 and c <= 244 then
                pos = pos + 4
            end
            if len == i then break end
        end
        if len == i and pos <= bytes then
            return string:sub(1, pos - 1)..(dots and '*' or '')
        else
            return string
        end
    end
end

-- Tag Function -------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- Return Reaction Color at Tag (usually name)
oUF.Tags.Methods['color'] = function(unit)
    local _, class = UnitClass(unit)
    local reaction = UnitReaction(unit, 'player')

    if (UnitIsTapDenied(unit)) then
        return hex(oUF.colors.tapped)
    elseif (UnitIsPlayer(unit)) then
        return hex(oUF.colors.class[class])
    elseif reaction and not (UnitIsPlayer(unit)) then
        return hex(oUF.colors.reaction[reaction])
    else
        return hex(1, 1, 1)
    end
end
oUF.Tags.Events['color'] = 'UNIT_REACTION UNIT_HEALTH'

-- Shortcut name
oUF.Tags.Methods['unit:name4'] = function(unit, raid)
    return scString(UnitName(realUnit or unit or r), 4, true)
end
oUF.Tags.Events['unit:name4'] = 'UNIT_NAME_UPDATE'
oUF.Tags.Methods['unit:name8'] = function(unit, raid)
    return scString(UnitName(realUnit or unit or raid), 8, true)
end
oUF.Tags.Events['unit:name8'] = 'UNIT_NAME_UPDATE'
oUF.Tags.Methods['unit:name10'] = function(unit, raid)
    return scString(UnitName(realUnit or unit or raid), 10, true)
end
oUF.Tags.Events['unit:name10'] = 'UNIT_NAME_UPDATE'

-- LV + Classification
oUF.Tags.Methods['unit:lv'] = function(unit) 
    local level = UnitLevel(unit)
    local classification = UnitClassification(unit)
    local color = GetQuestDifficultyColor(level)

    if level <= 0 then level = '??' end
    if classification == 'worldboss' then
        return hex(color)..level..'!'
    elseif classification == 'rare' then
        return hex(color)..level..'#'
    elseif classification == 'rareelite' then
        return hex(color)..level..'#+'
    elseif classification == 'elite' then
        return hex(color)..level..'+'
    else
        return hex(color)..level
    end
end
oUF.Tags.Events['unit:lv'] = 'UNIT_NAME_UPDATE'

-- Color HP%
oUF.Tags.Methods['unit:HPpercent'] = function(unit)
    local min, max = UnitHealth(unit), UnitHealthMax(unit)

    if UnitIsDead(unit) then
        return "|cff666666Dead|r"
    elseif UnitIsGhost(unit) then
        return "|cff666666Ghost|r"
    elseif not UnitIsConnected(unit) then
        return "|cffe50000Offline|r"
    else
        local healthValue = math.floor(min/max*100+.5)
        return hex(healthColor(healthValue))..healthValue
    end
end
oUF.Tags.Events['unit:HPpercent'] = 'UNIT_HEALTH UNIT_CONNECTION'

-- Current HP
oUF.Tags.Methods['unit:HPcurrent'] = function(unit)
    return scNumber(UnitHealth(unit))
end
oUF.Tags.Events['unit:HPcurrent'] = 'UNIT_HEALTH UNIT_CONNECTION'

-- Current HP if HP = 100%, not Color HP%
oUF.Tags.Methods['unit:HPmix'] = function(unit)
    local min, max = UnitHealth(unit), UnitHealthMax(unit)

    if UnitIsDead(unit) then
        return "|cff666666Dead|r"
    elseif UnitIsGhost(unit) then
        return "|cff666666Ghost|r"
    elseif not UnitIsConnected(unit) then
        return "|cffe50000Offline|r"
    elseif (min < max) then
        local healthValue = math.floor(min / max * 100 + 0.5)
        return hex(healthColor(healthValue))..healthValue
    else
        return scNumber(min)
    end
end
oUF.Tags.Events['unit:HPmix'] = 'UNIT_HEALTH UNIT_CONNECTION'

-- PP% if Using % power, not Current PP
oUF.Tags.Methods['unit:PPflex'] = function(unit)
    local min, max = UnitPower(unit), UnitPowerMax(unit)
    local ptype = UnitPowerType(unit)
    local powerValue = math.floor(min / max * 100 + 0.5)

    if ptype == SPELL_POWER_MANA then
        return hex(powerColor(unit))..powerValue
    elseif powerColor(unit) then
        return hex(powerColor(unit))..min
    else
        return "|cffff00ff"..min.."|r"
    end
end
oUF.Tags.Events['unit:PPflex'] = 'UNIT_DISPLAYPOWER UNIT_POWER_FREQUENT UNIT_MAXPOWER'

-- Player Class Resource
oUF.Tags.Methods['player:Resource'] = function()
    local playerClass = select(2, UnitClass('player'))
    local playerClassSpec = GetSpecializationInfo(GetSpecialization())
    local num = 0

    if UnitHasVehicleUI'player' then
        num = UnitPower('vehicle', SPELL_POWER_COMBO_POINTS)
    -- Soul Shard
    elseif playerClass == 'WARLOCK' then
        num = UnitPower('player', SPELL_POWER_SOUL_SHARDS)
    -- Combo Points
    elseif playerClass == 'ROGUE'
    or playerClassSpec == 104 -- Druid Feral
    or playerClassSpec == 103 -- Druid Guardian
        then
        num = UnitPower('player', SPELL_POWER_COMBO_POINTS)
    -- Chi
    elseif playerClassSpec == 269 then -- Monk Windwalker
        num = UnitPower('player', SPELL_POWER_CHI)
    -- Holy Power
    elseif playerClassSpec == 70 then -- Paladin Retribution 
        num = UnitPower('player', SPELL_POWER_HOLY_POWER)
    -- Arcane Charge
    elseif playerClassSpec == 62 then -- Mage Arcane
        num = UnitPower('player', SPELL_POWER_ARCANE_CHARGES)
    else
        return
    end

    if(num > 0) then
        return num
    end
end
oUF.Tags.Events['player:Resource'] = 'UNIT_POWER SPELLS_CHANGED'

-- Player Mana if Mana is Sub Resource
oUF.Tags.Methods['player:SubMana'] = function()
    local playerClassSpec = GetSpecializationInfo(GetSpecialization())

    if playerClassSpec == 263 -- Shaman Elemental
    or playerClassSpec == 262 -- Shaman Enhancement
    or playerClassSpec == 104 -- Druid Feral
    or playerClassSpec == 103 -- Druid Guardian
    or playerClassSpec == 102 -- Druid Balance
    or playerClassSpec == 258 -- Priest Shadow
        then
        return "|cff5e99ff"..math.floor(UnitPower('player', SPELL_POWER_MANA) / UnitPowerMax('player', SPELL_POWER_MANA) * 100 + 0.5).."|r"
    end
end
oUF.Tags.Events['player:SubMana'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
