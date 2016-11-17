local name, ns = ...
local cfg = ns.cfg
local oUF = ns.oUF or oUF
local class = select(2, UnitClass('player'))

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
		self:RegisterForClicks('AnyUp')
		self.unit = 'player'

		fBackDrop(self, self)
		Power(self)
		extCastbar(self)

		self:SetSize(cfg.mainUF.width, cfg.mainUF.height)	
		self.Power:SetHeight(cfg.mainUF.height)		

		local htext = cFontString(self.Power, nil, cfg.bfont, 18, cfg.fontflag, 1, 1, 1, 'RIGHT')
		htext:SetPoint('BOTTOMRIGHT', 'oUF_CombaUITarget', 'TOPLEFT', -6, 2)
		self:Tag(htext, '[unit:HPpercent]')

		-- Class Bar
		local ptext = cFontString(self.Power, nil, cfg.bfont, 10, cfg.fontflag, 1, 1, 1, 'CENTER')
		ptext:SetPoint('CENTER', self.Power, 'CENTER', 1, 1)        
		self:Tag(ptext, '[unit:PPflex]')
		local cres = cFontString(self.Power, nil, cfg.bfont, 21, cfg.fontflag, 1, 1, 1, 'RIGHT')
		cres:SetPoint('RIGHT', self.Power, 'LEFT', -3, 0)        
		self:Tag(cres, '[color][player:Resource]')
		local subpower = cFontString(self.Power, nil, cfg.bfont, 10, cfg.fontflag, 1, 1, 1, 'LEFT')
		subpower:SetPoint('LEFT', self.Power, 'RIGHT', 3, 1)        
		self:Tag(subpower, '[player:SubMana]')

		if class == 'DEATHKNIGHT' and not UnitHasVehicleUI('player') then
			local runes = CreateFrame('Frame', nil, self)
            runes:SetPoint('TOP', self.Power, 'BOTTOM', 0, -4)
            runes:SetSize(cfg.mainUF.width, 3)
            runes.bg = fBackDrop(runes, runes)
			local i = 6
            for index = 1, 6 do
                runes[i] = cStatusbar(runes, cfg.texture, nil, cfg.mainUF.width/6-1, 3, 0.21, 0.6, 0.7, 1)
			    if i == 6 then
                    runes[i]:SetPoint('TOPRIGHT', runes, 'TOPRIGHT', 0, 0)
                else
                    runes[i]:SetPoint('RIGHT', runes[i+1], 'LEFT', -1, 0)
                end
                runes[i].bg = runes[i]:CreateTexture(nil, 'BACKGROUND')
                runes[i].bg:SetAllPoints(runes[i])
                runes[i].bg:SetTexture(cfg.texture)
                runes[i].bg.multiplier = .3

                i=i-1
            end
            self.Runes = runes
		elseif class == 'MONK' then
			-- TODO : Stagger? like Runebar
		elseif class == 'DRUID' then
			-- TODO : MushroomBar?
		elseif class == 'SHAMAN' then
			-- TODO : TotemBar? like Runebar
		end

		self.Combat = self.Power:CreateTexture(nil, 'OVERLAY')
		self.Combat:SetSize(20, 20)
		self.Combat:SetPoint('CENTER', UIParent, 'CENTER', 30, 0)
		-- TODO : Rest Highlight

		-- EXP Bar
		local Experience = CreateFrame('StatusBar', nil, self)
		Experience:SetPoint('TOP', UIParent, 'TOP',0, -5)
		Experience:SetSize(300, 8)
		Experience:SetStatusBarTexture(cfg.texture)
		Experience.bg = fBackDrop(Experience, Experience)

		local Rested = CreateFrame('StatusBar', nil, Experience)
		Rested:SetAllPoints()
		Rested:SetStatusBarTexture(cfg.texture)
		Rested:SetAlpha(0.7)
		Rested:SetBackdrop({
			bgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
			insets = {top = -1, left = -1, bottom = -1, right = -1},
		})
		Rested:SetBackdropColor(0, 0, 0)

		local ExperienceLv = cFontString(Experience, 'OVERLAY', cfg.font, 11, cfg.fontflag, 1, 1, 1)
		ExperienceLv:SetPoint('RIGHT', Experience, 'LEFT', -1, 0)        
		ExperienceLv:SetJustifyH('CENTER')
		self:Tag(ExperienceLv, 'Lv [level]')

		local ExperienceInfo = cFontString(Experience, 'OVERLAY', cfg.font, 9, cfg.fontflag, 1, 1, 1)
		ExperienceInfo:SetPoint('CENTER', Experience, 'CENTER', 0, 0)        
		ExperienceInfo:SetJustifyH('CENTER')
		self:Tag(ExperienceInfo, '[perxp]% / TNL : [tnlxp] (Rest : [perrested]%)')

		local ExperienceBG = Rested:CreateTexture(nil, 'BORDER')
		ExperienceBG:SetAllPoints()
		ExperienceBG:SetColorTexture(1/3, 1/3, 1/3)

		self.Experience = Experience
		self.Experience.Rested = Rested
	end,

	target = function(self, ...)
		Shared(self, ...)			
		self.unit = 'target'

		extCastbar(self)
		
		self:SetSize(3, 10)
		self.Health:SetHeight(10)
		self.Health:SetOrientation("VERTICAL")
		self.Health.colorClass = false
		self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true

		local name = cFontString(self.Health, nil, cfg.font, 12, cfg.fontflag, 1, 1, 1, 'LEFT')
		name:SetPoint('LEFT', self.Health, 'RIGHT', 3, 0)        
		self:Tag(name, '[unit:lv] [color][name]')		
		local htext = cFontString(self, nil, cfg.bfont, 33, cfg.fontflag, 1, 1, 1, 'RIGHT')
		htext:SetPoint('TOPRIGHT', self.Health, 'TOPLEFT', -3, 4)
		self:Tag(htext, '[unit:HPpercent]')

		self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetSize(16, 16)
		self.RaidIcon:SetAlpha(0.9)
		self.RaidIcon:SetPoint("RIGHT", htext, "LEFT", -1, 0)
--[[
		local unitBuff = CreateFrame('Frame', nil, self)
		unitBuff.size = 18
		unitBuff.spacing = 5
		unitBuff.num = 10
		unitBuff:SetSize(unitBuff.size*(unitBuff.num/2)+unitBuff.spacing*(unitBuff.num/2-1), unitBuff.size*2)
		unitBuff:SetPoint('TOPLEFT', self, 'BOTTOMRIGHT', 2, -4)
		unitBuff:SetAlpha(0.8)
		unitBuff.initialAnchor = 'TOPLEFT'
		unitBuff['growth-y'] = 'DOWN'
		unitBuff.PostCreateIcon = PostCreateIconSmall
		unitBuff.PostUpdateIcon = PostUpdateIcon
		self.Buffs = unitBuff

		local unitDebuff = CreateFrame('Frame', nil, self)
		unitDebuff.size = 14
		unitDebuff.spacing = 5
		unitDebuff.num = 6
		unitDebuff:SetSize(unitDebuff.size*unitDebuff.num+unitDebuff.spacing*(unitDebuff.num-1), unitDebuff.size)
		unitDebuff:SetPoint('LEFT', htext, 'RIGHT', 2, 0)
		unitDebuff:SetAlpha(0.8)
		unitDebuff.initialAnchor = 'LEFT'
		unitDebuff.onlyShowPlayer = true
		unitDebuff.PostCreateIcon = PostCreateIconSmall
		unitDebuff.PostUpdateIcon = PostUpdateIcon
		unitDebuff.CustomFilter = CustomFilter
		self.Debuffs = unitDebuff
	]]
	end,

	focus = function(self, ...)
		Shared(self, ...)
		self.unit = 'focus'

		extCastbar(self)

		self:SetSize(3, 14)
		self.Health:SetHeight(14)
		self.Health:SetOrientation("VERTICAL")
		self.Health.colorClass = false
		self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true

		local name = cFontString(self.Health, nil, cfg.font, 16, cfg.fontflag, 1, 1, 1, 'LEFT')
		name:SetPoint('LEFT', self.Health, 'RIGHT', 3, 0)
		self:Tag(name, '[color][name]')

		self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetSize(14, 14)
		self.RaidIcon:SetAlpha(0.9)
		self.RaidIcon:SetPoint("right", self.Health, "LEFT", -4, 0)
	end,

	pet = function(self, ...)
		Shared(self, ...)
		self.unit = 'pet'

		self:SetSize(12, 2)
		self.Health.colorClass = false
		self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true
	end,

	targettarget = function(self, ...)
		Shared(self, ...)
		self.unit = 'targettarget'

		self:SetSize(3, 10)
		self.Health:SetHeight(10)
		self.Health:SetOrientation("VERTICAL")
		self.Health.colorClass = false
    	self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true

		local name = cFontString(self.Health, nil, cfg.font, 12, cfg.fontflag, 1, 1, 1, 'LEFT')
	    name:SetPoint('LEFT', self.Health, 'RIGHT', 3, 0.5)
		self:Tag(name, '[color][name]')
	end,

	party = function(self, ...)
		Shared(self, ...)		
		self.unit = 'party'

		Power(self, 'BOTTOM')
		ctfBorder(self)
		
		self:SetSize(cfg.subUF.party.width, cfg.subUF.party.height)
		self.Health:SetHeight(cfg.subUF.party.height-3)
		self.Health:SetReverseFill(true)
		self.Power:SetHeight(2)

		local name = cFontString(self.Health, nil, cfg.font, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
		name:SetPoint('TOPRIGHT', self.Health, 'TOPLEFT', -1, 2)
		self:Tag(name, '[color][name]')
		
		local htext = cFontString(self.Health, nil, cfg.bfont, 18, cfg.fontflag, 1, 1, 1, 'RIGHT')
		htext:SetPoint('RIGHT', self.Health, 'RIGHT', 1, 0)
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

		local unitDebuff = CreateFrame('Frame', nil, self)
		unitDebuff.size = cfg.subUF.party.height
		unitDebuff.spacing = 5
		unitDebuff.num = 4
		unitDebuff:SetSize(unitDebuff.size*unitDebuff.num+unitDebuff.spacing*(unitDebuff.num-1), unitDebuff.size)
		unitDebuff:SetPoint('LEFT', self, 'RIGHT', 5, 0)
		--unitDebuff:SetAlpha(0.7)
		unitDebuff.PostCreateIcon = PostCreateIconSmall
		unitDebuff.PostUpdateIcon = PostUpdateIcon
		unitDebuff.CustomFilter = CustomFilter
		self.Debuffs = unitDebuff
	end,

	partypet = function(self, ...)
		Shared(self, ...)
		self.unit = 'partypet'

		self:SetSize(cfg.subUF.party.width/2, 2)
		self.Health.colorClass = false
		self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true
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
		
		Power(self, 'BOTTOM')
		ctfBorder(self)

		self:SetSize(cfg.subUF.raid.width, cfg.subUF.raid.height)	
		self.Health:SetHeight(cfg.subUF.raid.height-3)
		self.Health:SetOrientation("VERTICAL")
		self.Power:SetHeight(2)
		
		local name = cFontString(self.Health, nil, cfg.bfont, 10, 'none', 1, 1, 1)
		name:SetPoint('TOPLEFT', 1, 0)		
		name:SetShadowOffset(1, -1)
	    name:SetJustifyH('LEFT')
		self:Tag(name, '[unit:name4]')
	    local htext = cFontString(self.Health, nil, cfg.bfont, 10, cfg.fontflag, 1, 1, 1)
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
	end,

	boss = function(self, ...)
		Shared(self, ...)
		self.unit = 'boss'
		
		Power(self, 'BOTTOM')
		ctfBorder(self)
		
		self:SetSize(cfg.subUF.party.width, cfg.subUF.party.height)
		self.Health:SetHeight(cfg.subUF.party.height-3)
		self.Power:SetHeight(2)

		local name = cFontString(self.Health, nil, cfg.font, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
		name:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 2)
		self:Tag(name, '[color][name]')
		
		local htext = cFontString(self.Health, nil, cfg.bfont, 18, cfg.fontflag, 1, 1, 1, 'LEFT')
		htext:SetPoint('LEFT', self.Health, 'LEFT', 0, 0)
		self:Tag(htext, '[unit:HPmix]')

		self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetSize(18, 18)
		self.RaidIcon:SetAlpha(0.9)
		self.RaidIcon:SetPoint("RIGHT", self.Health, "RIGHT", -1, 0)

	    --[[
	    local altp = createStatusbar(self, cfg.texture, nil, cfg.AltPowerBar.boss.height, cfg.AltPowerBar.boss.width, 1, 1, 1, 1)
        altp:SetPoint(unpack(cfg.AltPowerBar.boss.pos))
		altp.bd = framebd(altp, altp) 
        altp.bg = altp:CreateTexture(nil, 'BORDER')
        altp.bg:SetAllPoints(altp)
        altp.bg:SetTexture(cfg.texture)
        altp.bg:SetVertexColor(1, 1, 1, 0.3)
        altp.Text = fs(altp, 'OVERLAY', cfg.aura.font, cfg.aura.fontsize, cfg.aura.fontflag, 1, 1, 1)
        altp.Text:SetPoint('CENTER')
        self:Tag(altp.Text, '[altpower]') 
		altp:EnableMouse(true)
		altp.colorTexture = true
        self.AltPowerBar = altp
        ]]

		local unitBuff = CreateFrame('Frame', nil, self)
		unitBuff.size = cfg.subUF.party.height
		unitBuff.spacing = 5
		unitBuff.num = 2
		unitBuff:SetSize(unitBuff.size*unitBuff.num+unitBuff.spacing*(unitBuff.num-1), unitBuff.size)
		unitBuff:SetPoint('RIGHT', self, 'LEFT', -5, -0)
		--unitBuff:SetAlpha(0.7)
		unitBuff.initialAnchor = 'RIGHT' 
		unitBuff['growth-x'] = 'LEFT'
		unitBuff.PostCreateIcon = PostCreateIconSmall
		unitBuff.PostUpdateIcon = PostUpdateIcon
		self.Buffs = unitBuff

		local unitDebuff = CreateFrame('Frame', nil, self)
		unitDebuff.size = cfg.subUF.party.height
		unitDebuff.spacing = 5
		unitDebuff.num = 4
		unitDebuff:SetSize(unitDebuff.size*unitDebuff.num+unitDebuff.spacing*(unitDebuff.num-1), unitDebuff.size)
		unitDebuff:SetPoint('LEFT', self, 'RIGHT', 5, 0)
		--unitDebuff:SetAlpha(0.7)
		unitDebuff.PostCreateIcon = PostCreateIconSmall
		unitDebuff.PostUpdateIcon = PostUpdateIcon
		unitDebuff.CustomFilter = CustomFilter
		self.Debuffs = unitDebuff
	end,
}
UnitSpecific.focustarget = UnitSpecific.targettarget

oUF:RegisterStyle('CombaUI', Shared)
for unit,layout in next, UnitSpecific do
    oUF:RegisterStyle('CombaUI - ' .. unit:gsub('^%l', string.upper), layout)
end

-- Spawn Helper -------------------------------------------------------------------------
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
	spawnHelper(self, 'target', 'LEFT', UIParent, 'CENTER', 100, 50)
	spawnHelper(self, 'targettarget', 'TOP', 'oUF_CombaUITarget', 'BOTTOM', 0, -3)
	spawnHelper(self, 'focus', 'LEFT', UIParent, 'CENTER', 100, 100)
	spawnHelper(self, 'focustarget', 'BOTTOM', 'oUF_CombaUIFocus','TOP', 0, 5)
	spawnHelper(self, 'player', cfg.mainUF.position.sa, cfg.mainUF.position.a, cfg.mainUF.position.pa, cfg.mainUF.position.x, cfg.mainUF.position.y)    
	spawnHelper(self, 'pet', 'BOTTOMLEFT', 'oUF_CombaUIPlayer', 'BOTTOMRIGHT', 4, 0)

	self:SetActiveStyle('CombaUI - Party')
	self:SpawnHeader('oUF_Party', nil, 'custom [group:party,nogroup:raid][@raid6,noexists,group:raid] show; hide',
		'showParty', true, 'showPlayer', true, 'showSolo', false, 'showRaid', true,
		'yOffset', -15,
		'oUF-initialConfigFunction', ([[
			self:SetHeight(%d)
			self:SetWidth(%d)
		]]):format(cfg.subUF.party.height, cfg.subUF.party.width)
	):SetPoint(cfg.subUF.party.position.sa, cfg.subUF.party.position.a, cfg.subUF.party.position.pa, cfg.subUF.party.position.x, cfg.subUF.party.position.y)

	self:SetActiveStyle'CombaUI - Partypet'
	self:SpawnHeader('oUF_PartyPets', nil, 'custom [group:party,nogroup:raid][@raid6,noexists,group:raid] show; hide',
		'showParty', true, 'showPlayer', true, 'showSolo', false, 'showRaid', true,
		'yOffset', -13-cfg.subUF.party.height,
		'oUF-initialConfigFunction', ([[
			self:SetAttribute('unitsuffix', 'pet')
		]])
	):SetPoint("TOPRIGHT", 'oUF_Party', "TOPRIGHT", 0, 6)

	self:SetActiveStyle('CombaUI - Partytarget')
	self:SpawnHeader('oUF_PartyTargets', nil, 'custom [group:party,nogroup:raid][@raid6,noexists,group:raid] show; hide',
		'showParty', true, 'showPlayer', true, 'showSolo', false, 'showRaid', true,
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

	for i = 1, MAX_BOSS_FRAMES do
		spawnHelper(self, 'boss'..i, 'LEFT', 'oUF_CombaUIFocus', 'RIGHT', 150, 40-(40*i))
	end
end)