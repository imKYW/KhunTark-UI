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

        local htext = cFontString(self.Health, 'OVERLAY', cfg.bfont, 16, cfg.fontflag, 1, 1, 1, 'LEFT')
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

	    local name = cFontString(self.Health, 'OVERLAY', cfg.font, 11, cfg.fontflag, 1, 1, 1, 'LEFT')
        name:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT', 4, 0)        
		self:Tag(name, '[color][name] [unit:lv]')
		
        local htext = cFontString(self.Health, 'OVERLAY', cfg.bfont, 31, cfg.fontflag, 1, 1, 1, 'LEFT')
        htext:SetPoint('LEFT', self.Health, 'LEFT', 1, 0)
        self:Tag(htext, '[unit:HPpercent]')

        local htextsub = cFontString(self.Health, 'OVERLAY', cfg.bfont, cfg.fontsize, cfg.fontflag, 1, 1, 1, 'RIGHT')
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

		local name = cFontString(self.Health, 'OVERLAY', cfg.font, 11, cfg.fontflag, 1, 1, 1, 'LEFT')
        name:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 3)
		self:Tag(name, '[color][unit:name5]')

        local htext = cFontString(self.Health, 'OVERLAY', cfg.bfont, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
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

		local name = cFontString(self.Health, 'OVERLAY', cfg.font, 11, cfg.fontflag, 1, 1, 1, 'LEFT')
        name:SetPoint('LEFT', self.Health, 'RIGHT', 4, 1)
		self:Tag(name, '[color][name]')

        local htext = cFontString(self.Health, 'OVERLAY', cfg.bfont, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
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

		local name = cFontString(self.Health, 'OVERLAY', cfg.font, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
        name:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 1, 3)
		self:Tag(name, '[color][unit:name5]')

        local htext = cFontString(self.Health, 'OVERLAY', cfg.bfont, 11, cfg.fontflag, 1, 1, 1, 'LEFT')
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

	    local name = cFontString(self.Health, 'OVERLAY', cfg.font, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
        name:SetPoint('TOPRIGHT', self.Health, 'TOPLEFT', -1, 2)        
		self:Tag(name, '[color][name]')
		
        local htext = cFontString(self.Health, 'OVERLAY', cfg.bfont, 20, cfg.fontflag, 1, 1, 1, 'RIGHT')
        htext:SetPoint('RIGHT', self.Health, 'RIGHT', 0, 0)
        self:Tag(htext, '[unit:HPmix]')

		self.Leader = self.Health:CreateTexture(nil, "OVERLAY")
		self.Leader:SetSize(11, 11)
		self.Leader:SetPoint("CENTER", self, "TOPLEFT", 4, 5)
		self.Assistant = self.Health:CreateTexture(nil, "OVERLAY")
		self.Assistant:SetSize(11, 11)
		self.Assistant:SetPoint("CENTER", self, "TOPLEFT", 4, 5)
        local RaidI = self.Health:CreateTexture(nil, "OVERLAY")
		RaidI:SetSize(18, 18)
		RaidI:SetAlpha(0.9)
		RaidI:SetPoint("LEFT", self.Health, "LEFT", 1, 0)
		self.RaidIcon = RaidI
		self.LFDRole = self.Health:CreateTexture(nil, "OVERLAY")
		self.LFDRole:SetSize(10, 10)
		self.LFDRole:SetPoint("CENTER", self, "TOPRIGHT", -6, -6)
		self.ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheck:SetSize(32, 32)
		self.ReadyCheck:SetPoint("CENTER", self, "CENTER", 0, 0)
    end,

    partytarget = function(self, ...)
		Shared(self, ...)
		self.unit = 'partytarget'

		self:SetSize(cfg.subUF.party.width/2, cfg.subUF.party.height/2)
		self.Health:SetHeight(cfg.subUF.party.height/2)
		self.Health:SetReverseFill(true)

		local htext = cFontString(self.Health, 'OVERLAY', cfg.bfont, 10, cfg.fontflag, 1, 1, 1, 'RIGHT')
		htext:SetPoint('RIGHT', self.Health, 'RIGHT', 1, 0)
		self:Tag(htext, '[unit:HPpercent]')

		local RaidI = self.Health:CreateTexture(nil, "OVERLAY")
		RaidI:SetSize(10, 10)
		RaidI:SetAlpha(0.9)
		RaidI:SetPoint("LEFT", self.Health, "LEFT", 1, 0)
		self.RaidIcon = RaidI
    end,
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
	spawnHelper(self, 'target', 'LEFT', cfg.mainUF.position.a, 'CENTER', cfg.mainUF.position.x, cfg.mainUF.position.y)
    spawnHelper(self, 'player', 'BOTTOMLEFT', 'oUF_CombaUITarget', 'TOPLEFT', 0, 5)    
    spawnHelper(self, 'targettarget', 'BOTTOMRIGHT', 'oUF_CombaUITarget', 'TOPRIGHT', 0, 5)
    spawnHelper(self, 'focus', 'BOTTOM', 'oUF_CombaUITargetTarget', 'TOP', 0, 25)
    spawnHelper(self, 'focustarget', 'LEFT', 'oUF_CombaUIFocus','RIGHT', 5, 0)
    spawnHelper(self, 'pet', 'BOTTOM', 'oUF_CombaUIPlayer', 'TOP', 0, 3)

	self:SetActiveStyle('CombaUI - Party')
	local party = self:SpawnHeader('oUF_Party', nil, 'solo, party, raid',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'yOffset', -12,
		'oUF-initialConfigFunction', ([[
		self:SetHeight(%d)
		self:SetWidth(%d)
		]]):format(cfg.subUF.party.height, cfg.subUF.party.width)
	)
	party:SetPoint('TOPRIGHT', cfg.subUF.party.position.a, 'CENTER', cfg.subUF.party.position.x, cfg.subUF.party.position.y)

	self:SetActiveStyle'CombaUI - Pet'
	local pets = self:SpawnHeader('oUF_PartyPets', nil, 'solo, party, raid',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'yOffset', -12,
		'oUF-initialConfigFunction', ([[
			self:SetAttribute('unitsuffix', 'pet')
		]])
	)
	pets:SetPoint("BOTTOMRIGHT", 'oUF_Party', "TOPRIGHT", 0, 3)

	self:SetActiveStyle('CombaUI - Partytarget')
	local partytargets = self:SpawnHeader('oUF_PartyTargets', nil, 'solo, party, raid',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'yOffset', -12,
		'oUF-initialConfigFunction', ([[
		self:SetAttribute('unitsuffix', 'target')
		self:SetHeight(%d)
		self:SetWidth(%d)
		]]):format(cfg.subUF.party.height/2, cfg.subUF.party.width/2)
	)
	partytargets:SetPoint('BOTTOMRIGHT', 'oUF_Party', 'BOTTOMLEFT', -5, 0)
end)