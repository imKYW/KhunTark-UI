local _, ns = ...
local oUF = ns.oUF or oUF

local function Update(self, event)
	local element = self.VehicleIndicator
	local isVehicle = UnitHasVehicleUI('player') --UnitInVehicle UnitHasVehicleUI

	if (element.PreUpdate) then
		element:PreUpdate()
	end

	if (isVehicle) then
		element:Show()
	else
		element:Hide()
	end

	if (element.PostUpdate) then
		return element:PostUpdate(isVehicle)
	end
end

local function Path(self, ...)
	return (self.VehicleIndicator.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate')
end

local function Enable(self, unit)
	local element = self.VehicleIndicator
	if(element and UnitIsUnit(unit, 'player')) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_ENTERED_VEHICLE', Path, true)
		self:RegisterEvent('UNIT_EXITED_VEHICLE', Path, true)

		if(element:IsObjectType('Texture') and not element:GetTexture()) then
			element:SetTexture([[Interface\ChatFrame\ChatFrameBackground]])
			element:SetTexCoord(0,0,0)
		end

		return true
	end
end

local function Disable(self)
	local element = self.VehicleIndicator
	if(element) then
		element:Hide()

		self:UnregisterEvent('UNIT_ENTERED_VEHICLE', Path)
		self:UnregisterEvent('UNIT_EXITED_VEHICLE', Path)
	end
end

oUF:AddElement('VehicleIndicator', Path, Enable, Disable)
