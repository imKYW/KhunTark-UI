local _, ns = ...
local oUF = ns.oUF or oUF

ns.PortraitTimerDB = {
    --'119085', '227723',
    -- Higher up = higher display priority
    -- Raid Debuff for Tank
    '206641', -- Arcane Slash at Trilliax
    '206677', -- Searing Brand at Krosus
    '212492', -- Annihilate at Spellblade
    '218503', -- Recursive Strikes at Botanist
    '205984', -- Frost Gravitational Pull at Star
    '214335', -- Fel Gravitational Pull at Star
    '214167', -- Void Gravitational Pull at Star
    '209615', -- Ablation Explosion at Elisande
    '221606', -- Flames Of Sargeras at Guldan

    -- CCs
    '33786',  -- Cyclone
    '108194', -- Asphyxiate
    '91800',  -- Gnaw
    '47481',  -- Gnaw
    '91797',  -- Monstrous Blow (Dark Transformation)
    '99',     -- Incapacitating Roar
    '163505', -- Rake Stun
    '22570',  -- Maim
    '5211',   -- Mighty Bash
    '3355',   -- Freezing Trap
    '209790', -- Freezing Arrow
    '117526', -- Binding Shot
    '19386',  -- Wyvern Sting
    '24394',  -- Intimidation
    '31661',  -- Dragon's Breath
    '118',    -- Polymorph
    '61305',  -- Polymorph: Black Cat
    '28272',  -- Polymorph: Pig
    '61721',  -- Polymorph: Rabbit
    '61780',  -- Polymorph: Turkey
    '28271',  -- Polymorph: Turtle
    '161353', -- Polymorph: Polar Bear Cub
    '213691', -- Scatter Shot
    '82691',  -- Ring of Frost
    '120086', -- Fists of Fury
    '119381', -- Leg Sweep
    '115078', -- Paralysis
    '105421', -- Blinding Light
    '853',    -- Hammer of Justice
    '20066',  -- Repentance
    '605',    -- Mind Control
    '88625',  -- Holy Word: Chastise
    '64044',  -- Psychic Horror
    '8122',   -- Psychic Scream
    '9484',   -- Shackle Undead
    '226943', -- Mind Bomb Stun
    '87204',  -- Sin and Punishment
    '2094',   -- Blind
    '1833',   -- Cheap Shot
    '1776',   -- Gouge
    '408',    -- Kidney Shot
    '199804', -- Between the Eyes
    '6770',   -- Sap
    '51514',  -- Hex
    '118905', -- Static Charge (Lightning Surge Totem)
    '118345', -- Pulverize
    '118699', -- Fear
    '130616', -- Fear (Glyph of Fear)
    '5484',   -- Howl of Terror
    '6789',   -- Mortal Coil
    '30283',  -- Shadowfury
    '22703',  -- Infernal Awakening Stun
    '89766',  -- Axe Toss (Felguard/Wrathguard)
    '115268', -- Mesmerize (Shivarra)
    '6358',   -- Seduction (Succubus)
    '5246',   -- Intimidating Shout (aoe)
    '132168', -- Shockwave
    '46968',  -- Shockwave
    '132169', -- Storm Bolt
    '20549',  -- War Stomp
    '224729', -- Bursting Shot
    '7922',   -- Warbringer Charge Stun
    '77505',  -- Earthquake Stun
    '107079', -- Quaking Palm
    '179057', -- Chaos Nova
    '200166', -- Metamorphosis Stun
    '205630', -- Illidan's Grasp
    '208618', -- Illidans' Grasp
    '221527', -- Imprison
    
    -- Roots
    '122',    -- Frost Nova
    '33395',  -- Freeze
    '339',    -- Entangling Roots
    '170855', -- Entangling Roots (Nature's Grasp)
    '53148',  -- Charge (Hunter)
    '105771', -- Charge (Warrior)
    '64695',  -- Earthgrab Totem
    '96294',  -- Chains of Ice
    '102359', -- Mass Entanglement
    '114404', -- Void Tendrils
    '116706', -- Disable
    '135373', -- Entrapment
    '136634', -- Narrow Escape
    '55536',  -- Frostweave Net
    '157997', -- Ice Nova
    '45334',  -- Wild Charge
    '16979',  -- Wild Charge
    '162480', -- Steel Trap

    -- Immune
    '19263',  -- Deterrence
    '186265', -- Aspect of the Turtle
    '45438',  -- Ice Block
    '642',    -- Divine Shield    
    '115018', -- Desecrated Ground
    '31821',  -- Aura Mastery
    '1022',   -- Hand of Protection
    '47585',  -- Dispersion
    '31224',  -- Cloak of Shadows
    '8178',   -- Grounding Totem Effect (Grounding Totem)
    '76577',  -- Smoke Bomb
    '88611',  -- Smoke Bomb
    '46924',  -- Bladestorm

    -- Anti CC
    '48792',  -- Icebound Fortitude
    '48707',  -- Anti-Magic Shell
    '23920',  -- Spell Reflection
    '114028', -- Mass Spell Reflection
    '5384',   -- Feign Death

    -- Silence
    '47476',  -- Strangulate
    '81261',  -- Solar Beam
    '15487',  -- Silence (Priest)
    '1330',   -- Garrote - Silence
    '31117',  -- Unstable Affliction Silence
    '31935',  -- Avenger's Shield Silence
    '28730',  -- Arcane Torrent (Mana version)
    '80483',  -- Arcane Torrent (Focus version)
    '25046',  -- Arcane Torrent (Energy version)
    '50613',  -- Arcane Torrent (Runic Power version)
    '69179',  -- Arcane Torrent (Rage version)

    -- Offensive Buffs
    '51690',  -- Killing Spree
    '13750',  -- Adrenaline Rush
    '31884',  -- Avenging Wrath
    '1719',   -- Battle Cry    
    '107574', -- Avatar
    '102543', -- Incarnation: King of the Jungle
    '106951', -- Berserk
    '102560', -- Incarnation: Chosen of Elune
    '12472',  -- Icy Veins
    '193526', -- Trueshot
    '19574',  -- Bestial Wrath
    '186289', -- Aspect of the Eagle
    '51271',  -- Pillar of Frost
    '152279', -- Breath of Sindragosa
    '105809', -- Holy Avenger
    '16166',  -- Elemental Mastery
    '114050', -- Ascendance
    '121471', -- Shadow Blades
    '12292',  -- Bloodbath
    '162264', -- Metamorphosis    

    -- Defensive Buffs
    '122470', -- Touch of Karma
    '116849', -- Life Cocoon
    '33206',  -- Pain Suppression
    '49039',  -- Lichborne
    '5277',   -- Evasion
    '199754', -- Riposte
    '108359', -- Dark Regeneration
    '104773', -- Unending Resolve
    '18499',  -- Berserker Rage
    '61336',  -- Survival Instincts
    '22812',  -- Barkskin
    '102342', -- Iron Bark
    '6940',   -- Hand of Sacrifice
    '110909', -- Alter Time
    '118038', -- Die by the Sword
    '33891',  -- Incarnation: Tree of Life
    '74001',  -- Combat Readiness
    '108271', -- Astral Shift
    '108416', -- Dark Pact
    '47788',  -- Guardian Spirit
    '122783', -- Diffuse Magic
    '12975',  -- Last Stand
    '871',    -- Shield Wall
    '212800', -- Blur
    '55233',  -- Vampiric Blood
    '194679', -- Rune Tap
    '207319', -- Corpse Shield
}

local GetTime = GetTime
local floor, fmod = floor, math.fmod
local day, hour, minute = 86400, 3600, 60

local function ExactTime(time)
    return format("%.1f", time), (time * 100 - floor(time * 100))/100
end

local function FormatTime(s)
    if (s >= day) then
        return format('%dd', floor(s/day + 0.5))
    elseif (s >= hour) then
        return format('%dh', floor(s/hour + 0.5))
    elseif (s >= minute) then
        return format('%dm', floor(s/minute + 0.5))
    end

    return format('%d', fmod(s, minute))
end

local function AuraTimer(self, elapsed)
    self.elapsed = (self.elapsed or 0) + elapsed

    if (self.elapsed < 0.1) then 
        return 
    end

    self.elapsed = 0

    local timeLeft = self.expires - GetTime()
    if (timeLeft <= 0) then
        self.Remaining:SetText(nil)
    else
        if (timeLeft <= 5) then
            self.Remaining:SetText('|cffff0000'..ExactTime(timeLeft)..'|r')
        else
            self.Remaining:SetText(FormatTime(timeLeft))
        end
    end
end

local function UpdateIcon(self, texture, duration, expires, count)
    self.Icon:SetTexture(texture) --SetPortraitToTexture(self.Icon, texture)
    self.Icon:SetTexCoord(0.07, 0.93, 0.07, 0.93) --self.Icon:SetTexCoord(.1, .9, .1, .9)

    if count and count > 0 then
        self.Count:SetText(count)
    else
        self.Count:SetText("")
    end

    self.expires = expires
    self.duration = duration
    self:SetScript('OnUpdate', AuraTimer)
end

local Update = function(self, event, unit)
    if (self.unit ~= unit) then 
        return 
    end

    local pt = self.PortraitTimer
    for _, spellID in ipairs(ns.PortraitTimerDB) do
        local spell = GetSpellInfo(spellID)
        if (UnitBuff(unit, spell)) then
            local name, _, texture, count, _, duration, expires = UnitBuff(unit, spell)
            if count then UpdateIcon(pt, texture, duration, expires, count)
            else
                UpdateIcon(pt, texture, duration, expires)
            end

            pt:Show()

            if (self.CombatFeedbackText) then
                self.CombatFeedbackText.maxAlpha = 0
            end

            return
        elseif (UnitDebuff(unit, spell)) then
            local name, _, texture, count, _, duration, expires = UnitDebuff(unit, spell)
            if count then UpdateIcon(pt, texture, duration, expires, count)
            else
                UpdateIcon(pt, texture, duration, expires)
            end

            pt:Show()

            if (self.CombatFeedbackText) then
                self.CombatFeedbackText.maxAlpha = 0
            end

            return
        else
            if (pt:IsShown()) then
                pt:Hide()
            end

            if (self.CombatFeedbackText) then
                self.CombatFeedbackText.maxAlpha = 1
            end
        end
    end
end

local Enable = function(self)
    local pt = self.PortraitTimer
    if (pt) then
        self:RegisterEvent('UNIT_AURA', Update)
        return true
    end
end

local Disable = function(self)
    local pt = self.PortraitTimer
    if (pt) then
        self:UnregisterEvent('UNIT_AURA', Update)
    end
end

oUF:AddElement('PortraitTimer', Update, Enable, Disable)
