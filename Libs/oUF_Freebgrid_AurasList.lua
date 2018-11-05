-- THANKS & CREDITS GOES TO Freebaser (oUF_Freebgrid)
-- http://www.wowinterface.com/downloads/info12264-oUF_Freebgrid.html

local _, A = ...
local oUF = A.oUF or oUF

local spellcache = setmetatable({}, {__index=function(t,v)
    local a = {GetSpellInfo(v)}
    if (GetSpellInfo(v)) then
        t[v] = a
    end

    return a
end})

local function GetSpellInfo(a)
    return unpack(spellcache[a])
end

-- instance name and the instance ID,
-- find out the instance ID by typing this in the chat "/run print(GetCurrentMapAreaID())"
-- Note: Just must be in this instance, when you run the script above
local L = {
    -- BfA Raids
    -- BfA Instances

    -- Legion Raids
    ['Tomb of Sargeras'] = 1147,
    --['Trial of Valor'] = 1114,
    --['Emelard Nightmare'] = 1094,

    -- PVP
    ['PVP'] = 9999,
}

A.auras = {

    -- Ascending aura timer
    -- Add spells to this list to have the aura time count up from 0
    -- NOTE: This does not show the aura, it needs to be in one of the other list too.

    ascending = {
        --[GetSpellInfo(89421)] = true, -- Wrack
    },

    -- General debuffs
    debuffs = {
        --[GetSpellInfo(115804)] = 3, -- Mortal Wounds
        --[GetSpellInfo(51372)] = 1, -- Daze
        --[GetSpellInfo(5246)] = 2, -- Intimidating Shout
        --[GetSpellInfo(6788)] = 16, -- Weakened Soul

        --[GetSpellInfo(1715)] = 20, -- debug
    },

    -- General buffs
    buffs = {
    },

    -- Raid Debuffs
    instances = {
        [L['Tomb of Sargeras']] = {
        },

        [L['PVP']] = {
        },
    },
}
