local AbilityType = require("core.ability.ability_type")


local Missile = MKCore.UnitSys:registerUnitType('e005')

local Explosion = MKCore.UnitSys:registerUnitType('e006')


Missile.defaultPhysics.phyType = PhysicsType.Dynamic
Missile.defaultPhysics.dampX = 900
Missile.defaultPhysics.dampY = 900
Missile.canSelect = false
Missile.defaultPhysics.radius = 100

Explosion.defaultPhysics.phyType = PhysicsType.None
Explosion.canSelect = false

Missile.onBlockOther = function(unit,other)
    if(unit:isEnemy(other:getOwner())) then
        local rad = math.rad(unit:getFacing())
        unit:kill()
        other:addForce(math.cos(rad) * 400,math.sin(rad) * 400,0)
        local explosion = MKCore.UnitSys:createUnit(Explosion,unit:getOwner(),unit:getX(),unit:getY(),0)
        Timer:after(1,function()
            explosion:kill()
        end)
    end
end

local abilityType2 = MKCore.AbilitySys:registerAbility('A006')


abilityType2.onSpellEffect = function(event)

    for i = 0,5 do
        local deg = math.rad(60 * i)
        local missile = MKCore.UnitSys:createUnit(Missile,event.owningPlayer,event.triggerX,event.triggerY,0)
        missile:addForce(math.cos(deg) * 600, math.sin(deg) * 600,0)
        Timer:after(1.5,function()
            if missile:isAlive() then
                local explosion = MKCore.UnitSys:createUnit(Explosion,event.owningPlayer,missile:getX(),missile:getY(),0)
                Timer:after(1,function()
                    explosion:kill()
                end)

                missile:kill()            
            end
            
        end)

    end  
    
end
