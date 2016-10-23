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
		
		self:SetSize((cfg.mainUF.targetWidth-5)/2, cfg.mainUF.targetHeight/2)	
		self.Health:SetHeight(cfg.mainUF.targetHeight / 2)

        local htext = cFontString(self.Health, 'OVERLAY', cfg.font, 16, cfg.fontflag, 1, 1, 1, 'LEFT')
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
		
		self:SetSize(cfg.mainUF.targetWidth, cfg.mainUF.targetHeight)
		self.Health:SetHeight(cfg.mainUF.targetHeight-3)
	    self.Power:SetHeight(2)

	    local name = cFontString(self.Health, 'OVERLAY', cfg.stdfont, 11, cfg.stdfontflag, 1, 1, 1, 'LEFT')
        name:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT', 4, 0)        
		self:Tag(name, '[color][name] [unit:lv]')
		
        local htext = cFontString(self.Health, 'OVERLAY', cfg.font, 31, cfg.fontflag, 1, 1, 1, 'LEFT')
        htext:SetPoint('LEFT', self.Health, 'LEFT', 1, 0)
        self:Tag(htext, '[unit:HPpercent]')

        local htextsub = cFontString(self.Health, 'OVERLAY', cfg.font, cfg.fontsize, cfg.fontflag, 1, 1, 1, 'RIGHT')
        htextsub:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', 1, 1)
        self:Tag(htextsub, '[unit:HPcurrent]')

        local RaidI = self.Health:CreateTexture(nil, "OVERLAY")
		RaidI:SetSize(20, 20)
		RaidI:SetAlpha(0.9)
		RaidI:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
		self.RaidIcon = RaidI
    end,

    focus = function(self, ...)

    end,

    pet = function(self, ...)
    	Shared(self, ...)
    	self.unit = 'pet'
		self:SetSize((cfg.mainUF.targetWidth-5)/2, 3)

		self.Health.colorClass = false
    	self.Health.colorReaction = false
		self.Health.colorHealth = true
		self.Health.colorSmooth = true
    end,

	targettarget = function(self, ...)
		Shared(self, ...)
		self.unit = 'targettarget'		

		self:SetSize((cfg.mainUF.targetWidth-5)/2, cfg.mainUF.targetHeight/2)	
		self.Health:SetHeight(cfg.mainUF.targetHeight / 2)
		self.Health:SetReverseFill(true)

		local name = cFontString(self.Health, 'OVERLAY', cfg.stdfont, 11, cfg.stdfontflag, 1, 1, 1, 'LEFT')
        name:SetPoint('LEFT', self.Health, 'RIGHT', 4, 1)        
		self:Tag(name, '[color][name]')

        local htext = cFontString(self.Health, 'OVERLAY', cfg.font, 11, cfg.fontflag, 1, 1, 1, 'RIGHT')
        htext:SetPoint('RIGHT', self.Health, 'RIGHT', 1, 1)        
        self:Tag(htext, '[unit:HPpercent]')

		local RaidI = self.Health:CreateTexture(nil, "OVERLAY")
		RaidI:SetSize(12, 12)
		RaidI:SetAlpha(0.9)
		RaidI:SetPoint("LEFT", self.Health, "LEFT", 2, 0)
		self.RaidIcon = RaidI
    end,	
}
UnitSpecific.focustarget = UnitSpecific.targettarget

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
    spawnHelper(self, 'focus', 'BOTTOM', 'oUF_CombaUITarget', 'TOP', 0, 33)
    spawnHelper(self, 'focustarget', 'TOPLEFT', 'oUF_CombaUIFocus','TOPRIGHT', 6, 0)
    spawnHelper(self, 'pet', 'BOTTOM', 'oUF_CombaUIPlayer', 'TOP', 0, 3)
end)