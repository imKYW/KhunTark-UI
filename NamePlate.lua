local name, ns = ...
local cfg = ns.cfg
local oUF = ns.oUF or oUF

-- NamePlateCVars -----------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local NamePlateCVars = {}
-- System
NamePlateCVars["nameplateGlobalScale"] = 1
NamePlateCVars["nameplateMaxDistance"] = 60
NamePlateCVars["nameplateOtherTopInset"] = -1
NamePlateCVars["nameplateOtherBottomInset"] = -1

-- Non Select
NamePlateCVars["nameplateMinScale"] = 0.8
NamePlateCVars["nameplateMaxScale"] = 0.8
NamePlateCVars["nameplateMinAlpha"] = 0.6
NamePlateCVars["nameplateMaxAlpha"] = 0.6
-- Select
NamePlateCVars["nameplateSelectedScale"] = 1
NamePlateCVars["nameplateSelectedAlpha"] = 1

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
	if event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_LEAVE_COMBAT" then
	elseif self.unit ~= unit then
		return
	end
	self.Health:ForceUpdate()
end

local npHealth = function(self)
	local h = CreateFrame("StatusBar", nil, self)
	h:SetStatusBarTexture(cfg.texture)
	h:SetAllPoints()

	local hbg = h:CreateTexture(nil, "BACKGROUND")
	hbg:SetAllPoints(h)
	hbg:SetTexture(cfg.texture)
	hbg.multiplier = 0.4

	h.Smooth = true
	h.colorTapping = true
	h.colorDisconnected = false
	h.colorReaction = true
	h.colorClass = true
	h.colorHealth = true
	h.frequentUpdates = true

	h.colorThreat = true
	h.colorThreatInvers = true

	-- hooks
	h.bg = hbg
	h.PostUpdate = npPostUpdateHealth

	if h.colorThreat then
		self:RegisterEvent("PLAYER_ENTER_COMBAT", npUpdateThreat)
		self:RegisterEvent("PLAYER_LEAVE_COMBAT", npUpdateThreat)
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
	extCastbar(self)

	self:SetSize(80, 8)
	self:SetPoint('CENTER')
	self.Health = npHealth(self)

	local name = cFontString(self.Health, nil, cfg.font, 8, cfg.fontflag, 1, 1, 1, 'CENTER')
	name:SetPoint('BOTTOM', self.Health, 'TOP', 0, 3)
	self:Tag(name, '[color][name]')
	local classification = cFontString(self.Health, nil, cfg.bfont, 9, cfg.fontflag, 1, 0.75, 0, 'LEFT')
	classification:SetPoint('LEFT', self.Health, 'LEFT', 1, 0)
	self:Tag(classification, '[unit:classification]')
	local htext = cFontString(self.Health, nil, cfg.bfont, 7, cfg.fontflag, 1, 1, 1, 'RIGHT')
	htext:SetPoint('RIGHT', self.Health, 'BOTTOMRIGHT', 0, 0)
	self:Tag(htext, '[unit:HPpercent]%')

	self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
	self.RaidIcon:SetSize(12, 12)
	self.RaidIcon:SetAlpha(0.9)
	self.RaidIcon:SetPoint("CENTER", self.Health, "CENTER", 0, 0)

	local unitDebuff = CreateFrame('Frame', nil, self)
	unitDebuff.size = 16
	unitDebuff.spacing = 4
	unitDebuff.num = 6
	unitDebuff:SetSize(unitDebuff.size*unitDebuff.num+unitDebuff.spacing*(unitDebuff.num-1), unitDebuff.size)
	unitDebuff:SetPoint('BOTTOMLEFT', self.Health, 'TOPLEFT', -1, 24)
	unitDebuff.initialAnchor = 'TOPLEFT'
	unitDebuff.onlyShowPlayer = true
	unitDebuff.PostCreateIcon = PostCreateIconSmall
	unitDebuff.PostUpdateIcon = PostUpdateIcon
	unitDebuff.CustomFilter = CustomFilter
	self.Debuffs = unitDebuff
	self.Debuffs:SetScale(0.7) -- trick for Scale bug

--[[
	local AuraTacker = CreateFrame('Frame', nil, self)
	AuraTacker:SetSize(24, 24)    
    AuraTacker:SetPoint('TOP', self.Health, 'BOTTOM', 0, -23)
    AuraTacker:SetFrameStrata('MEDIUM')
    AuraTacker.bg = fBackDrop(AuraTacker, AuraTacker)
    AuraTacker.Icon = AuraTacker:CreateTexture(nil, 'BACKGROUND')
    AuraTacker.Icon:SetAllPoints(AuraTacker)
    AuraTacker.Remaining = AuraTacker:CreateFontString(nil, 'OVERLAY')
    AuraTacker.Remaining:SetPoint('BOTTOM', AuraTacker.Icon, 'BOTTOM', 0, 1)
    AuraTacker.Remaining:SetTextColor(1, 1, 1)
    AuraTacker.Remaining:SetFont(cfg.font, 8, 'THINOUTLINE')
    self.PortraitTimer = AuraTacker
]]
	--[[
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
	]]
end

-- Spawn --------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
oUF:RegisterStyle(name.."Nameplate", NamePlateSpecific)
oUF:SpawnNamePlates(name.."Nameplate", name, nil, NamePlateCVars)
