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
        [GetSpellInfo(89421)] = true, -- Wrack
    },

    -- General debuffs
    debuffs = {
        [GetSpellInfo(115804)] = 3, -- Mortal Wounds
        [GetSpellInfo(51372)] = 1, -- Daze
        [GetSpellInfo(5246)] = 2, -- Intimidating Shout
        --[GetSpellInfo(6788)] = 16, -- Weakened Soul
    },

    -- General buffs
    buffs = {
        [GetSpellInfo(871)] = 17, -- Shield Wall
        [GetSpellInfo(61336)] = 17, -- Survival Instincts
        [GetSpellInfo(31850)] = 17, -- Ardent Defender
        [GetSpellInfo(498)] = 17, -- Divine Protection
        [GetSpellInfo(33206)] = 17, -- Pain Suppression
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
        },
    },
}
