local _, ns = ...
local cfg = ns.cfg
local oUF = ns.oUF or oUF

local Shared = function(self, unit)
end

local UnitSpecific = {
    player = function(self)
    	self.fBackDrop = fBackDrop(self, self)

		local Health = CreateFrame('StatusBar', nil, self)
		cStatusbar(parent, texture, layer, height, width, r, g, b, alpha)
		Health:SetStatusBarTexture(TEXTURE)
		Health:SetStatusBarColor(1/6, 1/6, 2/7)
		Health.frequentUpdates = true
		self.Health = Health

		local HealthBG = Health:CreateTexture(nil, 'BORDER')
		HealthBG:SetAllPoints()
		HealthBG:SetColorTexture(1/3, 1/3, 1/3)

		self.DebuffHighlight = cfg.dh.player

        local htext = cFontString(self.Health, 'OVERLAY', cfg.font, 15, cfg.fontflag, 1, 1, 1)
        htext:SetPoint('TOP', self.Health, 'TOP', 1.5, -1)        
        htext:SetJustifyH('CENTER')
        self:Tag(htext, '[unit:HPpercent]')
        local ptext = cFontString(self.Power, 'OVERLAY', cfg.font, 10, cfg.fontflag, 1, 1, 1)
        ptext:SetPoint('CENTER', self.Power, 'CENTER', 1, 0)        
        ptext:SetJustifyH('CENTER')
        self:Tag(ptext, '[unit:PPflex]')
        local classResource = cFontString(self, 'OVERLAY', cfg.font, 34, cfg.fontflag)
		classResource:SetPoint('TOPRIGHT', self.Health, 'TOPLEFT', -2, 4)
		classResource:SetAlpha(.8)
		self:Tag(classResource, '[color][unit:Resource]')		
		local subMana = cFontString(self.Power, 'OVERLAY', cfg.font, 10, cfg.fontflag)
		subMana:SetPoint('RIGHT', self.Power, 'LEFT', -1, 0)        
        subMana:SetJustifyH('CENTER')
        self:Tag(subMana, '[unit:SubMana]')

        self.Combat = self.Health:CreateTexture(nil, 'OVERLAY')
		self.Combat:SetSize(16, 16)
		self.Combat:SetPoint('CENTER', self, 'CENTER',0, 2)
		self.Resting = self:CreateTexture(nil, 'OVERLAY')
		self.Resting:SetSize(18, 18)
		self.Resting:SetPoint('BOTTOMRIGHT', self, 'TOPLEFT', 3, 0)
    end,

    target = function(self, ...)
	    local name = cFontString(self.Health, 'OVERLAY', cfg.krfont, 11, cfg.krfontflag, 1, 1, 1)
        name:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT', 4, 0)        
        name:SetJustifyH('LEFT')
		self:Tag(name, '[unit:lv] [color][name]')
        local htext = cFontString(self.Health, 'OVERLAY', cfg.font, 15, cfg.fontflag, 1, 1, 1)
        htext:SetPoint('TOPLEFT', 1, -1)
        htext:SetJustifyH('LEFT')
        self:Tag(htext, '[unit:HPpercent]')
        local htextsub = cFontString(self.Health, 'OVERLAY', cfg.font, cfg.fontsize, cfg.fontflag, 1, 1, 1)
        htextsub:SetPoint('BOTTOMRIGHT', 1, 1)
        htextsub:SetJustifyH('RIGHT')
        self:Tag(htextsub, '[unit:HPstring]')

        self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetSize(16, 16)
		self.RaidIcon:SetPoint("CENTER", self, "LEFT", 0, 0)
    end,

    focus = function(self, ...)
		local name = cFontString(self.Health, 'OVERLAY', cfg.krfont, cfg.krfontsize, cfg.krfontflag, 1, 1, 1)
        name:SetPoint('TOPLEFT', -1, 12)
        name:SetJustifyH('LEFT')
		self:Tag(name, '[unit:name10]')
		local htext = cFontString(self.Health, 'OVERLAY', cfg.font, 15, cfg.fontflag, 1, 1, 1)
        htext:SetPoint('LEFT', 1, 0)
        htext:SetJustifyH('LEFT')
        self:Tag(htext, '[unit:HPpercent]')

        self.RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
		self.RaidIcon:SetSize(16, 16)
		self.RaidIcon:SetPoint("RIGHT", self, "LEFT", -3, 0)
    end,

    pet = function(self, ...)
        Shared(self, ...)
		
		self:SetSize(cfg.player.width, 3)
		self.framebd = framebd(self, self)

		self.Health.colorClass = false
    	self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true
    end,

	targettarget = function(self, ...)
	    Shared(self, ...)

		local name = cFontString(self.Health, 'OVERLAY', cfg.krfont, cfg.krfontsize, 'none', 1, 1, 1)
        name:SetPoint('LEFT', 2, 0)
        name:SetJustifyH('LEFT')
		name:SetShadowOffset(1, -1)
		self:Tag(name, '[unit:name8]')
		local htext = cFontString(self.Health, 'OVERLAY', cfg.font, cfg.fontsize, cfg.fontflag, 1, 1, 1)
        htext:SetPoint('RIGHT', self.Health, 'RIGHT', 1, 0)
        htext:SetJustifyH('RIGHT')
        self:Tag(htext, '[color][unit:HPpercent]')
    end,
}
UnitSpecific.focustarget = UnitSpecific.targettarget

oUF:RegisterStyle('CombatUI', Shared)
oUF:Factory(function(self)
	self:SetActiveStyle('CombatUI')
	self:Spawn('player'):SetPoint('CENTER', UIParent, 'CENTER', 100, 100)
	self:Spawn('target'):SetPoint('BOTTOM', 'oUF_CombatUIPlayer', 'TOP', 0, 6)
	self:Spawn('targettarget'):SetPoint()
	self:Spawn('focus'):SetPoint()
	self:Spawn('focustarget'):SetPoint()
	self:Spawn('pet'):SetPoint()
end)