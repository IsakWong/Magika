require('core.unit.unit_base')
local UnitType = require('core.unit.unit_type')

---@class UnitSystem
---@field

---@type UnitSystem
local UnitSystem = {}


function UnitSystem:init()
    self.unitTypes = {}

end

---@return UnitType
function UnitSystem:registerUnitType(typeName)
    local id = FourCC(typeName)
    local key = ToStr(id)
    local type = UnitType:create(typeName)
    self.unitTypes[key] = type
    return type
end


---@param unitType UnitType
---@return UnitBase
function UnitSystem:createUnit(unitType,player,x,y,angle)

    local rect = Rect:fromUd(gg_rct_RebornRect)    
    local unit = UnitBase:fromUd(Native.CreateUnit(getUd(player), getUd(unitType), x, y, angle))
    
    MKCore.AbilitySys:registerUnit(unit)
    return unit
end

return UnitSystem