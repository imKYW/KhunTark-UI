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
    --[2825]   = 4, -- Bloodlust (shaman H)
    --[32182]  = 4, -- Heroism (shaman A)
    --[80353]  = 4, -- Time Warp (mage)
    --[90355]  = 4, -- Ancient Hysteria (core hound)
    --[160452] = 4, -- Netherwinds (nether ray)
    --[146555] = 4, -- Drum of Rage (item)
    --[178207] = 4, -- Drum of Fury (item)
    --[230935] = 4, -- Drum of Mountin (item)
    --[229206] = 4, -- [POT] 지속힘
    --[273842] = 4, -- [Azerite] 심연의 비밀 : 흰색
    --[273843] = 4, -- [Azerite] 심연의 비밀 : 검은색
    --[273992] = 4, -- [ITEM] 잔달라의 문장
    --[274430] = 4, -- [ITEM] 쉴 틈 없이 똑딱거리는 시계 : 가속
    --[274431] = 4, -- [ITEM] 쉴 틈 없이 똑딱거리는 시계 : 특화
}

local Auras_Proc = {
    --[1022]   = 4, -- Hand of Protection
    --[33206]  = 4, -- Pain Suppression
    --[102342] = 4, -- Ironbark
}

local NameplateBuffs = {
    -- Offensive Buffs
    [1719]   = 4, -- [Warrior] Battle Cry
    [107574] = 4, -- [Warrior] Avatar
    [12292]  = 4, -- [Warrior] Bloodbath
    [31884]  = 4, -- [Paladin] Avenging Wrath (Retribution)
    [19574]  = 4, -- [Hunter] Bestial Wrath
    [186289] = 4, -- [Hunter] Aspect of the Eagle
    [193526] = 4, -- [Hunter] Trueshot
    [13750]  = 4, -- [Rogue] Adrenaline Rush
    [51690]  = 4, -- [Rogue] Killing Spree
    [121471] = 4, -- [Rogue] Shadow Blades
    [10060]  = 4, -- [Priest] Power Infusion
    [194249] = 4, -- [Priest] Voidform
    [51271]  = 4, -- [DK] Pillar of Frost
    [152279] = 4, -- [DK] Breath of Sindragosa
    [2825]   = 4, -- [Shaman] Bloodlust
    [32182]  = 4, -- [Shaman] Heroism
    [16166]  = 4, -- [Shaman] Elemental Mastery
    [114050] = 4, -- [Shaman] Ascendance (Elemental)
    [114051] = 4, -- [Shaman] Ascendance (Enhancement)
    [204361] = 4, -- [Shaman] Bloodlust (Honor Talent)
    [204362] = 4, -- [Shaman] Heroism (Honor Talent)
    [204945] = 4, -- [Shaman] Doom Winds
    [12042]  = 4, -- [Mage] Arcane Power
    [12472]  = 4, -- [Mage] Icy Veins
    [190319] = 4, -- [Mage] Combustion
    [198144] = 4, -- [Mage] Ice Form
    [196098] = 4, -- [Warlock] Soul Harvest
    [137639] = 4, -- [Monk] Storm, Earth, and Fire
    [152173] = 4, -- [Monk] Serenity
    [102543] = 4, -- [Duruid] Incarnation: King of the Jungle
    [102560] = 4, -- [Duruid] Incarnation: Chosen of Elune
    [106951] = 4, -- [Duruid] Berserk
    [194223] = 4, -- [Duruid] Celestial Alignment
    [162264] = 4, -- [DH] Metamorphosis
    [211048] = 4, -- [DH] Chaos Blades
}

local NameplateDebuffs = {
    -- Offensive Buffs
}

-- DeathKnight ----------------------------------------------------------------------------------------
if playerClass == "DEATHKNIGHT" then
    ActivityAuras[53365]    = 2 -- 마부 : 타락한 성전사
    Auras_Proc[48265]    = 2 -- 죽음의 진군
    Auras_Proc[48707]    = 2 -- 대마보
    Auras_Proc[48792]    = 2 -- 얼인
    Auras_Proc[212552]   = 2 -- 망령 걸음

    ActivityAuras[188290]   = 2 -- [B] 죽음과 부패

    ActivityAuras[51124]    = 2 -- [F] 도살기
    ActivityAuras[59052]    = 2 -- [F] 단단한 얼음
    ActivityAuras[281209]   = 2 -- [F] 차가운 마음
    Auras_Proc[51271]    = 2 -- [F] 얼음 기둥
    Auras_Proc[101568]   = 2 -- [F] 어둠의 원조
    Auras_Proc[196770]   = 2 -- [F] 냉혹한 겨울

    -- Test
    Auras_Proc[345464]    = 2 -- 얼인
    Auras_Proc[227723]    = 2 -- 얼인
    Auras_Proc[55233]    = 2 -- 얼인
    Auras_Proc[194679]    = 2 -- 얼인
end

-- Monk -------------------------------------------------------------------------------------------
if playerClass == "MONK" then
    --Auras_Proc[119085]   = 2 -- [BM/WW/MW] Chi Torpedo / 기공탄
    --Auras_Proc[116841]   = 2 -- [BM/WW/MW] Tiger's Lust / 범의 욕망
    --Auras_Proc[122278]   = 2 -- [BM/WW/MW] Dampen Harm / 해악 감퇴
    --Auras_Proc[116847]   = 2 -- [BM/WW] 비취 돌풍

    --ActivityAuras[195630]   = 2 -- [BM] 교묘한 투사
    --Auras_Proc[115176]   = 2 -- [BM] 명상
    --Auras_Proc[120954]   = 2 -- [BM] 강화주
    --Auras_Proc[124275]   = 2 -- [BM] 작은 시간차
    --Auras_Proc[124274]   = 2 -- [BM] 중간 시간차
    --Auras_Proc[124273]   = 2 -- [BM] 큰 시간차
    --Auras_Proc[215479]   = 2 -- [BM] 무쇠 가죽주

    --ActivityAuras[116768]   = 2 -- [WW] Blackout Kick! / 후려차기!
    ActivityAuras[195321]   = 2 -- [WW] Transfer the Power / 힘전달
    --ActivityAuras[196741]   = 2 -- [WW] Hit Combo / 연계타격
    Auras_Proc[122783]   = 2 -- [WW] Diffuse Magic / 마법 해소
    --Auras_Proc[125174]   = 2 -- [WW] Touch of Karma / 업보의 손아귀
    --Auras_Proc[137639]   = 2 -- [WW] Storm, Earth, and Fire / 폭대불
    Auras_Proc[152173]   = 2 -- [WW] Serenity / 평온
    Auras_Proc[195381]   = 2 -- [WW] Healing Winds / 치유의 바람

    NameplateDebuffs[116095] = 2 -- [Monk] 결박
    NameplateDebuffs[116706] = 2 -- [Monk] 결박 이불
    NameplateDebuffs[325216] = 2 -- [Monk] 골분주
end

-- Hunter -----------------------------------------------------------------------------------------
if playerClass == "HUNTER" then
    --Auras_Proc[186257]   = 2 -- 치타의 상 90%
    --Auras_Proc[186258]   = 2 -- 치타의 상 30%
    --Auras_Proc[118922]   = 2 -- [T3/1] 급가속
    --ActivityAuras[120694]   = 4 -- [BM] 광포한 야수
    --ActivityAuras[246252]   = 4 -- [BM T2/2] 광포한 격노
    --ActivityAuras[19574]    = 2 -- [BM] 야격
    --ActivityAuras[193530]   = 2 -- [BM] 야생의 상
    --ActivityAuras[195222]   = 4 -- [BM] 폭풍채찍(WEAPON)
    --ActivityAuras[248085]   = 4 -- [BM] 뱀의 혓바닥(LEG)
    --Auras_Proc[186265]   = 2 -- [BM] 거북의 상
end

-- Warrior ----------------------------------------------------------------------------------------
if playerClass == "WARRIOR" then
    Auras_Proc[ 18499]   = 2 -- 광전사의 격노
    Auras_Proc[190456]   = 2 -- 고통 감내
    Auras_Proc[  7384]   = 2 -- [무기] 제압
    Auras_Proc[260708]   = 2 -- [무기] 휩쓸기 일격
    Auras_Proc[ 52437]   = 2 -- [무기 1/3] 급살
    Auras_Proc[197690]   = 2 -- [무기 4/3] 방어 태세



    ActivityAuras[107574]   = 2 -- [T3/3] Avatar
    ActivityAuras[1719]     = 2 -- [ARMS] Battle Cry
    ActivityAuras[227847]   = 2 -- [ARMS] Blade Storm
    ActivityAuras[188923]   = 2 -- [ARMS] Cleave
    --Auras_Proc[118038]   = 2 -- [ARMS] Die by the Sword
    ActivityAuras[60503]    = 2 -- [ARMS T1/2] Overpower
    ActivityAuras[248145]   = 2 -- [ARMS LEG] HEAD Buff

    NameplateDebuffs[1715] = 2 -- [Monk] 무력화
    NameplateDebuffs[208086] = 2 -- [Monk] 거인의 강타
    NameplateDebuffs[115804] = 2 -- [Monk] 골분주
end

if playerClass == "ROGUE" then
    --Auras_Proc[345464]    = 2 -- Berserker Rage
    --Auras_Proc[354018]    = 2 -- Berserker Rage
    --ActivityAuras[345464]    = 2 -- Berserker Rage
    --ActivityAuras[354018]    = 2 -- Berserker Rage
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
    Auras_Proc[20594]  = 4 -- Stoneform
elseif playerRace == "NightElf" then
    Auras_Proc[58984]  = 4 -- Shadowmeld
elseif playerRace == "Orc" then
    ActivityAuras[20572]  = 4 -- Blood Fury (attack power)
    ActivityAuras[33702]  = 4 -- Blood Fury (spell power)
    ActivityAuras[33697]  = 4 -- Blood Fury (attack power and spell damage)
elseif playerRace == "Troll" then
    ActivityAuras[26297]  = 4 -- Berserking
end
]]

local activityAuraList = {}
local procAuraList = {}
local nameplateDebuffList = {}
ActivityAuraList = activityAuraList
PersonalAuraList = procAuraList
NameplateDebuffList = nameplateDebuffList

UpdateAuraList = function()
    wipe(activityAuraList)
    wipe(procAuraList)
    wipe(nameplateDebuffList)
    -- Add base auras
    for ativityAura, activityFilter in pairs(ActivityAuras) do
        activityAuraList[ativityAura] = activityFilter
    end
    for personalAura, personalFilter in pairs(Auras_Proc) do
        procAuraList[personalAura] = personalFilter
    end
    for nameplateDebuff, nameplateFilter in pairs(NameplateDebuffs) do
        nameplateDebuffList[nameplateDebuff] = nameplateFilter
    end
    -- Add auras that depend on spec or PVP mode
    for i = 1, #updateFuncs do
        updateFuncs[i](activityAuraList)
    end
    for j = 1, #updateFuncs do
        updateFuncs[j](procAuraList)
    end
    for k = 1, #updateFuncs do
        updateFuncs[k](nameplateDebuffList)
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
    activity = function(self, unit, _,_,_,_,_,_,_, caster, _,_, spellID)
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
    proc = function(self, unit, iconFrame, name, icon, count, debuffType, duration, expirationTime, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, isCastByPlayer, value1, value2, value3)
        -- print("CustomAuraFilter", self.__owner:GetName(), "[unit]", unit, "[caster]", caster, "[name]", name, "[id]", spellID, "[filter]", v, caster == "vehicle")
        local v = procAuraList[spellID]
        if v and filters[v] then
            return filters[v](self, unit, caster)
        elseif v then
            return v > 0
        else
            return caster and UnitIsUnit(caster, "vehicle")
        end
    end,
    nameplateDebuff = function(self, unit, iconFrame, name, icon, count, debuffType, duration, expirationTime, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, isCastByPlayer, value1, value2, value3)
        -- print("CustomAuraFilter", self.__owner:GetName(), "[unit]", unit, "[caster]", caster, "[name]", name, "[id]", spellID, "[filter]", v, caster == "vehicle")
        local v = nameplateDebuffList[spellID]
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
