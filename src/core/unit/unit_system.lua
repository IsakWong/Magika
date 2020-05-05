

local UnitBaseType = require('core.unit.unit_type')
local AbilityType = require('core.ability.ability_type')
require('core.unit.unit_base')
require('core.unit.unit_ext')

---@class UnitSystem
---@field unitTypes UnitBaseType[]

---@type UnitSystem
local UnitSystem = class("UnitSystem")


function UnitSystem:constructor()
    self.unitTypes = {}
end

function UnitSystem:init()
    local tmpGroup = Group:create()
    tmpGroup:enumUnitsInRect(MKCore.MapRect,
    function(unit)
        return true
    end
    )
    local UnitBaseType = require('core.unit.unit_type')

    tmpGroup:forEach(function(u)
        local unit = Unit:fromUd(getUd(u))
        self:registerUnit(unit)     
    end)
end

---@return UnitType
function UnitSystem:registerUnitType(typeName)
    local id = FourCC(typeName)
    local key = ToStr(id)
    local type = UnitType:create(typeName)
    self.unitTypes[key] = type
    return type
end

---@param unit Unit
function UnitSystem:registerUnit(unit)
    local UnitBaseType = require('core.unit.unit_type')
    local unitType = UnitBaseType:fromUd(unit:getTypeId())

    
    unit.unitType = unitType
    if unitType.defaultPhysics ~= nil then
        MKCore.PhySys:registerUnit(unit)
    end
    if unitType.canSelect == false then
        unit:addAbility(FourCC('Aloc'))        
        unit:setPosition(unit:getX(),unit:getY())
    end 
    if unit:isType(UnitType.Hero) then
        MKCore.AbilitySys:registerUnit(unit)
    end
end

---@param unitType UnitType
---@return Unit
function UnitSystem:createUnit(unitType,player,x,y,angle)

    local rect = Rect:fromUd(gg_rct_RebornRect)    
    ---@type Unit
    local unit = Unit:fromUd(Native.CreateUnit(getUd(player), getUd(unitType), x, y, angle))
    
    self:registerUnit(unit)
    return unit
end

return UnitSystem