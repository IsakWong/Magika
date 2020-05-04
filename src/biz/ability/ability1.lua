local AbilityType = require("core.ability.ability_type")


local AbilityBarrageType = MKCore.UnitSys:registerUnitType('e002')

AbilityBarrageType.defaultPhysics.phyType = PhysicsType.Dynamic
AbilityBarrageType.canSelect = false

AbilityBarrageType.onBlockOther =  function(unit,other)
    unit:kill()
    unit:damageUnitSimple(other,5)
    if other.physicsState.phyType == PhysicsType.Dynamic then
        local x = math.cos(math.rad(unit:getFacing())) * 300
        local y = math.sin(math.rad(unit:getFacing())) * 300
        other:addForce(x,y,0)
    end
    
end

AbilityBarrageType.onOverlapOther =  function()
    
end


---@type AbilityType
local abilityType1 = MKCore.AbilitySys:registerAbility('A000','attack spell')

abilityType1.onSpellEffect = function(event)
    local x = event.triggerX
    local y = event.triggerY
    local triggerUnit = event.triggerUnit
    local player = triggerUnit:getOwner()

    local targetX = event.spellTargetX
    local targetY = event.spellTargetY

    local angle = math.deg(event.spellRad)

    local unit = MKCore.UnitSys:createUnit(AbilityBarrageType,player,x,y,angle)
    local speed = 900
    unit.physicsState.forceX = math.cos(event.spellRad) * speed
    unit.physicsState.forceY = math.sin(event.spellRad) * speed
    Timer:after(1.4,function()
        if unit:isAlive() then
            unit:kill()
        end
        
    end)
end
