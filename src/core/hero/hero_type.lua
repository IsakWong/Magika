require('lib.init')

---@class HeroType : Agent
---@field name string
---@field description string
---@field selectCam Handle
---@field id number
local HeroType = class('HeroType',require('lib.stdlib.oop.agent'))

_HeroTypes = {}

function HeroType:create(typeName)
    local obj = HeroType:fromUd(FourCC(typeName))
    obj.id = FourCC(typeName)
    _HeroTypes[typeName] = obj
    return obj
end

return HeroType