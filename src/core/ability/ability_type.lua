
require('core.utils')

---@class AbilityType : Agent
---@field castAnim string
---@field onSpellEffect fun(event:AbilityEvent):void
---@field onSpellCast fun(event:AbilityEvent):void
---
---
---@type AbilityType
local AbilityType = class('AbilityBase',require('lib.stdlib.oop.agent'))

---@return AbilityType
function AbilityType:create(typeName)
    ---@type AbilityType
    local obj = AbilityType:fromUd(FourCC(typeName))
    return obj
end

function AbilityType:spellEffect(id)
    local name = ToStr(id)
    print("技能释放效果" .. name)
    if self.onSpellEffect ~= nil then
        self.onSpellEffect(self:prepareEvent())
    end
end

function AbilityType:spellCast(id)
    local name = ToStr(id)
    print("技能释放效果" .. name)
    local event = self:prepareEvent()
    if self.onSpellCast ~= nil then
        self.onSpellCast(event)
    end
    
end

---@class AbilityEvent
---@field owningPlayer Player
---@field triggerUnit Unit
---@field triggerX number
---@field triggerY number
---@field spellTargetX number
---@field spellTargetY number
---@field spellTarget Unit
---@field spellRad number
---
---@retun AbilityEvent
function AbilityType:prepareEvent()
    ---@type AbilityEvent
    local event = {}
    ---@type Unit
    local triggerUnit = Event:getTriggerUnit()
    event.triggerUnit = triggerUnit
    local sepllX = 0
    local sepllY = 0 
    local triggerX = triggerUnit:getX()
    local triggerY = triggerUnit:getY()    
    event.spellTarget = Event:getSpellTargetUnit()
    if event.spellTarget == nil then
        sepllX = Event:getSpellTargetX()
        sepllY =  Event:getSpellTargetY()
      
    else
        sepllX  = event.spellTarget:getX()
        sepllY = event.spellTarget:getY()
    end
    event.spellRad = math.atan(sepllY - triggerY,sepllX - triggerX)
    event.spellTargetX = sepllX
    event.spellTargetY = sepllY
    event.triggerX = triggerX
    event.triggerY = triggerY
    event.owningPlayer = triggerUnit:getOwner()

    return event
end

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