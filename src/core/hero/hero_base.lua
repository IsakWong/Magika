require('lib.init')

---@class UnitBase : Unit
---@field heroType HeroType
---@field faithType FaithType
---@field owner Player
---
---
---@type UnitBase
local UnitBase = class('UnitBase',Unit)

_HeroEnterMapTrigger = Trigger:create()

function UnitBase:constructor(ud)

end

---@param player Player
---@param type HeroType
function UnitBase:createUnit(type,player)
    local rect = Rect:fromUd(gg_rct_RebornRect)    
    local hero = UnitBase:fromUd(Native.CreateUnit(getUd(player), type.id, rect:getCenterX(), rect:getCenterY(), 0))
    _Triggers.SpellEffectTrigger:registerUnitEvent(hero,UnitEvent.SpellEffect)
    _Triggers.TaskAcceptTrigger:registerUnitEvent(hero,UnitEvent.PickupItem)
    _Triggers.ChoseFaithTrigger:registerUnitEvent(hero,UnitEvent.PickupItem)
    return hero
end

return UnitBase
