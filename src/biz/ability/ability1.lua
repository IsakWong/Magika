require("core.init")
local AbilityType = require("core.ability.ability_type")


---@type AbilityType
local abilityType1 = AbilityType:create('A000')


abilityType1.onSpellEffect = function ()
    local x = Event:getTriggerUnit():getX()
    local y = Event:getTriggerUnit():getY()
    local player = Event:getTriggerUnit():getOwner()
    local triggerUnit = Event:getTriggerUnit()

    local targetX = Event:getSpellTargetX()
    local targetY = Event:getSpellTargetY()

    local angle = AbilityType:getSpellLocationAngle()
    local unit = Unit:create(Event:getTriggerPlayer(),ToID('e002'),x,y,angle)
    local timer = Timer:create()
    local moveTimer = Timer:create()

    local distance = 1500
    local moveDistance = 0.0
    local speed = 1000;
    local height = unit:getFlyHeight()
    local g = Group:create()

    moveTimer:start(0.03,function()
        local x = unit:getX()
        local y = unit:getY()
        local newX = x + speed * 0.03 * math.cos(math.rad(angle))
        local newY = y + speed * 0.03 * math.sin(math.rad(angle))
        --unit:setFlyHeight(height * (distance - moveDistance) / distance ,9999)
        unit:setX(newX)
        unit:setY(newY)
        g:enumEnemyUnits(player,x,y,100)
        g:forEachOnce(
            function(enemy)
            unit:damageUnitSimple(enemy,100)
            moveTimer:delete()
            unit:kill()
            local rad = math.rad(unit:getFacing())            
            enemy:addForce(1000*math.cos(rad),1000*math.sin(rad),0)
        end)
        moveDistance = moveDistance + speed * 0.03
        if moveDistance > distance then
            moveTimer:delete()
            unit:kill()
        end
    end)
end
