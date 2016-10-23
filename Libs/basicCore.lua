local _, ns = ...
local cfg = ns.cfg

-- Frame Backdrop -----------------------------------------------------------------------
local fBackDrop = function(parent, anchor) 
    local f = CreateFrame('Frame', nil, parent)
    f:SetFrameLevel(parent:GetFrameLevel()-1 or 0)
    f:SetPoint('TOPLEFT', anchor, 'TOPLEFT', -3, 3)
    f:SetPoint('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', 3, -3)
    f:SetBackdrop({
        edgeFile = cfg.glow, edgeSize = 3,
        bgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
        insets = {left = 3, right = 3, top = 3, bottom = 3}})
    f:SetBackdropColor(0, 0, 0)
    f:SetBackdropBorderColor(0, 0, 0)
end

-----------------------------------------------------------------------------------------

local fixStatusbar = function(bar)
    bar:GetStatusBarTexture():SetHorizTile(false)
    bar:GetStatusBarTexture():SetVertTile(false)
end

local cStatusbar = function(parent, texture, layer, height, width, r, g, b, alpha)
    local bar = CreateFrame('StatusBar', nil, parent)
    bar:SetParent(parent)
    if height then
        bar:SetHeight(height)
    end
    if width then
        bar:SetWidth(width)
    end
    bar:SetStatusBarTexture(texture, layer)
    bar:SetStatusBarColor(r, g, b, alpha)
    fixStatusbar(bar)
end

-----------------------------------------------------------------------------------------

local cFontString = function(parent, layer, font, fontsize, fontflag, r, g, b, justify)
    local string = parent:CreateFontString(nil, layer)
    string:SetFont(font, fontsize, fontflag)
    string:SetShadowOffset(cfg.shadowoffsetX, cfg.shadowoffsetY)
    string:SetTextColor(r, g, b)
    if justify then
        string:SetJustifyH(justify)
    end
end

-----------------------------------------------------------------------------------------

local hider = CreateFrame("Frame", "Hider", UIParent)
hider:Hide()