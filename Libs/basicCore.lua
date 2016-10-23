local name, ns = ...
local cfg = ns.cfg

local backdrop = {
    bgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
    insets = {top = -5, left = -5, bottom = -5, right = -5},
}

-- Frame Backdrop -----------------------------------------------------------------------
function fBackDrop(parent, anchor) 
    local f = CreateFrame('Frame', nil, parent)
    f:SetFrameLevel(parent:GetFrameLevel()-1 or 0)
    f:SetPoint('TOPLEFT', anchor, 'TOPLEFT', -3, 3)
    f:SetPoint('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', 3, -3)
    f:SetBackdrop({
        edgeFile = cfg.glow, edgeSize = 3,
        bgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
        insets = { left = 3, right = 3, top = 3, bottom = 3 } })
    f:SetBackdropColor(0, 0, 0)
    f:SetBackdropBorderColor(0, 0, 0)
    return f
end

-- Statusbar Texture --------------------------------------------------------------------
function cStatusbar(parent, texture, layer, width, height, r, g, b, alpha)
    local sb = CreateFrame('StatusBar', nil, parent)
    sb:SetParent(parent)
    if width then sb:SetWidth(width) end
    if height then sb:SetHeight(height) end
    sb:SetStatusBarTexture(texture, layer)
    sb:SetStatusBarColor(r, g, b, alpha)
    return sb
end

-- Font String --------------------------------------------------------------------------
function cFontString(parent, layer, font, fontsize, fontflag, r, g, b, justify)
    local fs = parent:CreateFontString(nil, layer)
    fs:SetFont(font, fontsize, fontflag)
    fs:SetShadowOffset(cfg.shadowoffsetX, cfg.shadowoffsetY)
    fs:SetTextColor(r, g, b)
    if justify then fs:SetJustifyH(justify) end
    return fs
end

-- Highlight On/Off ---------------------------------------------------------------------
function OnEnterHL(self)
    UnitFrame_OnEnter(self)
    self.Highlight:Show()
end

function OnLeaveHL(self)
    UnitFrame_OnLeave(self)
    self.Highlight:Hide()
end

-- Health / Power -----------------------------------------------------------------------
local PostUpdateHealth = function(health, unit)
    if UnitIsDead(unit) then
        health:SetValue(0)
    elseif UnitIsGhost(unit) then
        health:SetValue(0)
    elseif not UnitIsConnected(unit) then
        health:SetValue(0)
    end
end

function Health(self)
    local h = cStatusbar(self, cfg.texture, nil, nil, nil, 1, 1, 1, 1)
    h:SetPoint('TOP')
    h:SetPoint('LEFT')
    h:SetPoint('RIGHT')

    local hbg = h:CreateTexture(nil, 'BACKGROUND')
    hbg:SetAllPoints(h)
    hbg:SetTexture(cfg.texture)
    hbg.multiplier = 0.4

    local hl = h:CreateTexture(nil, 'OVERLAY')
    hl:SetAllPoints(h)
    hl:SetTexture('Interface\\Buttons\\WHITE8x8')
    hl:SetVertexColor(1, 1, 1, 0.05)
    hl:SetBlendMode('ADD')
    hl:Hide()

    h.Smooth = true
    h.colorClass = true
    h.colorReaction = true
    h.frequentUpdates = false

    self.Health = h
    self.Health.bg = hbg
    self.Health.PostUpdate = PostUpdateHealth
    self.Highlight = hl
end

function Power(self)
    local p = cStatusbar(self, cfg.texture, nil, nil, nil, 1, 1, 1, 1)
    p:SetPoint('LEFT')
    p:SetPoint('RIGHT')
    p:SetPoint('TOP', self.Health, 'BOTTOM', 0, -1)

    local pbg = p:CreateTexture(nil, 'BACKGROUND')
    pbg:SetAllPoints(p)
    pbg:SetTexture(cfg.texture)
    pbg.multiplier = 0.4

    p.Smooth = true
    p.colorPower = true
    
    if unit == 'player' and powerType ~= 0 then p.frequentUpdates = true end
     
    self.Power = p
    self.Power.bg = pbg
end

-- Current Target/Focus -----------------------------------------------------------------
function ctfBorder(self)
    local ctBorder = CreateFrame('Frame', nil, self)
    ctBorder:SetPoint('TOPLEFT', self, 'TOPLEFT')
    ctBorder:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT')
    ctBorder:SetBackdrop(backdrop)
    ctBorder:SetBackdropColor(0.8, 0.8, 0.8, 1)
    ctBorder:SetFrameLevel(1)
    ctBorder:Hide()

    local cfBorder = CreateFrame('Frame', nil, self)
    cfBorder:SetPoint('TOPLEFT', self, 'TOPLEFT')
    cfBorder:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT')
    cfBorder:SetBackdrop(backdrop)
    cfBorder:SetBackdropColor(0.6, 0.8, 0, 1)
    cfBorder:SetFrameLevel(1)
    cfBorder:Hide()

    self.TargetBorder = ctBorder
    self.FocusBorder = cfBorder
end

function CurrentTarget(self)
    if UnitIsUnit('target', self.unit) then
        self.TargetBorder:Show()
    else
        self.TargetBorder:Hide()
    end
end

function CurrentFocus(self)
    if UnitIsUnit('focus', self.unit) then
        self.FocusBorder:Show()
    else
        self.FocusBorder:Hide()
    end
end

-- Current Target/Focus -----------------------------------------------------------------
local GetTime = GetTime
local floor, fmod = floor, math.fmod
local day, hour, minute = 86400, 3600, 60
FormatTime = function(s)
    if s >= day then
        return format('%dd', floor(s/day + 0.5))
    elseif s >= hour then
        return format('%dh', floor(s/hour + 0.5))
    elseif s >= minute then
        return format('%dm', floor(s/minute + 0.5))
    end
    return format('%d', fmod(s, minute))
end

CreateAuraTimer = function(self,elapsed)
    self.elapsed = (self.elapsed or 0) + elapsed
    if self.elapsed >= 0.1 then
        self.timeLeft = self.expires - GetTime()
        if self.timeLeft > 0 then
            local time = FormatTime(self.timeLeft)
                self.remaining:SetText(time)
            if self.timeLeft < 6 then
                self.remaining:SetTextColor(0.69, 0.31, 0.31)
            elseif self.timeLeft < 60 then
                self.remaining:SetTextColor(1, 0.85, 0)
            else
                self.remaining:SetTextColor(1, 1, 1)
            end
        else
            self.remaining:Hide()
            self:SetScript('OnUpdate', nil)
        end
        self.elapsed = 0
    end
end

auraIcon = function(auras, button)
    local c = button.count
    c:ClearAllPoints()
    c:SetPoint('BOTTOMRIGHT', 3, -1)
    c:SetFontObject(nil)
    c:SetFont(cfg.aura.font, cfg.aura.fontsize, cfg.aura.fontflag)
    c:SetTextColor(1, 1, 1) 
    
    auras.disableCooldown = cfg.aura.disableCooldown    
    auras.showDebuffType = true
    
    button.overlay:SetTexture(nil)
    button.icon:SetTexCoord(.1, .9, .1, .9)
    button:SetBackdrop(backdrop)
    button:SetBackdropColor(0, 0, 0, 1)
    
    button.glow = CreateFrame('Frame', nil, button)
    button.glow:SetPoint('TOPLEFT', button, 'TOPLEFT', -4, 4)
    button.glow:SetPoint('BOTTOMRIGHT', button, 'BOTTOMRIGHT', 4, -4)
    button.glow:SetFrameLevel(button:GetFrameLevel()-1)
    button.glow:SetBackdrop({bgFile = '', edgeFile = cfg.glow, edgeSize = 5,
    insets = {left = 3,right = 3,top = 3,bottom = 3,},
    })
    
    local remaining = cFontString(button, 'OVERLAY', cfg.aura.font, cfg.aura.fontsize, cfg.aura.fontflag, 1, 1, 1)
    remaining:SetPoint('TOPLEFT')
    button.remaining = remaining
end

PostUpdateIcon = function(icons, unit, icon, index, offset)
    local name, _, _, _, dtype, duration, expirationTime, unitCaster = UnitAura(unit, index, icon.filter)
    local texture = icon.icon
    if icon.isPlayer or UnitIsFriend('player', unit) or not icon.isDebuff then
        texture:SetDesaturated(false)
    else
        texture:SetDesaturated(true)
    end
    if duration and duration > 0 then
        icon.remaining:Show()
    else
        icon.remaining:Hide()
    end
    
    local r,g,b = icon.overlay:GetVertexColor()
    if icon.isDebuff then
        icon.glow:SetBackdropBorderColor(r, g, b, 1)
    else 
        icon.glow:SetBackdropBorderColor(0, 0, 0, 1)
    end 
    
    icon.duration = duration
    icon.expires = expirationTime
    icon:SetScript('OnUpdate', CreateAuraTimer)
end

CustomFilter = function(icons, ...)
    local _, icon, name, _, _, _, _, _, _, caster = ...
    local isPlayer
    if (caster == 'player' or caster == 'vechicle') then
        isPlayer = true
    end
    if((icons.onlyShowPlayer and isPlayer) or (not icons.onlyShowPlayer and name)) then
        icon.isPlayer = isPlayer
        icon.owner = caster
        return true
    end
end

AWIcon = function(AWatch, icon, spellID, name, self)          
    local count = cFontString(icon, 'OVERLAY', cfg.aura.font, cfg.aura.fontsize, cfg.aura.fontflag, 1, 1, 1)
    count:SetPoint('BOTTOMRIGHT', icon, 5, -5)
    icon.count = count
    icon.cd:SetReverse(true)
end

createAuraWatch = function(self, unit)
    if cfg.aw.enable and cfg.spellIDs[class] then
        local auras = CreateFrame('Frame', nil, self)
        auras:SetAllPoints(self.Health)
        auras.onlyShowPresent = cfg.aw.onlyShowPresent
        auras.anyUnit = cfg.aw.anyUnit
        auras.icons = {}
        auras.PostCreateIcon = AWIcon
        
        for i, v in pairs(cfg.spellIDs[class]) do
            local icon = CreateFrame('Frame', nil, auras)
            icon.spellID = v[1]
            icon:SetSize(6, 6)
            if v[3] then
                icon:SetPoint(v[3])
            else
                icon:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMLEFT', 7 * i, 0)
            end
            icon:SetBackdrop(backdrop)
            icon:SetBackdropColor(0, 0, 0, 1)
            
            local tex = icon:CreateTexture(nil, 'ARTWORK')
            tex:SetAllPoints(icon)
            tex:SetTexCoord(.1, .9, .1, .9)
            tex:SetTexture(cfg.texture)
            tex:SetVertexColor(unpack(v[2]))
            icon.icon = tex
        
            auras.icons[v[1]] = icon
        end
        self.AuraWatch = auras
    end
end

Healcomm = function(self) 
    local myBar = cStatusbar(self.Health, cfg.texture, nil, self:GetWidth(), nil, 0.33, 0.59, 0.33, 0.6)
    myBar:SetPoint('TOP')
    myBar:SetPoint('BOTTOM')
    myBar:SetPoint('LEFT', self.Health:GetStatusBarTexture(), 'RIGHT')
       
    local otherBar = cStatusbar(self.Health, cfg.texture, nil, self:GetWidth(), nil, 0.33, 0.59, 0.33, 0.6)
    otherBar:SetPoint('TOP')
    otherBar:SetPoint('BOTTOM')
    otherBar:SetPoint('LEFT', self.Health:GetStatusBarTexture(), 'RIGHT')

    local absorbBar = cStatusbar(self.Health, cfg.texture, nil, self:GetWidth(), nil, 0.33, 0.59, 0.33, 0.6)
    absorbBar:SetPoint('TOP')
    absorbBar:SetPoint('BOTTOM')
    absorbBar:SetPoint('LEFT', self.Health:GetStatusBarTexture(), 'RIGHT')
    
    local healAbsorbBar = cStatusbar(self.Health, cfg.texture, nil, self:GetWidth(), nil, 0.33, 0.59, 0.33, 0.6)
    healAbsorbBar:SetPoint('TOP')
    healAbsorbBar:SetPoint('BOTTOM')
    healAbsorbBar:SetPoint('LEFT', self.Health:GetStatusBarTexture(), 'RIGHT')
   
    self.HealPrediction = {
        myBar = myBar,
        otherBar = otherBar,
        absorbBar = absorbBar,
        healAbsorbBar = healAbsorbBar,
        maxOverflow = 1,
        frequentUpdates = true,
   }
end

AuraTracker = function(self)
    self.PortraitTimer = CreateFrame('Frame', nil, self.Health)
    self.PortraitTimer.Icon = self.PortraitTimer:CreateTexture(nil, 'BACKGROUND')
    self.PortraitTimer.Icon:SetSize(32, 32)
    self.PortraitTimer.Icon:SetPoint("CENTER", self.Health, "CENTER", 0, -1)

    self.PortraitTimer.Remaining = self.PortraitTimer:CreateFontString(nil, 'OVERLAY')
    self.PortraitTimer.Remaining:SetPoint('BOTTOM', self.PortraitTimer.Icon)
    self.PortraitTimer.Remaining:SetFont(cfg.font, 15, 'THINOUTLINE')
    self.PortraitTimer.Remaining:SetTextColor(1, 1, 1)
end

ph = function(self) 
    local ph = CreateFrame('Frame', nil, self.Health)
    ph:SetFrameLevel(self.Health:GetFrameLevel()+1)
    ph:SetSize(10, 10)
    ph:SetPoint('CENTER', 0,-3)
    ph:SetAlpha(0.2)
    ph.text = cFontString(ph, 'OVERLAY', cfg.symbol, 18, '', 1, 0, 1)
    ph.text:SetShadowOffset(1, -1)
    ph.text:SetPoint('CENTER')
    ph.text:SetText('M')
    self.PhaseIcon = ph
end