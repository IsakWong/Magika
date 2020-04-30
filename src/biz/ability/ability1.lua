require("core.init")
local AbilityType = require("core.ability.ability_type")


---@type AbilityType
local abilityType1 = AbilityType:create('A000')

local AbilityBarrageType = MKCore.UnitSys:registerUnitType('e002')

AbilityBarrageType.onBlockOther =  function()
    
end

AbilityBarrageType.onOverlapOther =  function()
    
end

abilityType1.onSpellEffect = function (event)
    local x = event.triggerX
    local y = event.triggerY
    local triggerUnit = event.triggerUnit
    local player = triggerUnit:getOwner()

    local targetX = event.spellTargetX
    local targetY = event.s

    local angle = math.deg(event.spellRad)

    local unit = MKCore.UnitSys:createUnit(AbilityBarrageType,player,x,y,angle)
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
