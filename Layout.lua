local name, ns = ...
local cfg = ns.cfg
local oUF = ns.oUF or oUF

local Shared = function(self, unit)
	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', OnEnterHL)
	self:SetScript('OnLeave', OnLeaveHL)

	fBackDrop(self, self)	
	Health(self)

	self.Range = { insideAlpha = 1, outsideAlpha = 0.4 }
end

local UnitSpecific = {
    player = function(self, ...)
		Shared(self, ...)
		self.unit = 'player'
		
		self:SetSize((cfg.mainUF.width-5)/2, cfg.mainUF.height/2)	
		self.Health:SetHeight(cfg.mainUF.height / 2)

        local htext = cFontString(self.Health, nil, cfg.bfont, 16, cfg.fontflag, 1, 1, 1, 'LEFT')
        htext:SetPoint('LEFT', self.Health, 'LEFT', 1, 0)        
        self:Tag(htext, '[unit:HPpercent]')

        local combatI = self.Health:CreateTexture(nil, 'OVERLAY')
		combatI:SetSize(18, 18)
		combatI:SetPoint('CENTER', self.Health, 'RIGHT', -8, 0)
		self.Combat = combatI
		local RestI = self:CreateTexture(nil, 'OVERLAY')
		RestI:SetSize(18, 18)
		RestI:SetPoint('BOTTOMRIGHT', self, 'TOPLEFT', 3, 0)
		self.Resting = RestI
	end,

    target = function(self, ...)
		Shared(self, ...)
		Power(self)		
		self.unit = 'target'		
		
		self:SetSize(cfg.mainUF.width, cfg.mainUF.height)
		self.Health:SetHeight(cfg.mainUF.height-3)
	    self.Power:SetHeight(2)

	    local name = cFontString(self.Health, nil, cfg.font, 11, cfg.fontflag, 1, 1, 1, 'LEFT')
        name:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT', 4, 0)        
		self:Tag(name, '[color][name] [unit:lv]')
		
        local htext = cFontString(self.Health, nil, cfg.bfont, 31, cfg.fontflag, 1, 1, 1, 'LEFT')
        htext:SetPoint('LEFT', self.Health, 'LEFT', 1, 0)
        self:Tag(htext, '[unit:HPpercent]')

        local htextsub = cFontString(self.Health, nil, cfg.bfont, 10, cfg.fontflag, 1, 1, 1, 'RIGHT')
        htextsub:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', 1, 1)
        self:Tag(htextsub, '[unit:HPcurrent]')

        local RaidI = self.Health:CreateTexture(nil, "OVERLAY")
		RaidI:SetSize(24, 24)
		RaidI:SetAlpha(0.9)
		RaidI:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
		self.RaidIcon = RaidI
    end,

    focus = function(self, ...)
    	Shared(self, ...)
		self.unit = 'focus'		

		self:SetSize((cfg.mainUF.width-5)/2, cfg.mainUF.height/2)	
		self.Health:SetHeight(cfg.mainUF.height / 2)
		self.Health:SetReverseFill(true)

		local name = cFontString(self.Health, nil, cfg.font, 11, cfg.fontflag, 1, 1, 1, 'LEFT')
        name:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 3)
		self:Tag(name, '[color][unit:name5]')

        local htext = cFontString(self.Health, nil, cfg.bfont, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
        htext:SetPoint('RIGHT', self.Health, 'RIGHT', 1, 1)        
        self:Tag(htext, '[unit:HPpercent]')

		local RaidI = self.Health:CreateTexture(nil, "OVERLAY")
		RaidI:SetSize(14, 14)
		RaidI:SetAlpha(0.9)
		RaidI:SetPoint("LEFT", self.Health, "LEFT", 1, 0)
		self.RaidIcon = RaidI

    end,

    pet = function(self, ...)
    	Shared(self, ...)
    	self.unit = 'pet'
		self:SetSize((cfg.mainUF.width-5)/2, 3)

		self.Health.colorClass = false
    	self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true
    end,

	targettarget = function(self, ...)
		Shared(self, ...)
		self.unit = 'targettarget'

		self:SetSize((cfg.mainUF.width-5)/2, cfg.mainUF.height/2)
		self.Health:SetHeight(cfg.mainUF.height / 2)
		self.Health:SetReverseFill(true)

		local name = cFontString(self.Health, nil, cfg.font, 11, cfg.fontflag, 1, 1, 1, 'LEFT')
        name:SetPoint('LEFT', self.Health, 'RIGHT', 4, 1)
		self:Tag(name, '[color][name]')

        local htext = cFontString(self.Health, nil, cfg.bfont, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
        htext:SetPoint('RIGHT', self.Health, 'RIGHT', 1, 1)
        self:Tag(htext, '[unit:HPpercent]')

		local RaidI = self.Health:CreateTexture(nil, "OVERLAY")
		RaidI:SetSize(14, 14)
		RaidI:SetAlpha(0.9)
		RaidI:SetPoint("LEFT", self.Health, "LEFT", 1, 0)
		self.RaidIcon = RaidI
    end,

    focustarget = function(self, ...)
		Shared(self, ...)
		self.unit = 'focustarget'

		self:SetSize((cfg.mainUF.width-5)/2, cfg.mainUF.height/2)
		self.Health:SetHeight(cfg.mainUF.height / 2)

		local name = cFontString(self.Health, nil, cfg.font, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
        name:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 1, 3)
		self:Tag(name, '[color][unit:name5]')

        local htext = cFontString(self.Health, nil, cfg.bfont, 11, cfg.fontflag, 1, 1, 1, 'LEFT')
        htext:SetPoint('LEFT', self.Health, 'LEFT', 1, 1)
        self:Tag(htext, '[unit:HPpercent]')

		local RaidI = self.Health:CreateTexture(nil, "OVERLAY")
		RaidI:SetSize(14, 14)
		RaidI:SetAlpha(0.9)
		RaidI:SetPoint("RIGHT", self.Health, "RIGHT", -1, 0)
		self.RaidIcon = RaidI
    end,

	party = function(self, ...)
		Shared(self, ...)
		Power(self)		
		self.unit = 'party'		
		
		self:SetSize(cfg.subUF.party.width, cfg.subUF.party.height)
		self.Health:SetHeight(cfg.subUF.party.height-3)
		self.Health:SetReverseFill(true)
	    self.Power:SetHeight(2)

	    local name = cFontString(self.Health, nil, cfg.font, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
        name:SetPoint('TOPRIGHT', self.Health, 'TOPLEFT', -1, 2)        
		self:Tag(name, '[color][name]')
		
        local htext = cFontString(self.Health, nil, cfg.bfont, 20, cfg.fontflag, 1, 1, 1, 'RIGHT')
        htext:SetPoint('RIGHT', self.Health, 'RIGHT', 0, 0)
        self:Tag(htext, '[unit:HPmix]')

		self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
		self.Leader:SetSize(11, 11)
		self.Leader:SetPoint("CENTER", self, "TOPLEFT", 4, 5)
		self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
		self.Assistant:SetSize(11, 11)
		self.Assistant:SetPoint("CENTER", self, "TOPLEFT", 4, 5)
        self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetSize(18, 18)
		self.RaidIcon:SetAlpha(0.9)
		self.RaidIcon:SetPoint("LEFT", self.Health, "LEFT", 1, 0)
		self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
		self.LFDRole:SetSize(10, 10)
		self.LFDRole:SetPoint("CENTER", self.Health, "TOPLEFT", 6, -6)
		self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheck:SetSize(22, 22)
		self.ReadyCheck:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
    end,

    partytarget = function(self, ...)
		Shared(self, ...)
		self.unit = 'partytarget'

		self:SetSize(cfg.subUF.party.width/2, cfg.subUF.party.height/2)
		self.Health:SetHeight(cfg.subUF.party.height/2)
		self.Health:SetReverseFill(true)

		local htext = cFontString(self.Health, nil, cfg.bfont, 10, cfg.fontflag, 1, 1, 1, 'RIGHT')
		htext:SetPoint('RIGHT', self.Health, 'RIGHT', 1, 0)
		self:Tag(htext, '[unit:HPpercent]')

		self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetSize(10, 10)
		self.RaidIcon:SetAlpha(0.9)
		self.RaidIcon:SetPoint("LEFT", self.Health, "LEFT", 1, 0)
    end,

    raid = function(self, ...)
		Shared(self, ...)

		self.unit = 'raid'
		self:SetAttribute("type2", "focus")
		
		Power(self)

		self:SetSize(cfg.subUF.raid.width, cfg.subUF.raid.height)	
		self.Health:SetHeight(cfg.subUF.raid.height-3)
		self.Health:SetOrientation("VERTICAL")
		self.Power:SetHeight(2)
		
		local name = cFontString(self.Health, "OVERLAY", cfg.bfont, 10, 'none', 1, 1, 1)
		name:SetPoint('TOPLEFT', 1, 0)		
		name:SetShadowOffset(1, -1)
	    name:SetJustifyH('LEFT')
		self:Tag(name, '[unit:name4]')
        local htext = cFontString(self.Health, "OVERLAY", cfg.bfont, 10, cfg.fontflag, 1, 1, 1)
        htext:SetPoint('BOTTOMRIGHT', 2, 0)
		htext:SetJustifyH('RIGHT')
        self:Tag(htext, '[unit:HPpercent]')

        self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
		self.Leader:SetSize(11, 11)
		self.Leader:SetPoint("CENTER", self, "TOPLEFT", 4, 5)
		self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
		self.Assistant:SetSize(11, 11)
		self.Assistant:SetPoint("CENTER", self, "TOPLEFT", 4, 5)
		self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetSize(16, 16)
		self.RaidIcon:SetPoint("CENTER", self, "LEFT", 0, 0)
		self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
		self.LFDRole:SetSize(10, 10)
		self.LFDRole:SetPoint("CENTER", self, "TOPRIGHT", -6, -6)
		self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheck:SetSize(32, 32)
		self.ReadyCheck:SetPoint("CENTER", self, "CENTER", 0, 0)
    end
}

oUF:RegisterStyle('CombaUI', Shared)
for unit,layout in next, UnitSpecific do
    oUF:RegisterStyle('CombaUI - ' .. unit:gsub('^%l', string.upper), layout)
end

local spawnHelper = function(self, unit, ...)
    if(UnitSpecific[unit]) then
        self:SetActiveStyle('CombaUI - ' .. unit:gsub('^%l', string.upper))
    elseif(UnitSpecific[unit:match('[^%d]+')]) then 
        self:SetActiveStyle('CombaUI - ' .. unit:match('[^%d]+'):gsub('^%l', string.upper))
    else
        self:SetActiveStyle('CombaUI')
    end
    local object = self:Spawn(unit)
    object:SetPoint(...)
    return object
end

oUF:Factory(function(self)
	spawnHelper(self, 'target', cfg.mainUF.position.sa, cfg.mainUF.position.a, cfg.mainUF.position.pa, cfg.mainUF.position.x, cfg.mainUF.position.y)
    spawnHelper(self, 'player', 'BOTTOMLEFT', 'oUF_CombaUITarget', 'TOPLEFT', 0, 5)    
    spawnHelper(self, 'targettarget', 'BOTTOMRIGHT', 'oUF_CombaUITarget', 'TOPRIGHT', 0, 5)
    spawnHelper(self, 'focus', 'BOTTOM', 'oUF_CombaUITargetTarget', 'TOP', 0, 25)
    spawnHelper(self, 'focustarget', 'LEFT', 'oUF_CombaUIFocus','RIGHT', 5, 0)
    spawnHelper(self, 'pet', 'BOTTOM', 'oUF_CombaUIPlayer', 'TOP', 0, 3)

	self:SetActiveStyle('CombaUI - Party')
	self:SpawnHeader('oUF_Party', nil, 'custom show',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'yOffset', -15,
		'oUF-initialConfigFunction', ([[
			self:SetHeight(%d)
			self:SetWidth(%d)
		]]):format(cfg.subUF.party.height, cfg.subUF.party.width)
	):SetPoint(cfg.subUF.party.position.sa, cfg.subUF.party.position.a, cfg.subUF.party.position.pa, cfg.subUF.party.position.x, cfg.subUF.party.position.y)

	self:SetActiveStyle'CombaUI - Pet'
	self:SpawnHeader('oUF_PartyPets', nil, 'custom show',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'yOffset', -38,
		'oUF-initialConfigFunction', ([[
			self:SetAttribute('unitsuffix', 'pet')
		]])
	):SetPoint("TOPRIGHT", 'oUF_Party', "TOPRIGHT", 0, 6)

	self:SetActiveStyle('CombaUI - Partytarget')
	self:SpawnHeader('oUF_PartyTargets', nil, 'custom show',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'yOffset', -15-cfg.subUF.party.height/2,
		'oUF-initialConfigFunction', ([[
		self:SetAttribute('unitsuffix', 'target')
		]])
	):SetPoint('TOPRIGHT', 'oUF_Party', 'TOPLEFT', -5, -cfg.subUF.party.height/2)

	self:SetActiveStyle'CombaUI - Raid'
	self:SpawnHeader('oUF_Raid', nil, 'custom show',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'xoffset', 5,
		'yOffset', -12,
		'point', 'TOP',
		'groupFilter', '1,2,3,4,5,6,7,8',
		'groupingOrder', '1,2,3,4,5,6,7,8',
		'groupBy', 'GROUP',
		'maxColumns', 8,
		'unitsPerColumn', 5,
		'columnSpacing', 5,
		'columnAnchorPoint', 'LEFT',
		'oUF-initialConfigFunction', ([[
			self:SetHeight(%d)
			self:SetWidth(%d)
		]]):format(cfg.subUF.raid.height, cfg.subUF.raid.width)
	):SetPoint(cfg.subUF.raid.position.sa, cfg.subUF.raid.position.a, cfg.subUF.raid.position.pa, cfg.subUF.raid.position.x, cfg.subUF.raid.position.y)
end)