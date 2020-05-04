local AbilityType = require("core.ability.ability_type")


local Portal = MKCore.UnitSys:registerUnitType('e004')

Portal.defaultPhysics.phyType = PhysicsType.None
Portal.canSelect = false

local abilityType2 = MKCore.AbilitySys:registerAbility('A002')


abilityType2.onSpellEffect = function(event)

    local x = event.triggerX
    local y = event.triggerY
    local unit = event.triggerUnit
    local facing = math.rad(unit:getFacing())
    local x1 = event.triggerX + math.cos(facing) * 200
    local y1 = event.triggerY + math.sin(facing) * 200
    local x2 = event.triggerX + math.cos(facing) * 800
    local y2 = event.triggerY + math.sin(facing) * 800

    local portal1 = MKCore.UnitSys:createUnit(Portal,event.owningPlayer,x1,y1,math.deg(facing))
    portal1:setLife(1.0)
    
    portal1:setAnimation('birth')
    portal1:setTimeScale(20)
    local portal2 = MKCore.UnitSys:createUnit(Portal,event.owningPlayer,x2,y2,math.deg(facing))
    portal2:setAnimation('birth')
    portal2:setTimeScale(20)

    Timer:after(1.0,function()
        portal1:kill()
        portal2:kill()
    end)

    unit:setAnimation('Spell')
    local timer = Timer:create()
    local timer2 = Timer:create()
    local speed = 500
    timer:start(0.03,function()
        local rad = math.atan(y1 - unit:getY(),x1 - unit:getX())
        local x0 = unit:getX() + math.cos(rad) * 500 * 0.03
        local y0 = unit:getY() + math.sin(rad) * 500 * 0.03
        local dx =  x0 - x1
        local dy = y0 - y1
        local dis = math.sqrt(dx * dx + dy * dy)
        speed = math.smoothDamp(dis,200,speed,0.1,1000,0.03)
        if dis < 10 then
            timer:delete()
            unit:setX(x2)
            unit:setY(y2)
            unit:addForce(500*math.cos(facing),500*math.sin(facing),0)
            Effect:addSpecial('Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl',x1,y1):delete()
            Effect:addSpecial('Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl',x2,y2):delete()
            
            unit:setPaused(true)
            Timer:after(0.1,function()
                unit:setPaused(false)
            end)
            timer:destroy()
        else
            unit:setX(x0)
            unit:setY(y0)
        end      
    end)
    
end
