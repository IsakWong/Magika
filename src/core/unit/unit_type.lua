require('lib.init')


---@class UnitType
---@field onBlockOther fun():void
---@field onOverlapOther fun():void
---
---@type UnitType
local UnitType = class('UnitBase',Agent)

function UnitType:create(typeName)
    local type = UnitType:fromUd(FourCC(typeName))
    return type
end

UnitType.onBlockOther = function()
    
end

UnitType.onOverlapOther = function()
    
end

return UnitType