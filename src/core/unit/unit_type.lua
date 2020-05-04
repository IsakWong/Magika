local PhysicsState = require('core.physics.physics_state')

---@class UnitBaseType
---@field defaultPhysics PhysicsState
---@field canSelect boolean
---@field onBlockOther fun(unit:UnitBase,other:UnitBase):void
---@field onOverlapOther fun(unit:UnitBase,other:UnitBase):void
---
---@type UnitBaseType
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