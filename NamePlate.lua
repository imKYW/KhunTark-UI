local A, L = ...
local cfg = L.cfg
local oUF = L.oUF or oUF

-- NamePlateCVars -----------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local npCVars = {
	-- System
	nameplateGlobalScale = 1,
	NamePlateHorizontalScale = 1,
	NamePlateVerticalScale = 1,

	nameplateLargerScale = 1,
	nameplateLargeTopInset = -1,
	nameplateLargeBottomInset = -1,
	--nameplateOtherAtBase = 1,
	nameplateOtherTopInset = 0.05,
	nameplateOtherBottomInset = 0.05,

	-- Non Select
	nameplateMaxDistance = 40,
	nameplateMaxScale = 0.8,
	nameplateMaxScaleDistance = 10,
	nameplateMaxAlpha = 0.9,
	nameplateMaxAlphaDistance = 10,
	nameplateMinScale = 0.8,
	nameplateMinScaleDistance = 40,
	nameplateMinAlpha = 0.6,
	nameplateMinAlphaDistance = 40,
	-- Select
	nameplateSelectedScale = 1,
	nameplateSelectedAlpha = 1,

	ShowNamePlateLoseAggroFlash = 1,

	--namePlateEnemySize
	--namePlateFriendlySize
}


-- Function -----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local npPostUpdateHealth = function(self, unit, min, max)
	if self.colorThreat and self.colorThreatInvers and unit and UnitThreatSituation("player", unit) == 3 then
		self:SetStatusBarColor(0,1,0)
		self.bg:SetVertexColor(0,0.3,0)
	elseif self.colorThreat and unit and UnitThreatSituation(unit) == 3 then
		self:SetStatusBarColor(1,0,0)
		self.bg:SetVertexColor(0.3,0,0)
	end
end

local npUpdateThreat = function(self, event, unit)
	if event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_LEAVE_COMBAT" or event == "UNIT_THREAT_SITUATION_UPDATE" or event == "UNIT_THREAT_LIST_UPDATE" then
	elseif self.unit ~= unit then
		return
	end
	self.Health:ForceUpdate()
end

local npHealth = function(self)
	local h = CreateFrame("StatusBar", nil, self)
	h:SetAllPoints()
	h:SetStatusBarTexture(cfg.texture)

	local hbg = h:CreateTexture(nil, "BACKGROUND")
	hbg:SetAllPoints(h)
	hbg:SetPoint("TOPLEFT", h ,"TOPLEFT", 0, 0)
	hbg:SetPoint("BOTTOMRIGHT", h ,"BOTTOMRIGHT", 0, 0)
	hbg:SetTexture(cfg.texture)
	hbg.multiplier = 0.4

	h.Smooth = true
	h.colorDisconnected = false
	h.colorTapping = false
	h.colorThreat = true
	h.colorThreatInvers = true
	h.colorClass = true
	h.colorReaction = true
	h.colorHealth = true
	h.frequentUpdates = true

	-- hooks
	h.bg = hbg
	h.PostUpdate = npPostUpdateHealth

	if h.colorThreat then
		self:RegisterEvent("PLAYER_ENTER_COMBAT", npUpdateThreat, true)
		self:RegisterEvent("PLAYER_LEAVE_COMBAT", npUpdateThreat, true)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", npUpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", npUpdateThreat)
	end
	return h
end

-- Layout -------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local NamePlateSpecific = function(self)
	self.unit = 'nameplate'

	fBackDrop(self,self)

	self:SetSize(cfg.UF.nameplate.width, cfg.UF.nameplate.height)
	self:SetPoint('CENTER')
	self.Health = npHealth(self)

	HealthPrediction(self)
	extCastbar(self)

	local name = cFontString(self.Health, nil, cfg.font, 9, cfg.fontflag, 1, 1, 1, 'LEFT')
	name:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 2)
	self:Tag(name, '[color][name]')
	local classification = cFontString(self.Health, nil, cfg.bfont, 12, cfg.fontflag, 1, 0.75, 0, 'LEFT')
	classification:SetPoint('LEFT', self.Health, 'LEFT', 2, 0)
	self:Tag(classification, '[unit:classification]')
	local htext = cFontString(self.Health, nil, cfg.bfont, 10, cfg.fontflag, 1, 1, 1, 'RIGHT')
	htext:SetPoint('RIGHT', self.Health, 'RIGHT', 0, 0)
	self:Tag(htext, '[unit:HPpercent]%')

	self.RaidTargetIndicator = self.Health:CreateTexture(nil, "OVERLAY")
	self.RaidTargetIndicator:SetSize(12, 12)
	self.RaidTargetIndicator:SetAlpha(0.9)
	self.RaidTargetIndicator:SetPoint("CENTER", self.Health, "CENTER", 0, 0)

	local targetMe = cFontString(self.Health, nil, cfg.bfont, 14, cfg.fontflag, 1, 0.1, 0.1, 'LEFT')
	targetMe:SetPoint('CENTER', self.Health, 'CENTER', 0, 0)
	self:Tag(targetMe, '[unit:TargetMe]')

	local unitDebuff = CreateFrame('Frame', nil, self)
	unitDebuff.num = 6
	unitDebuff.spacing = 4
	unitDebuff.size = (cfg.UF.nameplate.width-(unitDebuff.spacing*(unitDebuff.num-1)))/unitDebuff.num
	unitDebuff:SetSize(cfg.UF.nameplate.width, unitDebuff.size)
	unitDebuff:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 28)
	unitDebuff.initialAnchor = 'TOPLEFT'
	unitDebuff.onlyShowPlayer = true
	unitDebuff.PostCreateIcon = PostCreateIconNP
	unitDebuff.PostUpdateIcon = PostUpdateIcon
	unitDebuff.CustomFilter = CustomAuraFilters.nameplateDebuff
	self.Debuffs = unitDebuff

--[[
	local unitBuff = CreateFrame('Frame', nil, self)
	unitBuff.size = 20
	unitBuff.spacing = 4
	unitBuff.num = 2
	unitBuff:SetSize(unitBuff.size*unitBuff.num+unitBuff.spacing*(unitBuff.num-1), unitBuff.size)
	unitBuff:SetPoint('LEFT', self.Health, 'RIGHT', 4, 0)
	unitBuff.initialAnchor = 'LEFT'
	unitBuff.PostCreateIcon = PostCreateIconSmall
	unitBuff.PostUpdateIcon = PostUpdateIcon
	unitBuff.CustomFilter = CustomAuraFilters.nameplate
	self.Buffs = unitBuff
]]

	AuraTracker(self, 30, 'TOP', self.Health, 'BOTTOM', 0, -20)
end

-- Spawn --------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
oUF:RegisterStyle(A.."Nameplate", NamePlateSpecific)
oUF:SetActiveStyle(A.."Nameplate")
oUF:SpawnNamePlates(A.."Nameplate", nil, npCVars)
