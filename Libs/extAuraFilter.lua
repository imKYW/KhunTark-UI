local name, ns = ...
local oUF = ns.oUF or oUF

--[[--------------------------------------------------------------------
Values:
 1 = by anyone on anyone
 2 = by player on anyone
 3 = by anyone on friendly
 4 = by anyone on player
----------------------------------------------------------------------]]
local playerClass = select(2, UnitClass('player'))
-- local playerRace = select(2, UnitRace('player')) / But I don't used it. cuz I played gnome only
local updateFuncs = {} -- functions to call to add/remove auras

local BaseAuras = {}

local ActivityAuras = {
	[2825]   = 4, -- Bloodlust (shaman H)
	[32182]  = 4, -- Heroism (shaman A)
	[80353]  = 4, -- Time Warp (mage)
	[90355]  = 4, -- Ancient Hysteria (core hound)
	[160452]  = 4, -- Netherwinds (nether ray)
	[146555]  = 4, -- Drum of Rage (item)
	[178207]  = 4, -- Drum of Fury (item)
	[230935]  = 4, -- Drum of Mountin (item)
	[242584]  = 4, -- [WEAPON] DPS 52+ : DEX
	[243096]  = 4, -- [WEAPON] Tank 52+ : Ver
	[229206]  = 4, -- [POT] 지속힘	
	[208052]  = 4, -- [LEG] 세푸즈
	[224149]  = 4, -- [SET] 별비셋
	[214128]  = 4, -- [ITEM] 시간의 파편
	[221796]  = 4, -- [ITEM] 피굶 영웅
	[214802]  = 4, -- [ITEM] 앵거 레드(치타)
	[214807]  = 4, -- [ITEM] 앵거 그린(특화)
	[214803]  = 4, -- [ITEM] 앵거 블루(가속)
	[225726]  = 4, -- [ITEM] 매개체 화염(치타)
	[225729]  = 4, -- [ITEM] 매개체 냉기(특화)
	[225730]  = 4, -- [ITEM] 매개체 비전(가속)
}

local PersonalAuras = {
	[207472]  = 4, -- [LEG] 프라다
	[225130]  = 4, -- [ITEM] 티콘 탱 장신구
	[228399]  = 4, -- [ENH] for Tanker
	[1022]   = 4, -- Hand of Protection
	[102342] = 4, -- Ironbark
	[33206]  = 4, -- Pain Suppression
}

-- Death Knight -----------------------------------------------------------------------------------
if playerClass == "DEATHKNIGHT" then
	ActivityAuras[53365]	= 2 -- Unholy Strength <= Rune of the Fallen Crusader
	PersonalAuras[48707]	= 2 -- Anti-Magic Shell
	PersonalAuras[48792]	= 2 -- Icebound Fortitude	
	PersonalAuras[212552]	= 2 -- Wraith Walk
	PersonalAuras[101568]	= 2 -- Dark Succor
	--ActivityAuras[115989] = 2 -- [T1/3] Unholy Blight
	--ActivityAuras[96268]  = 2 -- [T3/1] Death's Advance
	--ActivityAuras[114851] = 2 -- [T4/1] Blood Charge
	--ActivityAuras[108200] = 2 -- [T6/2] Remorseless Winter
	--ActivityAuras[81141]  = 2 -- [Blood] Crimson Scourge
	--ActivityAuras[81256]  = 2 -- [Blood] Dancing Rune Weapon	
	ActivityAuras[51271]	= 2 -- [Frost] Pillar of Frost
	ActivityAuras[194879]	= 2 -- [Frost] 얼발
	ActivityAuras[196770]	= 2 -- [Frost] 냉겨
	ActivityAuras[207127]	= 2 -- [Frost] 굶주린 룬무기
	ActivityAuras[207256]	= 2 -- [Frost] 말살
	ActivityAuras[211805]	= 2 -- [Frost] 휘몰
	--ActivityAuras[51124]	= 2 -- [Frost] Killing Machine
	--ActivityAuras[152279]	= 2 -- [Frost] 신드라숨결
	PersonalAuras[207203]	= 2 -- [Frost 5/2] 보막
	ActivityAuras[49016]	= 2 -- [Unholy] Unholy Frenzy
	ActivityAuras[81340]	= 2 -- [Unholy] Sudden Doom
	ActivityAuras[188290]	= 2 -- [Unholy] Death and Decay
	ActivityAuras[215711]	= 2 -- [Unholy] Soul Reaper	
	PersonalAuras[207319]	= 2 -- [Unholy 5/2] 시체방패
	--PersonalAuras[49039]	= 2 -- [T2/1] Lichborne
	--PersonalAuras[51052]	= 2 -- [T2/2] Anti-Magic Zone
	--PersonalAuras[51460]	= 2 -- [T4/3] Runic Corruption
	--PersonalAuras[48743]	= 2 -- [T5/1] Death Pact(Debuff)
	--PersonalAuras[119975]	= 2 -- [T5/3] Conversion
	--PersonalAuras[49222]	= 2 -- [Blood] Bone Shield
	--PersonalAuras[55233]	= 2 -- [Blood] Vampiric Blood
end

-- Monk -------------------------------------------------------------------------------------------
if playerClass == "MONK" then
	ActivityAuras[116847]	= 2 -- [T6/1] Rushing Jade Wind
	PersonalAuras[119085]	= 2 -- [T2/1] Chi Torpedo
	PersonalAuras[117841]	= 2 -- [T2/2] Tiger's Lust
	PersonalAuras[122783]	= 2 -- [T5/2] Diffuse Magic
	PersonalAuras[122278]	= 2 -- [T5/3] Dampen Harm
	ActivityAuras[215479]	= 2 -- [BM] 무쇠가죽주
	ActivityAuras[228563]	= 2 -- [BM] 의식상실연계
	PersonalAuras[124275]	= 2 -- [BM] 작은 시간차
	PersonalAuras[124274]	= 2 -- [BM] 중간 시간차
	PersonalAuras[124273]	= 2 -- [BM] 큰 시간차
	--PersonalAuras[195630]	= 2 -- [BM] 교묘한 투사
	--PersonalAuras[214373]	= 2 -- [BM] 맥주수염
	ActivityAuras[116768]	= 2 -- [WW] Blackout Kick! / 후려차기!
	ActivityAuras[195321]	= 2 -- [WW] Transfer the Power / 힘전달
	ActivityAuras[196741]	= 2 -- [WW] Hit Combo / 연계타격
	ActivityAuras[137639]	= 2 -- [WW] Storm, Earth, and Fire / 폭대불
	ActivityAuras[152173]	= 2 -- [WW] Serenity / 평온
	PersonalAuras[125174]	= 2 -- [WW] Touch of Karma / 업보
	PersonalAuras[195381]	= 2 -- [WW] Healing Winds / 치유의바람
end

-- Hunter -----------------------------------------------------------------------------------------
if playerClass == "HUNTER" then
	PersonalAuras[186257]	= 2 -- 치타의 상 90%
	PersonalAuras[186258]	= 2 -- 치타의 상 30%
	PersonalAuras[118922]	= 2 -- [T3/1] 급가속
	ActivityAuras[19574]	= 2 -- [BM] 야격
	ActivityAuras[193530]	= 2 -- [BM] 야생의 상
	ActivityAuras[195222]	= 4 -- [BM] 폭풍채찍(WEAPON)
	PersonalAuras[186265]	= 2 -- [BM] 거북의 상
end

--[[ ADD Racials / But I don't used it. cuz I played gnome only
if playerRace == "Draenei" then
	ActivityAuras[59545]  = 4 -- Gift of the Naaru (death knight)
	ActivityAuras[59543]  = 4 -- Gift of the Naaru (hunter)
	ActivityAuras[59548]  = 4 -- Gift of the Naaru (mage)
	ActivityAuras[121093] = 4 -- Gift of the Naaru (monk)
	ActivityAuras[59542]  = 4 -- Gift of the Naaru (paladin)
	ActivityAuras[59544]  = 4 -- Gift of the Naaru (priest)
	ActivityAuras[59547]  = 4 -- Gift of the Naaru (shaman)
	ActivityAuras[28880]  = 4 -- Gift of the Naaru (warrior)
elseif playerRace == "Dwarf" then
	PersonalAuras[20594]  = 4 -- Stoneform
elseif playerRace == "NightElf" then
	PersonalAuras[58984]  = 4 -- Shadowmeld
elseif playerRace == "Orc" then
	ActivityAuras[20572]  = 4 -- Blood Fury (attack power)
	ActivityAuras[33702]  = 4 -- Blood Fury (spell power)
	ActivityAuras[33697]  = 4 -- Blood Fury (attack power and spell damage)
elseif playerRace == "Troll" then
	ActivityAuras[26297]  = 4 -- Berserking
end
]]

local activityAuraList = {}
local personalAuraList = {}
ActivityAuraList = activityAuraList
PersonalAuraList = personalAuraList

UpdateAuraList = function()
	wipe(activityAuraList)	
	wipe(personalAuraList)
	-- Add base auras
	for ativityAura, activityFilter in pairs(ActivityAuras) do
		activityAuraList[ativityAura] = activityFilter
	end
	for personalAura, personalFilter in pairs(PersonalAuras) do
		personalAuraList[personalAura] = personalFilter
	end
	-- Add auras that depend on spec or PVP mode
	for i = 1, #updateFuncs do
		updateFuncs[i](activityAuraList)
	end
	for j = 1, #updateFuncs do
		updateFuncs[j](personalAuraList)
	end
	-- Update all the things
	for _, obj in pairs(oUF.objects) do
		if obj.Auras then
			obj.Auras:ForceUpdate()
		end
		if obj.Buffs then
			obj.Buffs:ForceUpdate()
		end
	end
end

------------------------------------------------------------------------

local UnitIsFriend, UnitIsUnit, UnitPlayerControlled
	= UnitIsFriend, UnitIsUnit, UnitPlayerControlled

local unitIsPlayer = { player = true, pet = true, vehicle = true }

local filters = {
	[2] = function(self, unit, caster) return unitIsPlayer[caster] end,
	[3] = function(self, unit, caster) return UnitIsFriend(unit, "player") and UnitPlayerControlled(unit) end,
	[4] = function(self, unit, caster) return unit == "player" and not self.__owner.isGroupFrame end,
}

CustomAuraFilters = {
	activity = function(self, unit, iconFrame, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, isCastByPlayer, value1, value2, value3)
		-- print("CustomAuraFilter", self.__owner:GetName(), "[unit]", unit, "[caster]", caster, "[name]", name, "[id]", spellID, "[filter]", v, caster == "vehicle")
		local v = activityAuraList[spellID]
		if v and filters[v] then
			return filters[v](self, unit, caster)
		elseif v then
			return v > 0
		else
			return caster and UnitIsUnit(caster, "vehicle")
		end
	end,
	personal = function(self, unit, iconFrame, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, isCastByPlayer, value1, value2, value3)
		-- print("CustomAuraFilter", self.__owner:GetName(), "[unit]", unit, "[caster]", caster, "[name]", name, "[id]", spellID, "[filter]", v, caster == "vehicle")
		local v = personalAuraList[spellID]
		if v and filters[v] then
			return filters[v](self, unit, caster)
		elseif v then
			return v > 0
		else
			return caster and UnitIsUnit(caster, "vehicle")
		end
	end,
	--[[
	party = function(self, unit, iconFrame, name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, isCastByPlayer, value1, value2, value3)
		local v = auraList[spellID]
		return v and v < 4
	end,
	]]

	--[[
	local function CustomFilter(...)
	--icons, unit, icon, name, rank, texture, count, dispelType, duration, expiration, caster, isStealable, nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll
	local _, _, _, _, _, _, _, _, _, _, caster, _, _, _, _, _, _, nameplateShowAll = ...
	return nameplateShowAll or (caster == "player" or caster == "pet" or caster == "vehicle")
	end

	-- dummy
	CustomFilter = function(icons, ...)
	    local _, icon, name, _, _, _, _, _, _, caster = ...
	    local isPlayer
	    if (caster == 'player' or caster == 'vechicle') then
	        isPlayer = true
	    end
	    if((icons.onlyShowPlayer and isPlayer) or (not icons.onlyShowPlayer and name)) then
	        icon.isPlayer = isPlayer
	        icon.caster = caster
	        return true
	    end
	end

	]]
}

OnlyPlayerFilter = function(icons, ...)
    local _, icon, name, _, _, _, _, _, _, caster = ...
    local isPlayer
    if (caster == 'player' or caster == 'vechicle') then
        isPlayer = true
    end
    if((icons.onlyShowPlayer and isPlayer) or (not icons.onlyShowPlayer and name)) then
        icon.isPlayer = isPlayer
        icon.caster = caster
        return true
    end
end
