local AbilityType = require("core.ability.ability_type")



local SelectObjectAbility = MKCore.AbilitySys:registerAbility('A007')

local State = {}

State.Up = 1
State.FloatingUp = 2
State.FloatingDown = 3

SelectObjectAbility.onSpellEffect = function(event)

    local group = Group:create()
    group:enumEnemyUnits(event.owningPlayer,event.spellTargetX,event.spellTargetY,150)
    ---@type Unit
    local select = nil
    
    group:forEach(function(unit)
        if select == nil then
            select = unit
            event.triggerUnit.selectObject = select
            select.state = State.Up
        end        
    end)
    event.triggerUnit:disableAbility(FourCC('A007'),false,true)
    event.triggerUnit:disableAbility(FourCC('A008'),true,false)
    local t = Timer:create()
    local t2 = Timer:create()
    local height = 0
    select.physicsState.ignoreGravity = true
    t:start(0.03,function()
        height = select:getFlyHeight()
        if select.state == nil then
            t:delete()
            select.physicsState.ignoreGravity = false
        elseif select.state == State.FloatingUp then
            if height > 150  then
                select.state = State.FloatingDown
            else
                height = height + 100 * 0.03
                select:setFlyHeight(height,0)
            end
        elseif select.state == State.FloatingDown then
            if height < 90  then
                select.state = State.FloatingUp
            else
                height = height - 100 * 0.03
                select:setFlyHeight(height,0)
            end
        elseif select.state == State.Up then
            if height > 120 or select.throwing == true then
                select.state = State.FloatingUp
            else
                height = height + 360 * 0.03
                select:setFlyHeight(height,0)
            end        
        end       
    end)

    
end



local ThrowObjectAbility = MKCore.AbilitySys:registerAbility('A008')
ThrowObjectAbility.onSpellEffect = function(event)

    ---@type Unit
    local select = event.triggerUnit.selectObject
    event.triggerUnit:disableAbility(FourCC('A008'),false,true)
    event.triggerUnit:disableAbility(FourCC('A007'),true,false)
    if select == nil then
        return
    end
    select.physicsState.ignoreGravity = false
    select.state = nil
    local rad = select:radBetweenPoint(event.spellTargetX,event.spellTargetY)
    select:addForce(800*math.cos(rad),800*math.sin(rad),0)
  
end
