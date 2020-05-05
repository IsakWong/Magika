local PhysicsState = require('core.physics.physics_state')

---@class UnitBaseType
---@field defaultPhysics PhysicsState
---@field canSelect boolean
---@field onBlockOther fun(unit:Unit,other:Unit):void
---@field onOverlapOther fun(unit:Unit,other:Unit):void
---
---@type UnitType
local UnitBaseType = class('UnitBaseType',Agent)

function UnitBaseType:create(typeName)
    local type = UnitBaseType:fromUd(FourCC(typeName))
    type.defaultPhysics = PhysicsState:new()
    type.canSelect = true
    return type
end

UnitBaseType.onBlockOther = function(unit,other)
    
end

UnitBaseType.onOverlapOther = function(unit,other)
    
end

return UnitBaseType