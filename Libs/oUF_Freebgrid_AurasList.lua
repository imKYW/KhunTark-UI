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
    -- Legion Raids
    ['Tomb of Sargeras'] = 1147,
    ['The Nighthold'] = 1088,
    --['Trial of Valor'] = 1114,
    --['Emelard Nightmare'] = 1094,

    -- Draenor Raids
    ['Hellfire Citadel'] = 1026,
    ['Blackrock Foundry'] = 988,
    ['Highmaul'] = 994,

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
        --[[ temp remove
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
        [GetSpellInfo(211048)] = 5, -- [DH] Chaos Blades

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
        [GetSpellInfo(31842)]  = 4, -- Avenging Wrath (Holy)
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
        ]]
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

        [L['The Nighthold']] = {
            -- Skorpyron
            [GetSpellInfo(204766)] = 20, -- Energy Surge
            [GetSpellInfo(204744)] = 7, -- Toxic Chitin
            [GetSpellInfo(214718)] = 4, -- Acidic Fragments

            -- Chronomatic Anomaly
            [GetSpellInfo(206607)] = 20, -- Chronomatic Particles
            [GetSpellInfo(206617)] = 7, -- Time Bomb

            -- Trilliax
            [GetSpellInfo(206641)] = 20, -- Arcane Slash
            [GetSpellInfo(214573)] = 7, -- Stuffed
            [GetSpellInfo(206798)] = 6, -- Toxic Slice
            [GetSpellInfo(211615)] = 4, -- Sterilize
            [GetSpellInfo(208910)] = 3, -- Searing Bond
            [GetSpellInfo(206838)] = 3, -- Succulent Feast

            -- Spellblade Aluriel
            [GetSpellInfo(215458)] = 20, -- Annihilate
            [GetSpellInfo(212647)] = 7, -- Frostbitten
            [GetSpellInfo(212531)] = 5, -- Mark of Frost soon
            [GetSpellInfo(213148)] = 5, -- Searing Brand Mark soon
            [GetSpellInfo(212587)] = 4, -- Mark of Frost
            [GetSpellInfo(213166)] = 4, -- Searing Brand Mark
            [GetSpellInfo(230414)] = 3, -- Fel Stomp

            -- Krosus
            [GetSpellInfo(206677)] = 20, -- Searing Brand
            [GetSpellInfo(205344)] = 3, -- Orb of Destruciton

            -- Tichondrious
            [GetSpellInfo(208230)] = 20, -- Feast of Blood
            [GetSpellInfo(206480)] = 7, -- Carrion Plague
            [GetSpellInfo(216024)] = 6, -- Volatile Wound
            [GetSpellInfo(216040)] = 5, -- Burning Soul
            [GetSpellInfo(212794)] = 4, -- Brand of Argus
            [GetSpellInfo(206466)] = 3, -- Essence of Night

            -- High Botanist Tel'arn
            [GetSpellInfo(218503)] = 20, -- Recursive Strikes
            [GetSpellInfo(219235)] = 7, -- Toxic Spores
            [GetSpellInfo(218342)] = 4, -- Parasitic Fixate
            [GetSpellInfo(218809)] = 3, -- Call of Night

            -- Star Augur Etraeus
            [GetSpellInfo(205429)] = 20, -- Star Sign: Crab
            [GetSpellInfo(216344)] = 20, -- Star Sign: Dragon
            [GetSpellInfo(216345)] = 20, -- Star Sign: Hunter
            [GetSpellInfo(205445)] = 20, -- Star Sign: Wolf
            [GetSpellInfo(205984)] = 19, -- Gravitational Pull Frost
            [GetSpellInfo(214335)] = 19, -- Gravitational Pull Fel
            [GetSpellInfo(214167)] = 19, -- Gravitational Pull Void
            [GetSpellInfo(206398)] = 9, -- Felflame
            [GetSpellInfo(206965)] = 9, -- Voidburst
            [GetSpellInfo(206464)] = 7, -- Coronal Ejection
            [GetSpellInfo(206936)] = 7, -- Icy Ejection
            [GetSpellInfo(205649)] = 7, -- Fel Ejection

            -- Grand Magistrix Elisande
            [GetSpellInfo(209973)] = 20, -- Ablation Explosion
            [GetSpellInfo(211261)] = 9, -- Permeliative Torment
            [GetSpellInfo(209244)] = 7, -- Delphuric Beam
            [GetSpellInfo(209598)] = 4, -- Conflexive Burst
            
            -- Gul'dan
            [GetSpellInfo(221606)] = 20, -- Flames Of Sargeras
            [GetSpellInfo(209011)] = 19, -- Bonds of Fel
            [GetSpellInfo(206384)] = 19, -- Empowered Bonds of Fel
            [GetSpellInfo(209454)] = 18, -- Eye of Gul'dan
            [GetSpellInfo(221728)] = 18, -- Empowered Eye of Gul'dan
            [GetSpellInfo(208802)] = 9, -- Soul Corrosion
            [GetSpellInfo(210339)] = 7, -- Time Dilation
            [GetSpellInfo(206985)] = 7, -- Scattering Field
            [GetSpellInfo(210296)] = 7, -- Resonant Barrier
        },

        --[L['Trial of Valor']] = {
        --},

        --[L['Emelard Nightmare']] = {
        --},

        [L['Hellfire Citadel']] = {
            -- Hellfire Assault
            [GetSpellInfo(184243)] = 7, -- Slam
            [GetSpellInfo(185806)] = 7, -- Conducted Shock Pulse

            -- Iron Reaper
            [GetSpellInfo(182022)] = 7, -- Pounding
            [GetSpellInfo(182001)] = 7, -- Unstable Orb
            [GetSpellInfo(182074)] = 7, -- Immolation
            [GetSpellInfo(179897)] = 7, -- Blitz

            -- Kormork
            [GetSpellInfo(180244)] = 7, -- Pound
            [GetSpellInfo(181306)] = 7, -- Explosive Eruption
            [GetSpellInfo(181321)] = 7, -- Fel Touch
            [GetSpellInfo(187819)] = 7, -- Crush

            -- Hellfire High Council
            [GetSpellInfo(184450)] = 7, -- Mal of Necro
            [GetSpellInfo(184358)] = 7, -- Fel Rage
            [GetSpellInfo(184355)] = 7, -- Bloodboil
            [GetSpellInfo(184847)] = 7, -- Acidic Wound
            [GetSpellInfo(184357)] = 7, -- Tainted Blood
            [GetSpellInfo(184652)] = 7, -- Reap

            -- Kilrogg Deadeye
            [GetSpellInfo(180372)] = 7, -- Heart Seeker
            [GetSpellInfo(180224)] = 7, -- Death Throes
            [GetSpellInfo(182159)] = 7, -- Fel Corruption
            [GetSpellInfo(183917)] = 7, -- Verwundender Schrei
            [GetSpellInfo(180199)] = 7, -- Shredded Armor

            -- Gorefiend
            [GetSpellInfo(179864)] = 7, -- Shadow of Death
            [GetSpellInfo(179978)] = 7, -- Touch of Doom
            [GetSpellInfo(179909)] = 7, -- Shared Fate

            -- Shadow-Lord Iskar
            [GetSpellInfo(179202)] = 7, -- Eye of Anzu
            [GetSpellInfo(181956)] = 7, -- Phantasmal Winds
            [GetSpellInfo(182323)] = 7, -- Phantasmal Wounds
            [GetSpellInfo(179202)] = 7, -- Eye of Anzu
            [GetSpellInfo(182173)] = 7, -- Fel Chakram
            [GetSpellInfo(181753)] = 7, -- Fel Bomb
            [GetSpellInfo(179218)] = 7, -- Phantasmal Obliteration
            [GetSpellInfo(185239)] = 7, -- Radiance-of-anzu

            -- Fel Lord Zakuun
            [GetSpellInfo(181508)] = 7, -- Seed of destruction
            [GetSpellInfo(189260)] = 7, -- Cloven Soul
            [GetSpellInfo(179711)] = 7, -- Befouled
            [GetSpellInfo(182008)] = 7, -- Latent Energy
            [GetSpellInfo(179620)] = 7, -- Fel Crystal

            -- Xhul'horac
            [GetSpellInfo(186490)] = 7, -- Chains of Fel
            [GetSpellInfo(186333)] = 7, -- Void Surge
            [GetSpellInfo(186063)] = 7, -- Wasting Void
            [GetSpellInfo(186546)] = 7, -- Black Hole

            -- Socrethar the Eternal
            [GetSpellInfo(182038)] = 7, -- Shattered Defenses
            [GetSpellInfo(182635)] = 7, -- Reverberating Blow
            [GetSpellInfo(184239)] = 7, -- Shadow Word Agony
            [GetSpellInfo(136913)] = 7, -- Overwhelming Power

            -- Tyrant Velhari
            [GetSpellInfo(180166)] = 7, -- Touch of Harm
            [GetSpellInfo(180128)] = 7, -- Edict of Condemnation
            [GetSpellInfo(179999)] = 7, -- Seal of decay
            [GetSpellInfo(180300)] = 7, -- Infernal tempest
            [GetSpellInfo(180526)] = 7, -- Font of corruption

            -- Mannoroth
            [GetSpellInfo(181099)] = 7, -- Mark of Doom
            [GetSpellInfo(181597)] = 7, -- Mannoroth's Gaze
            [GetSpellInfo(181359)] = 7, -- Massive Blast
            [GetSpellInfo(184252)] = 7, -- Puncture Wound
            [GetSpellInfo(181116)] = 7, -- Doom Spike

            -- Archimonde
            [GetSpellInfo(189891)] = 7, -- Nether Tear
            [GetSpellInfo(185590)] = 7, -- Desecrate
            [GetSpellInfo(183864)] = 7, -- Shadow Blast
            [GetSpellInfo(183828)] = 7, -- Death Brand
            [GetSpellInfo(184931)] = 7, -- Shackled Torment
            [GetSpellInfo(182879)] = 7, -- Doomfire Fixate
        },

        [L['Blackrock Foundry']] = {
            -- Gruul
            [GetSpellInfo(155080)] = 7, -- Inferno Slice
            [GetSpellInfo(143962)] = 7, -- Inferno Strike
            [GetSpellInfo(155078)] = 7, -- Overwhelming Blows
            [GetSpellInfo(36240)]  = 7, -- Cave in
            [GetSpellInfo(165300)] = 7, -- Flare (Mythic)

            -- Oregorger
            [GetSpellInfo(156309)] = 7, -- Acid Torrent
            [GetSpellInfo(156203)] = 7, -- Retched Blackrock
            [GetSpellInfo(173471)] = 7, -- Acid Maw

            -- Beastlord Darmac
            [GetSpellInfo(155365)] = 7, -- Pinned Down
            [GetSpellInfo(155061)] = 7, -- Rend and Tear
            [GetSpellInfo(155030)] = 7, -- Seared Flesh
            [GetSpellInfo(155236)] = 7, -- Crush Armor
            [GetSpellInfo(159044)] = 7, -- Epicentre
            [GetSpellInfo(162276)] = 7, -- Unsteady (Mythic)
            [GetSpellInfo(155657)] = 7, -- Flame Infusion

            -- Flamebender Ka'graz
            [GetSpellInfo(155318)] = 7, -- Lava Slash
            [GetSpellInfo(155277)] = 7, -- Blazing Radiance
            [GetSpellInfo(154952)] = 7, -- Fixate
            [GetSpellInfo(155074)] = 7, -- Charring Breath
            [GetSpellInfo(163284)] = 7, -- Rising Flame
            [GetSpellInfo(162293)] = 7, -- Empowered Armament

            -- Hans'gar and Franzok
            [GetSpellInfo(157139)] = 7, -- Shattered Vertebrae
            [GetSpellInfo(161570)] = 7, -- Searing Plates
            [GetSpellInfo(157853)] = 7, -- Aftershock

            -- Operator Thogar
            [GetSpellInfo(155921)] = 7, -- Enkindle
            [GetSpellInfo(165195)] = 7, -- Prototype Pulse Grenade
            [GetSpellInfo(155701)] = 7, -- Serrated Slash
            [GetSpellInfo(156310)] = 7, -- Lava Shock
            [GetSpellInfo(164380)] = 7, -- Burning

            -- The Blast Furnace
            [GetSpellInfo(155240)] = 7, -- Tempered
            [GetSpellInfo(155242)] = 7, -- Heat
            [GetSpellInfo(176133)] = 7, -- Bomb
            [GetSpellInfo(156934)] = 7, -- Rupture
            [GetSpellInfo(175104)] = 7, -- Melt Armor
            [GetSpellInfo(176121)] = 7, -- Volatile Fire
            [GetSpellInfo(158702)] = 7, -- Fixate
            [GetSpellInfo(155225)] = 7, -- Melt

            -- Kromog
            [GetSpellInfo(157060)] = 7, -- Rune of Grasping Earth
            [GetSpellInfo(156766)] = 7, -- Warped Armor
            [GetSpellInfo(161839)] = 7, -- Rune of Crushing Earth

            -- The Iron Maidens
            [GetSpellInfo(164271)] = 7, -- Penetrating Shot
            [GetSpellInfo(158315)] = 7, -- Dark Hunt
            [GetSpellInfo(156601)] = 7, -- Sanguine Strikes
            [GetSpellInfo(170395)] = 7, -- Sorka's Prey
            [GetSpellInfo(170405)] = 7, -- Marak's Blood Calling
            [GetSpellInfo(158692)] = 7, -- Deadly Throw
            [GetSpellInfo(158702)] = 7, -- Fixate
            [GetSpellInfo(158686)] = 7, -- Expose Armor
            [GetSpellInfo(158683)] = 7, -- Corrupted Blood

            -- Blackhand
            [GetSpellInfo(156096)] = 7, -- Marked For Death
            [GetSpellInfo(156107)] = 7, -- Impaled
            [GetSpellInfo(156047)] = 7, -- Slagged
            [GetSpellInfo(156401)] = 7, -- Molten Slag
            [GetSpellInfo(156404)] = 7, -- Burned
            [GetSpellInfo(158054)] = 7, -- Shattering Smash 158054 155992 159142
            [GetSpellInfo(156888)] = 7, -- Overheated
            [GetSpellInfo(157000)] = 7, -- Attach Slag Bombs
        },

        [L['Highmaul']] = {
            -- Kargath Bladefist
            [GetSpellInfo(159113)] = 5, -- Impale
            [GetSpellInfo(159178)] = 6, -- Open Wounds
            [GetSpellInfo(159213)] = 7, -- Monsters Brawl
            [GetSpellInfo(159410)] = 7, -- Mauling Brew
            [GetSpellInfo(160521)] = 7, -- Vile Breath
            [GetSpellInfo(159386)] = 7, -- Iron Bomb
            [GetSpellInfo(159188)] = 7, -- Grapple
            [GetSpellInfo(162497)] = 7, -- On The Hunt
            [GetSpellInfo(159202)] = 7, -- Flame Jet

            -- The Butcher
            [GetSpellInfo(156152)] = 7, -- Gushing Wounds
            [GetSpellInfo(156151)] = 7, -- The Tenderizer
            [GetSpellInfo(156143)] = 7, -- The Cleaver
            [GetSpellInfo(163046)] = 7, -- Pale Vitriol

            -- Tectus
            [GetSpellInfo(162892)] = 7, -- Infesting Spores

            -- Brackenspore
            [GetSpellInfo(163242)] = 7, -- Infesting Spores
            [GetSpellInfo(163590)] = 7, -- Creeping Moss
            [GetSpellInfo(163241)] = 7, -- Rot
            [GetSpellInfo(159220)] = 7, -- Necrotic Breath
            [GetSpellInfo(160179)] = 7, -- Mind Fungus
            [GetSpellInfo(159972)] = 7, -- Flesh Eater

            -- Twin Ogron
            [GetSpellInfo(158026)] = 7, -- Enfeebling Roar
            [GetSpellInfo(158241)] = 5, -- Blaze
            [GetSpellInfo(155569)] = 7, -- Injured
            [GetSpellInfo(167200)] = 7, -- Arcane Wound
            [GetSpellInfo(159709)] = 7, -- Weakened Defenses 159709 167179
            [GetSpellInfo(163374)] = 7, -- Arcane Volatility

            -- Ko'ragh
            [GetSpellInfo(161242)] = 7, -- Caustic Energy
            [GetSpellInfo(161358)] = 7, -- Suppression Field
            [GetSpellInfo(162184)] = 7, -- Expel Magic: Shadow
            [GetSpellInfo(162186)] = 7, -- Expel Magic: Arcane
            [GetSpellInfo(161411)] = 7, -- Expel Magic: Frost
            [GetSpellInfo(163472)] = 7, -- Dominating Power
            [GetSpellInfo(162185)] = 7, -- Expel Magic: Fel

            -- Imperator Mar'gok
            [GetSpellInfo(156238)] = 7, -- Branded 156238 163990 163989 163988
            [GetSpellInfo(156467)] = 7, -- Destructive Resonance 156467 164075 164076 164077
            [GetSpellInfo(157349)] = 7, -- Force Nova 157349 164232 164235 164240
            [GetSpellInfo(158605)] = 7, -- Mark of Chaos 158605 164176 164178 164191
            [GetSpellInfo(157763)] = 7, -- Fixate
            [GetSpellInfo(158553)] = 7, -- Crush Armor

            -- Trash
            [GetSpellInfo(175601)] = 7, -- Trash: Tainted Claws
            [GetSpellInfo(172069)] = 7, -- Trash: Radiating Poison
            [GetSpellInfo(56037)]  = 7, -- Trash: Rune of Destruction
            [GetSpellInfo(175654)] = 7, -- Trash: Rune of Disintegration
        },

        [L['PVP']] = {


        --[[ temp remove
            -- Higher up = higher display priority
            --1 무적기
            --2 부분무적기
            --3 하드메즈기
            --4 매즈기
            --5 슬로우

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
