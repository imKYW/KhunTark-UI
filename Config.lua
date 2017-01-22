local _, ns = ...
local cfg = CreateFrame('Frame')

-- Media ------------------------------------------------------------------------------------------
-- Texture
cfg.texture = 'Interface\\AddOns\\KBJcombatUI\\Media\\texture'
cfg.symbol = 'Interface\\AddOns\\KBJcombatUI\\Media\\symbol.ttf'
cfg.glow = 'Interface\\AddOns\\KBJcombatUI\\Media\\textureGlow'

-- Font ( fontStd is FRIZQT__ + koverwatch )
cfg.font = 'Interface\\AddOns\\KBJcombatUI\\Media\\fontStd.ttf'
cfg.bfont = 'Interface\\AddOns\\KBJcombatUI\\Media\\fontThick.ttf'
cfg.aurafont = 'Interface\\AddOns\\KBJcombatUI\\Media\\pixel.ttf'
cfg.shadowoffsetX, cfg.shadowoffsetY, cfg.fontflag = 0, 0, 'THINOUTLINE'

-- Unit Frames --------------------------------------------------------------------------
-- Main Group (player, target, focus, pet, targettarget, focustarget)
cfg.mainUF = {  -- Anchor is Player unitframe
	player = {
		width = 100,
		height = 20,
		position = { sa = 'TOP', a = UIParent, pa = 'CENTER', x = 0, y = -100 },
	},
	focus = {
		width = 40,
		height = 10,
		position = { sa = 'CENTER', a = UIParent, pa = 'CENTER', x = 130, y = 78 },
	},
}

-- Sub Group (party, raid, boss, tank, arena, partytarget, tanktarget, arenatarget)
cfg.subUF = {
	party = {
		width = 80,
		height = 25,
		position = { sa = 'BOTTOMRIGHT', a = UIParent, pa = 'CENTER', x = -270, y = -70 },
	},
	raid = {
		width = 44,
		height = 44,
		position = { sa = 'TOPLEFT', a = UIParent, pa = 'TOPLEFT', x = 15, y = -100 },
	},
	boss = { -- arena
		width = 80,
		height = 25,
		position = { sa = 'BOTTOMLEFT', a = UIParent, pa = 'CENTER', x = 270, y = -70 },
	},
	tank = {
		width = 95,
		height = 34,
		position = { sa = '', a = UIParent, pa = '', x = 80, y = 0 },
	},
}

-- Castbars -----------------------------------------------------------------------------
cfg.castbar = {
	player = {
		width = 100,
		height = 14,
		position = { sa = 'CENTER', a = UIParent, pa = 'CENTER', x = 0, y = -80 },
	},
	target = {
		width = 140,
		height = 18,
		position = { sa = 'CENTER', a = UIParent, pa = 'CENTER', x = 0, y = 100 },
	},
	focus = {
		width = 120,
		height = 13,
		position = { sa = 'CENTER', a = UIParent, pa = 'CENTER', x = 10, y = 78 },
	},
	arena = {
		width = 100,
		height = 14,
		position = { sa = 'CENTER', a = UIParent, pa = 'CENTER', x = -120, y = -100 },
	},
}

-----------------------------
-- Unit Frames Options
-----------------------------
cfg.options = {
	disableRaidFrameManager = true,	-- disable default compact Raid Manager 
	ResurrectIcon = true,
	--TotemBar = false,
	--MushroomBar = true,
}

-----------------------------
-- Auras 
-----------------------------
cfg.aura = {
	-- player
	player_debuffs = true,
	player_debuffs_num = 18,
	-- target
	target_debuffs = true,
	target_debuffs_num = 18,
	target_buffs = true,
	target_buffs_num = 8,		
	-- focus
	focus_debuffs = true,
	focus_debuffs_num = 12,
	focus_buffs = false,
	focus_buffs_num = 8,
	-- boss
	boss_buffs = true,
	boss_buffs_num = 4,
	boss_debuffs = true,
	boss_debuffs_num = 4,
	-- target of target
	targettarget_debuffs = true,
	targettarget_debuffs_num = 4,
	-- party
	party_buffs = true,
	party_buffs_num = 4,
	
	onlyShowPlayer = false,         -- only show player debuffs on target
	disableCooldown = true,         -- hide omniCC
	font = 'Interface\\AddOns\\KBJcombatUI\\Media\\pixel.ttf',
	fontsize = 8,
	fontflag = 'Outlinemonochrome',
}

-----------------------------
-- Plugins 
-----------------------------

--ThreatBar
cfg.treat = {
	enable = true,
	text = false,
	pos = {'CENTER', UIParent, 0, 39},
	width = 40,
	height = 4,
}

--RaidDebuffs
cfg.RaidDebuffs = {
	enable = true,
	pos = {'CENTER'},
	size = 20,
	ShowDispelableDebuff = true,
	FilterDispellableDebuff = true,
	MatchBySpellName = false,
}

--Threat/DebuffHighlight
cfg.dh = {
	player = true,
	target = true,
	focus = true,
	pet = true,
	partytaget = false,
	party = true,
	arena = true,
	raid = true,
	targettarget = false,
}

--AuraWatch
cfg.aw = {
	enable = true,
	onlyShowPresent = true,
	anyUnit = true,
}

--AuraWatch Spells
cfg.spellIDs = {
	  DRUID = {
	          {33763, {0.2, 0.8, 0.2}},			    -- Lifebloom
	          {8936, {0.8, 0.4, 0}, 'TOPLEFT'},		-- Regrowth
	          {102342, {0.38, 0.22, 0.1}},		    -- Ironbark
	          {48438, {0.4, 0.8, 0.2}, 'BOTTOMLEFT'},	-- Wild Growth
	          {774, {0.8, 0.4, 0.8},'TOPRIGHT'},		-- Rejuvenation
	          },
	   MONK = {
	          {119611, {0.2, 0.7, 0.7}},			    -- Renewing Mist
	          {132120, {0.4, 0.8, 0.2}},			    -- Enveloping Mist
	          {124081, {0.7, 0.4, 0}},			    -- Zen Sphere
	          {116849, {0.81, 0.85, 0.1}},		    -- Life Cocoon
	          },
	PALADIN = {
	          {20925, {0.9, 0.9, 0.1}},	            -- Sacred Shield
	          {6940, {0.89, 0.1, 0.1}, 'BOTTOMLEFT'}, -- Hand of Sacrifice
	          {114039, {0.4, 0.6, 0.8}, 'BOTTOMLEFT'},-- Hand of Purity
	          {1022, {0.2, 0.2, 1}, 'BOTTOMLEFT'},	-- Hand of Protection
	          {1038, {0.93, 0.75, 0}, 'BOTTOMLEFT'},  -- Hand of Salvation
	          {1044, {0.89, 0.45, 0}, 'BOTTOMLEFT'},  -- Hand of Freedom
	          {114163, {0.9, 0.6, 0.4}, 'RIGHT'},	    -- Eternal Flame
	          {53563, {0.7, 0.3, 0.7}, 'TOPRIGHT'},   -- Beacon of Light
	          },
	 PRIEST = {
	          {41635, {0.2, 0.7, 0.2}},			    -- Prayer of Mending
	          {33206, {0.89, 0.1, 0.1}},			    -- Pain Suppress
	          {47788, {0.86, 0.52, 0}},			    -- Guardian Spirit
	          {6788, {1, 0, 0}, 'BOTTOMLEFT'},	    -- Weakened Soul
	          {17, {0.81, 0.85, 0.1}, 'TOPLEFT'},	    -- Power Word: Shield
	          {139, {0.4, 0.7, 0.2}, 'TOPRIGHT'},     -- Renew
	          },
	 SHAMAN = {
	          {974, {0.2, 0.7, 0.2}},				    -- Earth Shield
	          {61295, {0.7, 0.3, 0.7}, 'TOPRIGHT'},   -- Riptide
	          },
	 HUNTER = {
	          {35079, {0.2, 0.2, 1}},				    -- Misdirection
	          },
	   MAGE = {
	          {111264, {0.2, 0.2, 1}},			    -- Ice Ward
	          },
	  ROGUE = {
	          {57933, {0.89, 0.1, 0.1}},			    -- Tricks of the Trade
	          },
	WARLOCK = {
	          {20707, {0.7, 0.32, 0.75}},			    -- Soulstone
	          },
	WARRIOR = {
	          {114030, {0.2, 0.2, 1}},			    -- Vigilance
	          {3411, {0.89, 0.1, 0.1}, 'TOPRIGHT'},   -- Intervene
	          },
 }
 
-----------------------------
-- Castbars 
-----------------------------



ns.cfg = cfg