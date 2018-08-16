-- THANKS & CREDITS GOES TO Freebaser (oUF_Freebgrid)
-- http://www.wowinterface.com/downloads/info12264-oUF_Freebgrid.html

local _, ns = ...
local oUF = ns.oUF or oUF

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

ns.auras = {

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
        -- Immunities
        [GetSpellInfo(642)]    = 10, -- Divine Shield
        [GetSpellInfo(186265)] = 10, -- Aspect of the Turtle
        [GetSpellInfo(45438)]  = 10, -- Ice Block
        [GetSpellInfo(47585)]  = 10, -- Dispersion
        [GetSpellInfo(1022)]   = 10, -- Blessing of Protection
        [GetSpellInfo(216113)] = 10, -- Way of the Crane
        [GetSpellInfo(31224)]  = 10, -- Cloak of Shadows
        [GetSpellInfo(212182)] = 10, -- Smoke Bomb
        [GetSpellInfo(212183)] = 10, -- Smoke Bomb
        [GetSpellInfo(8178)]   = 10, -- Grounding Totem Effect
        [GetSpellInfo(199448)] = 10, -- Blessing of Sacrifice

        -- Anti CCs
        [GetSpellInfo(23920)]  = 9, -- Spell Reflection
        [GetSpellInfo(216890)] = 9, -- Spell Reflection (Honor Talent)
        [GetSpellInfo(213610)] = 9, -- Holy Ward
        [GetSpellInfo(212295)] = 9, -- Nether Ward
        [GetSpellInfo(48707)]  = 9, -- Anti-Magic Shell
        [GetSpellInfo(5384)]   = 9, -- Feign Death
        [GetSpellInfo(213602)] = 9, -- Greater Fade

        -- Offensive Buffs
        [GetSpellInfo(1719)]   = 5, -- [Warrior] Battle Cry
        [GetSpellInfo(107574)] = 5, -- [Warrior] Avatar
        [GetSpellInfo(12292)]  = 5, -- [Warrior] Bloodbath
        [GetSpellInfo(31884)]  = 5, -- [Paladin] Avenging Wrath (Retribution)
        [GetSpellInfo(19574)]  = 5, -- [Hunter] Bestial Wrath
        [GetSpellInfo(186289)] = 5, -- [Hunter] Aspect of the Eagle
        [GetSpellInfo(193526)] = 5, -- [Hunter] Trueshot
        [GetSpellInfo(13750)]  = 5, -- [Rogue] Adrenaline Rush
        [GetSpellInfo(51690)]  = 5, -- [Rogue] Killing Spree
        [GetSpellInfo(121471)] = 5, -- [Rogue] Shadow Blades
        [GetSpellInfo(10060)]  = 5, -- [Priest] Power Infusion
        [GetSpellInfo(194249)] = 5, -- [Priest] Voidform
        [GetSpellInfo(51271)]  = 5, -- [DK] Pillar of Frost
        [GetSpellInfo(152279)] = 5, -- [DK] Breath of Sindragosa
        [GetSpellInfo(2825)]   = 5, -- [Shaman] Bloodlust
        [GetSpellInfo(32182)]  = 5, -- [Shaman] Heroism
        [GetSpellInfo(16166)]  = 5, -- [Shaman] Elemental Mastery
        [GetSpellInfo(114050)] = 5, -- [Shaman] Ascendance (Elemental)
        [GetSpellInfo(114051)] = 5, -- [Shaman] Ascendance (Enhancement)
        [GetSpellInfo(204361)] = 5, -- [Shaman] Bloodlust (Honor Talent)
        [GetSpellInfo(204362)] = 5, -- [Shaman] Heroism (Honor Talent)
        [GetSpellInfo(204945)] = 5, -- [Shaman] Doom Winds
        [GetSpellInfo(12042)]  = 5, -- [Mage] Arcane Power
        [GetSpellInfo(12472)]  = 5, -- [Mage] Icy Veins
        [GetSpellInfo(190319)] = 5, -- [Mage] Combustion
        [GetSpellInfo(198144)] = 5, -- [Mage] Ice Form
        [GetSpellInfo(196098)] = 5, -- [Warlock] Soul Harvest
        [GetSpellInfo(137639)] = 5, -- [Monk] Storm, Earth, and Fire
        [GetSpellInfo(152173)] = 5, -- [Monk] Serenity
        [GetSpellInfo(102543)] = 5, -- [Duruid] Incarnation: King of the Jungle
        [GetSpellInfo(102560)] = 5, -- [Duruid] Incarnation: Chosen of Elune
        [GetSpellInfo(106951)] = 5, -- [Duruid] Berserk
        [GetSpellInfo(194223)] = 5, -- [Duruid] Celestial Alignment
        [GetSpellInfo(162264)] = 5, -- [DH] Metamorphosis
        --[GetSpellInfo(211048)] = 5, -- [DH] Chaos Blades

        -- Defensive Buffs
        [GetSpellInfo(210256)] = 4, -- Blessing of Sanctuary
        [GetSpellInfo(6940)]   = 4, -- Blessing of Sacrifice
        [GetSpellInfo(125174)] = 4, -- Touch of Karma
        [GetSpellInfo(47788)]  = 4, -- Guardian Spirit
        [GetSpellInfo(197268)] = 4, -- Ray of Hope
        [GetSpellInfo(5277)]   = 4, -- Evasion
        [GetSpellInfo(199754)] = 4, -- Riposte
        [GetSpellInfo(212800)] = 4, -- Blur
        [GetSpellInfo(102342)] = 4, -- Ironbark
        [GetSpellInfo(22812)]  = 4, -- Barkskin
        [GetSpellInfo(117679)] = 4, -- Incarnation: Tree of Life
        [GetSpellInfo(198065)] = 4, -- Prismatic Cloak
        [GetSpellInfo(198111)] = 4, -- Temporal Shield
        [GetSpellInfo(108271)] = 4, -- Astral Shift
        [GetSpellInfo(114052)] = 4, -- Ascendance (Restoration)
        [GetSpellInfo(207319)] = 4, -- Corpse Shield
        [GetSpellInfo(104773)] = 4, -- Unending Resolve
        [GetSpellInfo(48792)]  = 4, -- Icebound Fortitude
        [GetSpellInfo(55233)]  = 4, -- Vampiric Blood
        [GetSpellInfo(61336)]  = 4, -- Survival Instincts
        [GetSpellInfo(116849)] = 4, -- Life Cocoon
        [GetSpellInfo(33206)]  = 4, -- Pain Suppression
        [GetSpellInfo(197862)] = 4, -- Archangel
        [GetSpellInfo(31850)]  = 4, -- Ardent Defender
        [GetSpellInfo(120954)] = 4, -- Fortifying Brew
        [GetSpellInfo(108416)] = 4, -- Dark Pact
        [GetSpellInfo(216331)] = 4, -- Avenging Crusader
        --[GetSpellInfo(31842)]  = 4, -- Avenging Wrath (Holy)
        [GetSpellInfo(118038)] = 4, -- Die by the Sword
        [GetSpellInfo(12975)]  = 4, -- Last Stand
        [GetSpellInfo(205191)] = 4, -- Eye for an Eye
        [GetSpellInfo(498)]    = 4, -- Divine Protection
        [GetSpellInfo(871)]    = 4, -- Shield Wall
        [GetSpellInfo(53480)]  = 4, -- Roar of Sacrifice
        [GetSpellInfo(197690)] = 4, -- Defensive Stance

        -- Miscellaneous
        [GetSpellInfo(199450)] = 1, -- Ultimate Sacrifice
        [GetSpellInfo(188501)] = 1, -- Spectral Sight
        [GetSpellInfo(1044)]   = 1, -- Blessing of Freedom
    },

    -- Raid Debuffs
    instances = {
        [L['Tomb of Sargeras']] = {
            -- Goroth
            [GetSpellInfo(231363)] = 11, -- Tanker : Burning Armor
            [GetSpellInfo(234264)] = 11, -- Tanker : Melted Armor
            [GetSpellInfo(233272)] = 7, -- Shattering Star
            [GetSpellInfo(230345)] = 7, -- Crashing Comet

            -- Demonic Inquisition
            [GetSpellInfo(233431)] = 7, -- Calcified Quills
            [GetSpellInfo(233983)] = 7, -- Echoing Anguish
            [GetSpellInfo(248713)] = 3, -- Soul Corruption

            -- Harjatan
            [GetSpellInfo(231998)] = 11, -- Tanker : Jagged Abrasion
            [GetSpellInfo(231729)] = 8, -- Aqueous Burst
            [GetSpellInfo(234016)] = 7, -- Driven Assault
            [GetSpellInfo(241600)] = 7, -- Sickly Fixate
            [GetSpellInfo(231770)] = 3, -- Drenched

            -- Mistress Sassz'ine
            [GetSpellInfo(230201)] = 14, -- Tanker : Burden of Pain
            [GetSpellInfo(230139)] = 13, -- Hydra Shot
            [GetSpellInfo(239375)] = 12, -- Delicious Bufferfish
            [GetSpellInfo(230920)] = 11, -- Consuming Hunger
            [GetSpellInfo(232913)] = 7, -- Befouling Ink
            [GetSpellInfo(232732)] = 5, -- Slicing Tornado
            [GetSpellInfo(232754)] = 4, -- Hydra Acid
            [GetSpellInfo(230276)] = 3, -- Jaws from the Deep

            -- Sisters of the Moon
            [GetSpellInfo(236305)] = 13, -- Incorporeal Shot
            [GetSpellInfo(236712)] = 12, -- Lunar Beacon
            [GetSpellInfo(239264)] = 11, -- Lunar Fire
            [GetSpellInfo(236596)] = 11, -- Rapid Shot
            [GetSpellInfo(237561)] = 9, -- Twilight Glaive
            [GetSpellInfo(236519)] = 8, -- Moon Burn
            [GetSpellInfo(236330)] = 7, -- Astral Vulnerability
            [GetSpellInfo(236550)] = 4, -- Discoporate
            [GetSpellInfo(234996)] = 3, -- Suffusion Dark
            [GetSpellInfo(234995)] = 3, -- Suffusion Light

            -- The Desolate Host
            [GetSpellInfo(236459)] = 13, -- Soulbind
            [GetSpellInfo(235924)] = 12, -- Spear of Anguish
            [GetSpellInfo(238018)] = 11, -- Tormented Cries
            [GetSpellInfo(236340)] = 7, -- Crush Mind
            [GetSpellInfo(236515)] = 7, -- Shattering Scream
            [GetSpellInfo(236138)] = 3, -- Wither

            -- Maiden of Vigilance
            [GetSpellInfo(243276)] = 11, -- Unstable Soul
            [GetSpellInfo(235534)] = 7, -- Buff of Orbs : Light
            [GetSpellInfo(235538)] = 7, -- Buff of Orbs : Fel
            [GetSpellInfo(235213)] = 3, -- Infusions : Light
            [GetSpellInfo(235240)] = 3, -- Infusions : Fel

            -- Fallen Avatar
            [GetSpellInfo(236494)] = 12, -- Tanker : Desolate
            [GetSpellInfo(239739)] = 11, -- Dark Mark
            [GetSpellInfo(237666)] = 11, -- Shadowy Blades
            [GetSpellInfo(240728)] = 7, -- Tainted Essence
            [GetSpellInfo(242017)] = 3, -- Black Winds
            [GetSpellInfo(234059)] = 3, -- Unbound Chaos

            -- Kil'Jaeden
            [GetSpellInfo(236710)] = 12, -- Shadow Reflection : Tanker
            [GetSpellInfo(236378)] = 12, -- Shadow Reflection : Other
            [GetSpellInfo(245509)] = 11, -- Felclaws
            [GetSpellInfo(239155)] = 7, -- Gravity Squeeze
            [GetSpellInfo(240916)] = 5, -- Armageddon Rain
            [GetSpellInfo(234310)] = 4, -- Armageddon Rain
            [GetSpellInfo(241721)] = 3, -- Illidan Buff
        },

        [L['PVP']] = {


        --[[ temp remove
            -- Higher up = higher display priority
            --1 무적�?
            --2 부분무?�기
            --3 ?�드메즈�?
            --4 매즈�?
            --5 ?�로??

            [GetSpellInfo(5211)]   = 15, -- Mighty Bash (Stun)
            [GetSpellInfo(108194)] = 15, -- Asphyxiate (Stun)
            [GetSpellInfo(199804)] = 15, -- Between the Eyes (Stun)
            [GetSpellInfo(118905)] = 15, -- Static Charge (Stun)
            [GetSpellInfo(1833)]   = 15, -- Cheap Shot (Stun)
            [GetSpellInfo(853)]    = 15, -- Hammer of Justice (Stun)
            [GetSpellInfo(117526)] = 15, -- Binding Shot (Stun)
            [GetSpellInfo(179057)] = 15, -- Chaos Nova (Stun)
            [GetSpellInfo(207171)] = 15, -- Winter is Coming (Stun)
            [GetSpellInfo(132169)] = 15, -- Storm Bolt (Stun)
            [GetSpellInfo(408)]    = 15, -- Kidney Shot (Stun)
            [GetSpellInfo(163505)] = 15, -- Rake (Stun)
            [GetSpellInfo(119381)] = 15, -- Leg Sweep (Stun)
            [GetSpellInfo(232055)] = 15, -- Fists of Fury (Stun)
            [GetSpellInfo(89766)]  = 15, -- Axe Toss (Stun)
            [GetSpellInfo(30283)]  = 15, -- Shadowfury (Stun)
            [GetSpellInfo(200166)] = 15, -- Metamorphosis (Stun)
            [GetSpellInfo(226943)] = 15, -- Mind Bomb (Stun)
            [GetSpellInfo(24394)]  = 15, -- Intimidation (Stun)
            [GetSpellInfo(211881)] = 15, -- Fel Eruption (Stun)
            [GetSpellInfo(221562)] = 15, -- Asphyxiate, Blood Spec (Stun)
            [GetSpellInfo(91800)]  = 15, -- Gnaw (Stun)
            [GetSpellInfo(91797)]  = 15, -- Monstrous Blow (Stun)
            [GetSpellInfo(205630)] = 15, -- Illidan's Grasp (Stun)
            [GetSpellInfo(208618)] = 15, -- Illidan's Grasp (Stun)
            [GetSpellInfo(203123)] = 15, -- Maim (Stun)
            [GetSpellInfo(200200)] = 15, -- Holy Word: Chastise, Censure Talent (Stun)
            [GetSpellInfo(118345)] = 15, -- Pulverize (Stun)
            [GetSpellInfo(22703)]  = 15, -- Infernal Awakening (Stun)
            [GetSpellInfo(132168)] = 15, -- Shockwave (Stun)
            [GetSpellInfo(20549)]  = 15, -- War Stomp (Stun)
            [GetSpellInfo(199085)] = 15, -- Warpath (Stun)

            [GetSpellInfo(33786)]  = 14, -- Cyclone (Disorient)
            [GetSpellInfo(209753)] = 14, -- Cyclone, Honor Talent (Disorient)
            [GetSpellInfo(5246)]   = 14, -- Intimidating Shout (Disorient)
            [GetSpellInfo(238559)] = 14, -- Bursting Shot (Disorient)
            [GetSpellInfo(224729)] = 14, -- Bursting Shot on NPC's (Disorient)
            [GetSpellInfo(8122)]   = 14, -- Psychic Scream (Disorient)
            [GetSpellInfo(2094)]   = 14, -- Blind (Disorient)
            [GetSpellInfo(5484)]   = 14, -- Howl of Terror (Disorient)
            [GetSpellInfo(605)]    = 14, -- Mind Control (Disorient)
            [GetSpellInfo(105421)] = 14, -- Blinding Light (Disorient)
            [GetSpellInfo(207167)] = 14, -- Blinding Sleet (Disorient)
            [GetSpellInfo(31661)]  = 14, -- Dragon's Breath (Disorient)
            [GetSpellInfo(207685)] = 14, -- Sigil of Misery
            [GetSpellInfo(198909)] = 14, -- Song of Chi-ji
            [GetSpellInfo(202274)] = 14, -- Incendiary Brew
            [GetSpellInfo(5782)]   = 14, -- Fear
            [GetSpellInfo(118699)] = 14, -- Fear
            [GetSpellInfo(130616)] = 14, -- Fear
            [GetSpellInfo(115268)] = 14, -- Mesmerize
            [GetSpellInfo(6358)]   = 14, -- Seduction

            [GetSpellInfo(51514)]  = 13, -- Hex (Incapacitate)
            [GetSpellInfo(211004)] = 13, -- Hex: Spider (Incapacitate)
            [GetSpellInfo(210873)] = 13, -- Hex: Raptor (Incapacitate)
            [GetSpellInfo(211015)] = 13, -- Hex: Cockroach (Incapacitate)
            [GetSpellInfo(211010)] = 13, -- Hex: Snake (Incapacitate)
            [GetSpellInfo(196942)] = 13, -- Hex (Voodoo Totem)
            [GetSpellInfo(118)]    = 13, -- Polymorph (Incapacitate)
            [GetSpellInfo(61305)]  = 13, -- Polymorph: Black Cat (Incapacitate)
            [GetSpellInfo(28272)]  = 13, -- Polymorph: Pig (Incapacitate)
            [GetSpellInfo(61721)]  = 13, -- Polymorph: Rabbit (Incapacitate)
            [GetSpellInfo(61780)]  = 13, -- Polymorph: Turkey (Incapacitate)
            [GetSpellInfo(28271)]  = 13, -- Polymorph: Turtle (Incapacitate)
            [GetSpellInfo(161353)] = 13, -- Polymorph: Polar Bear Cub (Incapacitate)
            [GetSpellInfo(126819)] = 13, -- Polymorph: Porcupine (Incapacitate)
            [GetSpellInfo(161354)] = 13, -- Polymorph: Monkey (Incapacitate)
            [GetSpellInfo(161355)] = 13, -- Polymorph: Penguin (Incapacitate)
            [GetSpellInfo(161372)] = 13, -- Polymorph: Peacock (Incapacitate)
            [GetSpellInfo(3355)]   = 13, -- Freezing Trap (Incapacitate)
            [GetSpellInfo(203337)] = 13, -- Freezing Trap, Diamond Ice Honor Talent (Incapacitate)
            [GetSpellInfo(115078)] = 13, -- Paralysis (Incapacitate)
            [GetSpellInfo(213691)] = 13, -- Scatter Shot (Incapacitate)
            [GetSpellInfo(6770)]   = 13, -- Sap (Incapacitate)
            [GetSpellInfo(199743)] = 13, -- Parley (Incapacitate)
            [GetSpellInfo(20066)]  = 13, -- Repentance (Incapacitate)
            [GetSpellInfo(19386)]  = 13, -- Wyvern Sting (Incapacitate)
            [GetSpellInfo(6789)]   = 13, -- Mortal Coil (Incapacitate)
            [GetSpellInfo(200196)] = 13, -- Holy Word: Chastise (Incapacitate)
            [GetSpellInfo(221527)] = 13, -- Imprison, Detainment Honor Talent (Incapacitate)
            [GetSpellInfo(217832)] = 13, -- Imprison (Incapacitate)
            [GetSpellInfo(99)]     = 13, -- Incapacitating Roar (Incapacitate)
            [GetSpellInfo(82691)]  = 13, -- Ring of Frost (Incapacitate)
            [GetSpellInfo(9484)]   = 13, -- Shackle Undead (Incapacitate)
            [GetSpellInfo(64044)]  = 13, -- Psychic Horror (Incapacitate)
            [GetSpellInfo(1776)]   = 13, -- Gouge (Incapacitate)
            [GetSpellInfo(710)]    = 13, -- Banish (Incapacitate)
            [GetSpellInfo(107079)] = 13, -- Quaking Palm (Incapacitate)
            [GetSpellInfo(236025)] = 13, -- Enraged Maim (Incapacitate)

            -- Silences
            [GetSpellInfo(81261)]  = 8, -- Solar Beam
            [GetSpellInfo(25046)]  = 8, -- Arcane Torrent
            [GetSpellInfo(28730)]  = 8, -- Arcane Torrent
            [GetSpellInfo(50613)]  = 8, -- Arcane Torrent
            [GetSpellInfo(69179)]  = 8, -- Arcane Torrent
            [GetSpellInfo(80483)]  = 8, -- Arcane Torrent
            [GetSpellInfo(129597)] = 8, -- Arcane Torrent
            [GetSpellInfo(155145)] = 8, -- Arcane Torrent
            [GetSpellInfo(202719)] = 8, -- Arcane Torrent
            [GetSpellInfo(202933)] = 8, -- Spider Sting
            [GetSpellInfo(1330)]   = 8, -- Garrote
            [GetSpellInfo(15487)]  = 8, -- Silence
            [GetSpellInfo(199683)] = 8, -- Last Word
            [GetSpellInfo(47476)]  = 8, -- Strangulate
            [GetSpellInfo(31935)]  = 8, -- Avenger's Shield
            [GetSpellInfo(204490)] = 8, -- Sigil of Silence

            -- Roots
            [GetSpellInfo(339)]    = 7, -- Entangling Roots
            [GetSpellInfo(122)]    = 7, -- Frost Nova
            [GetSpellInfo(102359)] = 7, -- Mass Entanglement
            [GetSpellInfo(64695)]  = 7, -- Earthgrab
            [GetSpellInfo(200108)] = 7, -- Ranger's Net
            [GetSpellInfo(212638)] = 7, -- Tracker's Net
            [GetSpellInfo(162480)] = 7, -- Steel Trap
            [GetSpellInfo(204085)] = 7, -- Deathchill
            [GetSpellInfo(233582)] = 7, -- Entrenched in Flame
            [GetSpellInfo(201158)] = 7, -- Super Sticky Tar
            [GetSpellInfo(33395)]  = 7, -- Freeze
            [GetSpellInfo(228600)] = 7, -- Glacial Spike
            [GetSpellInfo(116706)] = 7, -- Disable

            [GetSpellInfo(236077)] = 6, -- Disarm
            [GetSpellInfo(209749)] = 6, -- Faerie Swarm (Disarm)

            ]]
        },
    },
}
