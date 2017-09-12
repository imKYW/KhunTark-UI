local name, ns = ...
local cfg = ns.cfg
local oUF = ns.oUF or oUF
local class = select(2, UnitClass('player'))

local auraLoader = CreateFrame('Frame')
auraLoader:RegisterEvent('ADDON_LOADED')
auraLoader:SetScript('OnEvent', function(self, event, addon)
	ActivityAuras = ActivityAuras or {}
	PersonalAuras = PersonalAuras or {}
	UpdateAuraList()
end)

local Shared = function(self, unit)
	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', OnEnterHL)
	self:SetScript('OnLeave', OnLeaveHL)

	Health(self)

	self.fBackDrop = fBackDrop(self, self)
	self.Range = { insideAlpha = 1, outsideAlpha = 0.4 }
end

local UnitSpecific = {
	player = function(self, ...)
		Shared(self, ...)
		self.unit = 'player'

		Power(self, 'BOTTOM')
		extCastbar(self)

		self:SetSize(cfg.mainUF.player.width, cfg.mainUF.player.height)	
		self.Health:SetHeight(cfg.mainUF.player.height-4)
		self.Power:SetHeight(3)		

		local htext = cFontString(self.Health, nil, cfg.bfont, 12, cfg.fontflag, 1, 1, 1, 'RIGHT')
		htext:SetPoint('RIGHT', self.Health, 'RIGHT', 1, 0)
		self:Tag(htext, '[unit:HPpercent]')
		local ptext = cFontString(self.Power, nil, cfg.bfont, 9, cfg.fontflag, 1, 1, 1, 'CENTER')
		ptext:SetPoint('CENTER', self.Power, 'CENTER', 1, -1)        
		self:Tag(ptext, '[unit:PPflex]')
		local cres = cFontString(self.Power, nil, cfg.bfont, 26, cfg.fontflag, 1, 1, 1, 'RIGHT')
		cres:SetPoint('RIGHT', self, 'LEFT', -3, 0)        
		self:Tag(cres, '[color][player:Resource]')
		local subpower = cFontString(self.Power, nil, cfg.bfont, 10, cfg.fontflag, 1, 1, 1, 'LEFT')
		subpower:SetPoint('LEFT', self.Power, 'RIGHT', 3, 0)        
		self:Tag(subpower, '[player:SubMana]')

		if class == 'DEATHKNIGHT' and not UnitHasVehicleUI('player') then
			local runes = CreateFrame('Frame', nil, self)
			runes:SetSize(cfg.mainUF.player.width, 5)
			runes:SetPoint('TOP', self.Power, 'BOTTOM', 0, -4)
			runes.bg = fBackDrop(runes, runes)
			local i = 6
			for index = 1, 6 do
				runes[i] = cStatusbar(runes, cfg.texture, nil, cfg.mainUF.player.width/6-1, 5, 0.21, 0.6, 0.7, 1)
				if i == 6 then
					runes[i]:SetPoint('TOPRIGHT', runes, 'TOPRIGHT', 0, 0)
				else
					runes[i]:SetPoint('RIGHT', runes[i+1], 'LEFT', -1, 0)
				end
				runes[i].bg = runes[i]:CreateTexture(nil, 'BACKGROUND')
				runes[i].bg:SetAllPoints(runes[i])
				runes[i].bg:SetTexture(cfg.texture)
				runes[i].bg.multiplier = 0.3

				i=i-1
			end
			self.Runes = runes
		elseif class == 'MONK' and not UnitHasVehicleUI('player') then
			local stagger = CreateFrame('StatusBar', nil, self)
			stagger:SetSize(cfg.mainUF.player.width, 5)
			stagger:SetPoint('TOP', self.Power, 'BOTTOM', 0, -4)
			stagger.bg = fBackDrop(stagger, stagger)
			stagger.bg = stagger:CreateTexture(nil, 'BACKGROUND')
			stagger.bg:SetAllPoints(stagger)
			stagger.bg:SetTexture(cfg.texture)
			stagger.bg.multiplier = 0.3
			self.Stagger = stagger

			local staggerCurrent = cFontString(self.Stagger, nil, cfg.bfont, 10, cfg.fontflag, 1, 1, 1, 'LEFT')
			staggerCurrent:SetPoint('LEFT', self.Stagger, 'LEFT', 1, 0)        
			self:Tag(staggerCurrent, '[player:StaggerCurrent]')
			local staggerPercent = cFontString(self.Power, nil, cfg.bfont, 14, cfg.fontflag, 1, 1, 1, 'RIGHT')
			staggerPercent:SetPoint('RIGHT', self, 'LEFT', -3, 0)        
			self:Tag(staggerPercent, '[player:StaggerPercent]')
		elseif class == 'DRUID' then
			-- TODO : MushroomBar?
		elseif class == 'SHAMAN' then
			-- TODO : TotemBar? like Runebar
		end

		-- GCD Bar
		local class_color = RAID_CLASS_COLORS[class]
		local gcd = cStatusbar(self, cfg.texture, nil, cfg.mainUF.player.width, 3, class_color.r, class_color.g, class_color.b, 1)
		gcd:SetPoint(cfg.castbar.player.position.sa, cfg.castbar.player.position.a, cfg.castbar.player.position.pa, cfg.castbar.player.position.x, cfg.castbar.player.position.y-cfg.castbar.player.height)
		gcd.bd = fBackDrop(gcd, gcd)
		gcd.bg = gcd:CreateTexture(nil, 'BACKGROUND')
		gcd.bg:SetAllPoints(gcd)
		gcd.bg:SetTexture(cfg.texture)
		gcd.bg:SetVertexColor(class_color.r, class_color.g, class_color.b, 0.4)
		self.GCD = gcd

		self.CombatIndicator = self.Power:CreateTexture(nil, 'OVERLAY')
		self.CombatIndicator:SetSize(17, 17)
		self.CombatIndicator:SetPoint('LEFT', self.Health, 'LEFT', 0, 0)
		-- TODO : Rest Highlight

		-- EXP Bar
		local Experience = CreateFrame('StatusBar', nil, self, 'AnimatedStatusBarTemplate')
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
		self:Tag(ExperienceInfo, '[experience:per]% / TNL : [experience:tnl] (Rest : [experience:perrested]%)')

		local ExperienceBG = Rested:CreateTexture(nil, 'BORDER')
		ExperienceBG:SetAllPoints()
		ExperienceBG:SetColorTexture(1/3, 1/3, 1/3)

		self.Experience = Experience
		self.Experience.Rested = Rested

		local personalBuff = CreateFrame('Frame', nil, self)
		personalBuff.size = 36
		personalBuff.spacing = 4
		personalBuff.num = 3
		personalBuff:SetSize((personalBuff.size+personalBuff.spacing)*personalBuff.num-personalBuff.spacing, personalBuff.size)
		personalBuff:SetPoint('CENTER', UIParent, 'CENTER', 75, 0)
		personalBuff.initialAnchor = 'CENTER'            
		personalBuff['growth-x'] = 'RIGHT' 
		personalBuff['growth-y'] = 'DOWN'
		personalBuff.PostCreateIcon = PostCreateIconNormal
		personalBuff.PostUpdateIcon = PostUpdateIcon
		personalBuff.CustomFilter = CustomAuraFilters.personal
		self.Auras = personalBuff

		local activityBuff = CreateFrame('Frame', nil, self)
		activityBuff.size = 30
		activityBuff.spacing = 4
		activityBuff.num = 10
		activityBuff:SetSize((activityBuff.size+activityBuff.spacing)*(activityBuff.num/2)-activityBuff.spacing, activityBuff.size*2+activityBuff.spacing)
		activityBuff:SetPoint('CENTER', UIParent, 'CENTER', -75, 0)
		activityBuff.initialAnchor = 'CENTER'
		activityBuff['growth-x'] = 'LEFT'
		activityBuff['growth-y'] = 'DOWN'
		activityBuff.PostCreateIcon = PostCreateIconNormal
		activityBuff.PostUpdateIcon = PostUpdateIcon
		activityBuff.CustomFilter = CustomAuraFilters.activity
		self.Buffs = activityBuff

		local PlayerFCF = CreateFrame("Frame", nil, self)
		PlayerFCF:SetSize(35, 35)
		PlayerFCF:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
		for i = 1, 8 do
			PlayerFCF[i] = PlayerFCF:CreateFontString(nil, "OVERLAY", "CombatTextFont")
		end
		PlayerFCF.mode = "Fountain"
		--PlayerFCF.xOffset = 30
		PlayerFCF.fontHeight = cfg.plugin.fcf.size
		PlayerFCF.abbreviateNumbers = true
		self.FloatingCombatFeedback = PlayerFCF
	end,

	target = function(self, ...)
		Shared(self, ...)
		self.unit = 'target'

		extCastbar(self)
		--PortraitTimer(self, 38, 16, 'BOTTOMLEFT', self, 'TOPLEFT', 0, 5)
		
		self:SetSize(cfg.mainUF.player.width*0.8, cfg.mainUF.player.height)
		--self.Health.colorClass = false
		--self.Health.colorReaction = false
		--self.Health.colorHealth = true
		--self.Health.colorSmooth = true

		local name = cFontString(self.Health, nil, cfg.font, 13, cfg.fontflag, 1, 1, 1, 'LEFT')
		name:SetPoint('LEFT', self.Health, 'RIGHT', 3, 0)
		self:Tag(name, '[unit:lv] [color][name]')
		local htext = cFontString(self.Health, nil, cfg.bfont, 16, cfg.fontflag, 1, 1, 1, 'LEFT')
		htext:SetPoint('LEFT', self.Health, 'LEFT', 1, 0)
		self:Tag(htext, '[unit:HPpercent]')
		local htext = cFontString(self.Health, nil, cfg.bfont, 10, cfg.fontflag, 1, 1, 1, 'RIGHT')
		htext:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', 1, 1)
		self:Tag(htext, '[unit:HPcurrent]')

		self.RaidTargetIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidTargetIndicator:SetSize(16, 16)
		self.RaidTargetIndicator:SetAlpha(0.9)
		self.RaidTargetIndicator:SetPoint("CENTER", self.Health, "CENTER", 0, 0)

		local unitBuff = CreateFrame('Frame', nil, self)
		unitBuff.size = 14
		unitBuff.spacing = 4
		unitBuff.num = 6
		unitBuff:SetSize(unitBuff.size*unitBuff.num+unitBuff.spacing*(unitBuff.num-1), unitBuff.size)
		unitBuff:SetPoint('LEFT', name, 'RIGHT', 5, 0)
		unitBuff.initialAnchor = 'LEFT'
		unitBuff.PostCreateIcon = PostCreateIconSmall
		unitBuff.PostUpdateIcon = PostUpdateIcon
		--unitBuff.CustomFilter = CustomFilter
		self.Buffs = unitBuff

		local unitDebuff = CreateFrame('Frame', nil, self)
		unitDebuff.size = 16
		unitDebuff.spacing = 4
		unitDebuff.num = 8
		unitDebuff:SetSize(unitDebuff.size*unitDebuff.num+unitDebuff.spacing*(unitDebuff.num-1), unitDebuff.size)
		unitDebuff:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT', 0, -5)
		unitDebuff.initialAnchor = 'LEFT'
		unitDebuff.onlyShowPlayer = true
		unitDebuff.PostCreateIcon = PostCreateIconSmall
		unitDebuff.PostUpdateIcon = PostUpdateIcon
		--unitDebuff.CustomFilter = CustomFilter
		self.Debuffs = unitDebuff
	end,

	focus = function(self, ...)
		Shared(self, ...)
		self.unit = 'focus'

		extCastbar(self)
		--PortraitTimer(self, 26, 11, 'RIGHT', self, 'LEFT', -5, 0)

		self:SetSize(cfg.mainUF.focus.width, cfg.mainUF.focus.height)
		self.Health:SetHeight(cfg.mainUF.focus.height)

		local name = cFontString(self.Health, nil, cfg.font, 13, cfg.fontflag, 1, 1, 1, 'LEFT')
		name:SetPoint('LEFT', self.Health, 'RIGHT', 3, 0)
		self:Tag(name, '[color][name]')

		self.RaidTargetIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidTargetIndicator:SetSize(14, 14)
		self.RaidTargetIndicator:SetAlpha(0.9)
		self.RaidTargetIndicator:SetPoint("right", self.Health, "LEFT", -4, 0)
	end,

	pet = function(self, ...)
		Shared(self, ...)
		self.unit = 'pet'

		self:SetSize(cfg.mainUF.player.width/3, 2)
		self.Health.colorClass = false
		self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true
	end,

	targettarget = function(self, ...)
		Shared(self, ...)
		self.unit = 'targettarget'

		self:SetSize((cfg.mainUF.player.width*0.8)/3, 6)
		self.Health.colorClass = false
    	self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true

		local name = cFontString(self.Health, nil, cfg.font, 12, cfg.fontflag, 1, 1, 1, 'LEFT')
	    name:SetPoint('LEFT', self.Health, 'RIGHT', 3, 0.5)
		self:Tag(name, '[color][name]')
	end,

	focustarget = function(self, ...)
		Shared(self, ...)
		self.unit = 'focustarget'

		self:SetSize((cfg.mainUF.player.width*0.8)/3, 6)
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
		Phase(self)
		ctfBorder(self)
		--PortraitTimer(self, 34, 12, 'CENTER', self, 'CENTER', 0, 0)
		
		self:SetSize(cfg.subUF.party.width, cfg.subUF.party.height)
		self.Health:SetHeight(cfg.subUF.party.height-3)
		self.Health:SetReverseFill(true)
		self.Power:SetHeight(2)
		self.Power:SetReverseFill(true)

		local name = cFontString(self.Health, nil, cfg.font, 12, cfg.fontflag, 1, 1, 1, 'RIGHT')
		name:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT', 3, 2)
		self:Tag(name, '[color][name]')

		local htext = cFontString(self.Health, nil, cfg.bfont, 18, cfg.fontflag, 1, 1, 1, 'RIGHT')
		htext:SetPoint('RIGHT', self.Health, 'RIGHT', 1, 0)
		self:Tag(htext, '[unit:HPmix]')

		self.DebuffHighlight = true

		self.LeaderIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.LeaderIndicator:SetSize(11, 11)
		self.LeaderIndicator:SetPoint("CENTER", self, "TOPLEFT", 4, 5)
		self.AssistantIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.AssistantIndicator:SetSize(11, 11)
		self.AssistantIndicator:SetPoint("CENTER", self, "TOPLEFT", 4, 5)
		self.RaidTargetIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidTargetIndicator:SetSize(18, 18)
		self.RaidTargetIndicator:SetAlpha(0.9)
		self.RaidTargetIndicator:SetPoint("LEFT", self.Health, "LEFT", 1, 0)
		self.GroupRoleIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.GroupRoleIndicator:SetSize(10, 10)
		self.GroupRoleIndicator:SetPoint("CENTER", self.Health, "TOPLEFT", 6, -6)
		self.ReadyCheckIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheckIndicator:SetSize(22, 22)
		self.ReadyCheckIndicator:SetPoint("CENTER", self.Health, "CENTER", 0, 0)

		local unitDebuff = CreateFrame('Frame', nil, self)
		unitDebuff.size = cfg.subUF.party.height
		unitDebuff.spacing = 5
		unitDebuff.num = 4
		unitDebuff:SetSize(unitDebuff.size*unitDebuff.num+unitDebuff.spacing*(unitDebuff.num-1), unitDebuff.size)
		unitDebuff:SetPoint('RIGHT', self, 'LEFT', -5, 0)
		unitDebuff.initialAnchor = 'RIGHT' 
		unitDebuff['growth-x'] = 'LEFT'
		unitDebuff.PostCreateIcon = PostCreateIconSmall
		unitDebuff.PostUpdateIcon = PostUpdateIcon
		--unitDebuff.CustomFilter = CustomFilter
		self.Debuffs = unitDebuff
	end,

	partypet = function(self, ...)
		Shared(self, ...)
		self.unit = 'partypet'

		self:SetSize(cfg.subUF.party.width/3, 2)
		self.Health.colorClass = false
		self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true
	end,

	partytarget = function(self, ...)
		Shared(self, ...)
		self.unit = 'partytarget'

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

	raid = function(self, ...)
		Shared(self, ...)
		self.unit = 'raid'		
		self:SetAttribute("type2", "focus")
		
		Power(self, 'BOTTOM')
		Phase(self)
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

	    self.LeaderIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.LeaderIndicator:SetSize(11, 11)
		self.LeaderIndicator:SetPoint("CENTER", self, "TOPLEFT", 4, 5)
		self.AssistantIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.AssistantIndicator:SetSize(11, 11)
		self.AssistantIndicator:SetPoint("CENTER", self, "TOPLEFT", 4, 5)
		self.RaidTargetIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidTargetIndicator:SetSize(16, 16)
		self.RaidTargetIndicator:SetPoint("CENTER", self, "LEFT", 0, 0)
		self.GroupRoleIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.GroupRoleIndicator:SetSize(10, 10)
		self.GroupRoleIndicator:SetPoint("CENTER", self, "TOPRIGHT", -6, -6)
		self.ReadyCheckIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.ReadyCheckIndicator:SetSize(32, 32)
		self.ReadyCheckIndicator:SetPoint("CENTER", self, "CENTER", 0, 0)

		self.FreebAuras = CreateFrame('Frame', nil, self)
		self.FreebAuras:SetSize(cfg.subUF.raid.width*0.65, cfg.subUF.raid.height*0.65)
		self.FreebAuras:SetPoint('CENTER', self.Health)
	end,

	tank = function(self, ...)
		Shared(self, ...)
		self.unit = 'tank'
		
		Power(self, 'BOTTOM')
		ctfBorder(self)
		--PortraitTimer(self, cfg.subUF.party.height, 14, 'LEFT', self, 'RIGHT', 5, 0) -- x = -(cfg.subUF.party.height-10-(cfg.subUF.party.height/2))
		
		self:SetSize(cfg.subUF.party.width, cfg.subUF.party.height)
		self.Health:SetHeight(cfg.subUF.party.height-3)
		self.Health:SetReverseFill(true)
		self.Power:SetHeight(2)
		self.Power:SetReverseFill(true)

		local name = cFontString(self.Health, nil, cfg.font, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
		name:SetPoint('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 2, 2)
		self:Tag(name, '[color][name]')
		
		local htext = cFontString(self.Health, nil, cfg.bfont, 18, cfg.fontflag, 1, 1, 1, 'RIGHT')
		htext:SetPoint('RIGHT', self.Health, 'RIGHT', 1, 0)
		self:Tag(htext, '[unit:HPmix]')

		self.RaidTargetIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidTargetIndicator:SetSize(18, 18)
		self.RaidTargetIndicator:SetAlpha(0.9)
		self.RaidTargetIndicator:SetPoint("LEFT", self.Health, "LEFT", 0, 0)

		self.FreebAuras = CreateFrame('Frame', nil, self)
		self.FreebAuras:SetSize(cfg.subUF.party.height, cfg.subUF.party.height)
		self.FreebAuras:SetPoint('LEFT', self, "RIGHT", 5, 0)

		local unitDebuff = CreateFrame('Frame', nil, self)
		unitDebuff.size = cfg.subUF.party.height
		unitDebuff.spacing = 5
		unitDebuff.num = 5
		unitDebuff:SetSize(unitDebuff.size*unitDebuff.num+unitDebuff.spacing*(unitDebuff.num-1), unitDebuff.size)
		unitDebuff:SetPoint('RIGHT', self, 'LEFT', -5, 0)
		unitDebuff.initialAnchor = 'RIGHT'
		unitDebuff['growth-x'] = 'LEFT'
		unitDebuff.PostCreateIcon = PostCreateIconSmall
		unitDebuff.PostUpdateIcon = PostUpdateIcon
		--unitDebuff.CustomFilter = CustomFilter
		self.Debuffs = unitDebuff
	end,

	boss = function(self, ...)
		Shared(self, ...)
		self.unit = 'boss'
		
		Power(self, 'BOTTOM')
		ctfBorder(self)
		
		self:SetSize(cfg.subUF.party.width, cfg.subUF.party.height)
		self.Health:SetHeight(cfg.subUF.party.height-3)
		self.Power:SetHeight(2)

		local name = cFontString(self.Health, nil, cfg.font, 11, cfg.fontflag, 1, 1, 1, 'LEFT')
		name:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 2)
		self:Tag(name, '[color][name]')
		
		local htext = cFontString(self.Health, nil, cfg.bfont, 18, cfg.fontflag, 1, 1, 1, 'LEFT')
		htext:SetPoint('LEFT', self.Health, 'LEFT', 1, 0)
		self:Tag(htext, '[unit:HPmix]')

		self.RaidTargetIndicator = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidTargetIndicator:SetSize(18, 18)
		self.RaidTargetIndicator:SetAlpha(0.9)
		self.RaidTargetIndicator:SetPoint("RIGHT", self.Health, "RIGHT", -1, 0)

	    --[[
	    local altp = createStatusbar(self, cfg.texture, nil, cfg.AlternativePower.boss.height, cfg.AlternativePower.boss.width, 1, 1, 1, 1)
        altp:SetPoint(unpack(cfg.AlternativePower.boss.pos))
		altp.bd = framebd(altp, altp) 
        altp.bg = altp:CreateTexture(nil, 'BORDER')
        altp.bg:SetAllPoints(altp)
        altp.bg:SetTexture(cfg.texture)
        altp.bg:SetVertexColor(1, 1, 1, 0.3)
        altp.Text = fs(altp, 'OVERLAY', cfg.aura.font, cfg.aura.fontsize, cfg.aura.fontflag, 1, 1, 1)
        altp.Text:SetPoint('CENTER')
        self:Tag(altp.Text, '[altpower]') 
		altp:EnableMouse(true)
        self.AlternativePower = altp
        ]]

		local unitBuff = CreateFrame('Frame', nil, self)
		unitBuff.size = cfg.subUF.party.height
		unitBuff.spacing = 5
		unitBuff.num = 2
		unitBuff:SetSize(unitBuff.size*unitBuff.num+unitBuff.spacing*(unitBuff.num-1), unitBuff.size)
		unitBuff:SetPoint('RIGHT', self, 'LEFT', -5, 0)
		--unitBuff:SetAlpha(0.7)
		unitBuff.initialAnchor = 'RIGHT'
		unitBuff['growth-x'] = 'LEFT'
		unitBuff.PostCreateIcon = PostCreateIconSmall
		unitBuff.PostUpdateIcon = PostUpdateIcon
		self.Buffs = unitBuff

		local unitDebuff = CreateFrame('Frame', nil, self)
		unitDebuff.size = cfg.subUF.party.height
		unitDebuff.spacing = 5
		unitDebuff.num = 5
		unitDebuff:SetSize(unitDebuff.size*unitDebuff.num+unitDebuff.spacing*(unitDebuff.num-1), unitDebuff.size)
		unitDebuff:SetPoint('LEFT', self, 'RIGHT', 5, 0)
		--unitDebuff:SetAlpha(0.7)
		unitDebuff.PostCreateIcon = PostCreateIconSmall
		unitDebuff.PostUpdateIcon = PostUpdateIcon
		--unitDebuff.CustomFilter = CustomFilter
		self.Debuffs = unitDebuff
	end,

	arena = function(self, ...)
		Shared(self, ...)
		self.unit = 'arena'		
		self:SetAttribute("type2", "focus")
		
		Power(self, 'BOTTOM')
		--extCastbar(self)
		ctfBorder(self)		
		--PortraitTimer(self, 36, 16, 'CENTER', self, 'LEFT', -16, 0) -- x = -(cfg.subUF.party.height-10-(cfg.subUF.party.height/2))
		
		self:SetSize(cfg.subUF.party.width, cfg.subUF.party.height)
		self.Health:SetHeight(cfg.subUF.party.height-3)
		self.Power:SetHeight(2)

		local name = cFontString(self.Health, nil, cfg.font, 12, cfg.fontflag, 1, 1, 1, 'RIGHT')
		name:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT', 3, 2)
		self:Tag(name, '[color][name]')
		
		local htext = cFontString(self.Health, nil, cfg.bfont, 18, cfg.fontflag, 1, 1, 1, 'LEFT')
		htext:SetPoint('LEFT', self.Health, 'LEFT', 1, 1)
		self:Tag(htext, '[unit:HPmix]')

		local t = CreateFrame('Frame', nil, self)
		t:SetSize(cfg.subUF.party.height, cfg.subUF.party.height)
		t:SetPoint("TOPRIGHT", self, "TOPLEFT", -cfg.subUF.party.height-10, 0)
		t.bg = fBackDrop(t, t)
		self.Trinket = t
    end,

    arenatarget = function(self, ...)
		Shared(self, ...)
		self.unit = 'arenatarget'

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
}

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
	spawnHelper(self, 'player', cfg.mainUF.player.position.sa, cfg.mainUF.player.position.a, cfg.mainUF.player.position.pa, cfg.mainUF.player.position.x, cfg.mainUF.player.position.y)
	spawnHelper(self, 'pet', 'BOTTOMLEFT', 'oUF_CombaUIPlayer', 'TOPLEFT', 0, 5)
	spawnHelper(self, 'target', 'LEFT', 'oUF_CombaUIPlayer', 'RIGHT', 10, 0)
	spawnHelper(self, 'targettarget', 'BOTTOMRIGHT', 'oUF_CombaUITarget', 'TOPRIGHT', 0, 5)
	spawnHelper(self, 'focus', cfg.mainUF.focus.position.sa, cfg.mainUF.focus.position.a, cfg.mainUF.focus.position.pa, cfg.mainUF.focus.position.x, cfg.mainUF.focus.position.y)
	spawnHelper(self, 'focustarget', 'TOPRIGHT', 'oUF_CombaUIFocus','BOTTOMRIGHT', 0, -7)

	self:SetActiveStyle('CombaUI - Party') -- custom [group:party,nogroup:raid][@raid4,noexists,group:raid]show; hide
	self:SpawnHeader('oUF_Party', nil, 'custom [group:party,nogroup:raid][@raid4,noexists,group:raid]show; hide',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'yOffset', 18,
		'point', 'BOTTOM',
		'oUF-initialConfigFunction', ([[
			self:SetHeight(%d)
			self:SetWidth(%d)
		]]):format(cfg.subUF.party.height, cfg.subUF.party.width)
	):SetPoint(cfg.subUF.party.position.sa, cfg.subUF.party.position.a, cfg.subUF.party.position.pa, cfg.subUF.party.position.x, cfg.subUF.party.position.y)

	self:SetActiveStyle('CombaUI - Partypet')
	self:SpawnHeader('oUF_PartyPets', nil, 'custom [group:party,nogroup:raid][@raid4,noexists,group:raid]show; hide',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'yOffset', 16+cfg.subUF.party.height,
		'point', 'BOTTOM',
		'oUF-initialConfigFunction', ([[
			self:SetAttribute('unitsuffix', 'pet')
			self:SetHeight(%d)
			self:SetWidth(%d)
		]]):format(2, cfg.subUF.party.width/3)
	):SetPoint("TOPRIGHT", 'oUF_Party', "TOPRIGHT", 0, 5)

	self:SetActiveStyle('CombaUI - Partytarget')
	self:SpawnHeader('oUF_PartyTargets', nil, 'custom [group:party,nogroup:raid][@raid4,noexists,group:raid]show; hide',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'yOffset', 8+cfg.subUF.party.height,
		'point', 'BOTTOM',
		'oUF-initialConfigFunction', ([[
			self:SetAttribute('unitsuffix', 'target')
			self:SetHeight(%d)
			self:SetWidth(%d)
		]]):format(10, 3)
	):SetPoint('BOTTOMLEFT', 'oUF_Party', 'BOTTOMRIGHT', 5, 0)

	self:SetActiveStyle('CombaUI - Raid')
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

	self:SetActiveStyle('CombaUI - Tank')
	self:SpawnHeader('oUF_MainTank', nil, 'raid',
		'showParty', true, 'showPlayer', true, 'showSolo', true, 'showRaid', true,
		'groupFilter', 'MAINTANK',
		'yOffset', 18,		
		'point', 'BOTTOM',
		'oUF-initialConfigFunction', ([[
			self:SetHeight(%d)
			self:SetWidth(%d)
		]]):format(cfg.subUF.party.height, cfg.subUF.party.width)
	):SetPoint(cfg.subUF.party.position.sa, cfg.subUF.party.position.a, cfg.subUF.party.position.pa, cfg.subUF.party.position.x, cfg.subUF.party.position.y)

	for i = 1, MAX_BOSS_FRAMES do
		spawnHelper(self, 'boss'..i, cfg.subUF.boss.position.sa, cfg.subUF.boss.position.a, cfg.subUF.boss.position.pa, cfg.subUF.boss.position.x, cfg.subUF.boss.position.y-43+(43*i))
	end

	local arena = {}
	self:SetActiveStyle'CombaUI - Arena'
	for i = 1, 3 do -- MAX_ARENA_ENEMIES
		arena[i] = self:Spawn('arena'..i, 'oUF_Arena'..i)
		if i == 1 then
			arena[i]:SetPoint(cfg.subUF.boss.position.sa, cfg.subUF.boss.position.a, cfg.subUF.boss.position.pa, cfg.subUF.boss.position.x, cfg.subUF.boss.position.y)
		else
			arena[i]:SetPoint('BOTTOM', arena[i-1], 'TOP', 0, 18)
		end
	end
	local arenapet = {}
	self:SetActiveStyle'CombaUI - Partypet'
	for i = 1, 3 do
		arenapet[i] = self:Spawn("arena"..i.."pet", "oUF_Arena"..i.."pet")
		arenapet[i]:SetPoint("BOTTOMLEFT", arena[i], "TOPLEFT", 0, 3)
	end
	local arenatarget = {}	
	self:SetActiveStyle'CombaUI - Partytarget'
	for i = 1, 3 do
		arenatarget[i] = self:Spawn('arena'..i..'target', 'oUF_Arena'..i..'target')
		arenatarget[i]:SetPoint('BOTTOMLEFT', arena[i], 'BOTTOMRIGHT', 5, 0)
	end
		
	local arenaprep = {}
	local arenaprepspec = {}
	for i = 1, 3 do
	    arenaprep[i] = CreateFrame('Frame', 'oUF_ArenaPrep'..i, UIParent)
	    arenaprep[i]:SetSize(cfg.subUF.party.width, cfg.subUF.party.height)
	    arenaprep[i]:SetPoint("TOPLEFT", arena[i], "TOPLEFT", 0, 0)
	    arenaprep[i]:SetFrameStrata('BACKGROUND')
		arenaprep[i].bg = fBackDrop(arenaprep[i], arenaprep[i])

		arenaprep[i].Health = CreateFrame('StatusBar', nil, arenaprep[i])
		arenaprep[i].Health:SetSize(cfg.subUF.party.width, cfg.subUF.party.height-3)
		arenaprep[i].Health:SetPoint("TOP", arenaprep[i], "TOP", 0, 0)
		arenaprep[i].Health:SetStatusBarTexture(cfg.texture)
		arenaprep[i].Health:SetStatusBarColor(0, 0, 0)
		arenaprep[i].Power = CreateFrame('StatusBar', nil, arenaprep[i])
		arenaprep[i].Power:SetSize(cfg.subUF.party.width, 2)
		arenaprep[i].Power:SetPoint("TOP", arenaprep[i].Health, "BOTTOM", 0, -1)
		arenaprep[i].Power:SetStatusBarTexture(cfg.texture)
		arenaprep[i].Power:SetStatusBarColor(0, 0, 0)

	    arenaprep[i].Spec = cFontString(arenaprep[i].Health, 'OVERLAY', cfg.font, 12, cfg.fontflag, 1, 1, 1, 'CENTER')
	    arenaprep[i].Spec:SetPoint('CENTER')
		arenaprep[i].SpecIcon = CreateFrame('Frame', nil, arenaprep[i])
		arenaprep[i].SpecIcon:SetSize(cfg.subUF.party.height,cfg.subUF.party.height)
		arenaprep[i].SpecIcon:SetPoint("TOPRIGHT", arena[i], "TOPLEFT", -5, 0)
		arenaprep[i].SpecIcon.bg = fBackDrop(arenaprep[i].SpecIcon, arenaprep[i].SpecIcon)
		arenaprep[i].SpecIcon.i = arenaprep[i].SpecIcon.bg:CreateTexture(nil, 'OVERLAY')
		arenaprep[i].SpecIcon.i:SetSize(cfg.subUF.party.height, cfg.subUF.party.height)
		arenaprep[i].SpecIcon.i:SetPoint("TOPRIGHT", arena[i], "TOPLEFT", -5, 0)
		--arenaprep[i].SpecIcon.i:SetTexture([[INTERFACE\AddOns\oUF_KBJ\Media\Mage.tga]]) -- debug		

	    arenaprep[i]:Hide()
	end

	local arenaprepupdate = CreateFrame('Frame')
	arenaprepupdate:RegisterEvent('PLAYER_LOGIN')
	arenaprepupdate:RegisterEvent('PLAYER_ENTERING_WORLD')
	--arenaprepupdate:RegisterEvent('ARENA_OPPONENT_UPDATE')
	arenaprepupdate:RegisterEvent('ARENA_PREP_OPPONENT_SPECIALIZATIONS')
	arenaprepupdate:SetScript('OnEvent', function(self, event)
	    if event == 'PLAYER_LOGIN' then
		    for i = 1, 3 do
			    arenaprep[i]:SetAllPoints(_G['oUF_Arena'..i])
		    end
		--[[ Used Trick
	    elseif event == 'ARENA_OPPONENT_UPDATE' then
		    for i = 1, 5 do
			    arenaprep[i]:Hide()
		    end
		]]
	    else
	    	local numOpps = GetNumArenaOpponentSpecs()
		    if numOpps > 0 then
			    for i = 1, numOpps do
				    local f = arenaprep[i]

				    if i <= numOpps then
					    local s = GetArenaOpponentSpec(i)
					    local _, spec, class, texture = nil, 'UNKNOWN', 'UNKNOWN', nil

					    if s and s > 0 then
						    _, spec, _, texture, _, class = GetSpecializationInfoByID(s)
					    end

					    if class and spec then
					    	local class_color = RAID_CLASS_COLORS[class] or {0.3, 0.3, 0.3}
							f.Health:SetStatusBarColor(class_color.r, class_color.g, class_color.b)							
							f.Power:SetStatusBarColor(class_color.r, class_color.g, class_color.b)
						    f.Spec:SetText(spec)
						    f.SpecIcon.i:SetTexture(texture or [[INTERFACE\ICONS\INV_MISC_QUESTIONMARK]])
						    f:Show()
					    end
				    else
					    f:Hide()
				    end
			    end
		    else
			    for i = 1, numOpps do
				    arenaprep[i]:Hide()
			    end
		    end
	    end
	end)
end)

----------------------------------------------------------------------------------------
--	Test UnitFrames(by community)
----------------------------------------------------------------------------------------
-- For testing /run oUFAbu.TestArena()
function TUF()
	oUF_CombaUIBoss1:Show(); oUF_CombaUIBoss1.Hide = function() end oUF_CombaUIBoss1.unit = "target"
	oUF_CombaUIBoss2:Show(); oUF_CombaUIBoss2.Hide = function() end oUF_CombaUIBoss2.unit = "target"
	--oUF_Party:Show(); oUF_Party.Hide = function() end oUF_Party.unit = "target"
	--oUF_PartyPets:Show(); oUF_PartyPets.Hide = function() end oUF_PartyPets.unit = "target"
	--oUF_PartyTargets:Show(); oUF_PartyTargets.Hide = function() end oUF_PartyTargets.unit = "target"

	--oUF_MainTank:Show(); oUF_MainTank.Hide = function() end oUF_MainTank.unit = "target"
	--[[
	oUF_Arena1:Show(); oUF_Arena1.Hide = function() end oUF_Arena1.unit = "target"
	oUF_Arena2:Show(); oUF_Arena2.Hide = function() end oUF_Arena2.unit = "target"
	oUF_Arena3:Show(); oUF_Arena3.Hide = function() end oUF_Arena3.unit = "target"
	oUF_Arena1target:Show(); oUF_Arena1target.Hide = function() end oUF_Arena1target.unit = "target"
	oUF_Arena2target:Show(); oUF_Arena2target.Hide = function() end oUF_Arena2target.unit = "target"
	oUF_Arena3target:Show(); oUF_Arena3target.Hide = function() end oUF_Arena3target.unit = "target"
	oUF_Arena1pet:Show(); oUF_Arena1pet.Hide = function() end oUF_Arena1pet.unit = "target"
	oUF_Arena2pet:Show(); oUF_Arena2pet.Hide = function() end oUF_Arena2pet.unit = "target"
	oUF_Arena3pet:Show(); oUF_Arena3pet.Hide = function() end oUF_Arena3pet.unit = "target"
	oUF_ArenaPrep1:Show(); oUF_ArenaPrep1.Hide = function() end oUF_ArenaPrep1.unit = "target"
	oUF_ArenaPrep2:Show(); oUF_ArenaPrep2.Hide = function() end oUF_ArenaPrep2.unit = "target"	
	oUF_ArenaPrep3:Show(); oUF_ArenaPrep3.Hide = function() end oUF_ArenaPrep3.unit = "target"
	]]
	local time = 0
	local f = CreateFrame("Frame")
	f:SetScript("OnUpdate", function(self, elapsed)
		time = time + elapsed
		if time > 5 then
			oUF_CombaUIBoss1:UpdateAllElements("ForceUpdate")
			oUF_CombaUIBoss2:UpdateAllElements("ForceUpdate")
			--oUF_Party:UpdateAllElements("ForceUpdate")

			--oUF_MainTank:UpdateAllElements("ForceUpdate")
			--oUF_Arena1:UpdateAllElements("ForceUpdate")
			--oUF_Arena2:UpdateAllElements("ForceUpdate")
			--oUF_Arena3:UpdateAllElements("ForceUpdate")
			time = 0
		end
	end)
end