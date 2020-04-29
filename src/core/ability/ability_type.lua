require('lib.init')

require('core.utils')

_WeaponType = require('lib.stdlib.enum.weapontype')

---@type AbilityType[]
_AbilityTypes = {}

---@class AbilityType : Agent
---@field callback table
---@field onSpellEffect fun():void
---@type AbilityType
local AbilityType = class('AbilityBase',require('lib.stdlib.oop.agent'))

---@return AbilityType
function AbilityType:create(typeName)
    ---@type AbilityType
    local obj = AbilityType:fromUd(FourCC(typeName))
    _AbilityTypes[typeName] = obj
    return obj
end

---@param func function
---@param event UnitEvent
function AbilityType:addEvent(func,event)
    if self.callback == nil then
        self.callback = {}
    end
    self.callback[event] = func
    --回调
end

function AbilityType:spellEffect(id)
    local name = ToStr(id)
    print("技能释放效果" .. name)
    self.onSpellEffect()
end

function AbilityType:dispatchEvent(id,event)
    local name = ToStr(id)
    local abilityType = _AbilityTypes[name]
    if abilityType == nil then
        return
    end
    if(event == UnitEvent.SpellEffect) then
        abilityType:spellEffect(id)
    end
    
    -- local callback = ability.callback[event]
    -- if callback then
    --     callback();
    -- end
end

_Triggers.SpellEffectTrigger:addCondition(function()

    for k,v in pairs(_AbilityTypes) do
        print(v)
        if Event:getSpellAbilityId() == v:getUd() then
            return true
        end
    end
end)

_Triggers.SpellEffectTrigger:addAction(function()
    AbilityType:dispatchEvent(Event:getSpellAbilityId(),UnitEvent.SpellEffect)
end)



function AbilityType:angleBetween(x1,y1,x2,y2)
    local deltaX = x2 - x1;
    local deltaY = y2 - y1;
    return math.deg(math.atan(deltaY,deltaX))
end

---@param unit Unit
---@param location Location
function AbilityType:angleBetweenUnitAndLocation(unit,location)
    return AbilityType:angleBetween(unit:getX(),unit:getY(),location:getX(),location:getY())
end

---@param unit1 Unit
---@param unit2 Unit
function AbilityType:angleBetweenUnits(unit1,unit2)
    local x1 = unit1:getX()
    local y1 = unit1:getY()
    local x2 = unit2:getX()
    local y2 = unit2:getY()
    return AbilityType:angleBetween(x1,y1,x2,y2)
end

function AbilityType:getSpellDistance()
    local x = Event:getTriggerUnit():getX()
    local y = Event:getTriggerUnit():getY()
    local targetX = Event:getSpellTargetX()
    local targetY = Event:getSpellTargetY()
    local deltaX = targetX - x;
    local deltaY = targetY - y;
    return math.sqrt(deltaX * deltaX + deltaY * deltaY)    
end

function AbilityType:getSpellLocationAngle()    
    local x = Event:getTriggerUnit():getX()
    local y = Event:getTriggerUnit():getY()
    local targetX = Event:getSpellTargetX()
    local targetY = Event:getSpellTargetY()
    return AbilityType:angleBetween(x,y,targetX,targetY)
end



return AbilityType