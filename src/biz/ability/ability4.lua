local AbilityType = require("core.ability.ability_type")



local abilityType2 = MKCore.AbilitySys:registerAbility('A007')


abilityType2.onSpellEffect = function(event)

    local group = Group:create()
    group:enumEnemyUnits(event.owningPlayer,event.spellTargetX,event.spellTargetY,150)
    ---@type UnitBase
    local select = nil
    
    group:forEach(function(unit)
        if select == nil then
            select = unit
            event.triggerUnit.selectObject = select
            select.throwing = false
        end        
    end)
    local t = Timer:create()
    local t2 = Timer:create()
    local height = 0
    t:start(0.03,function()
        if select:getFlyHeight() > 300 or select.throwing == true then
            t:delete()
            height = 300
            t2:start(0.03,function()
                if select:getFlyHeight() < 10 then 
                    t2:delete()
                    select:setFlyHeight(0,9999)
                else
                    select:setFlyHeight(height,9999)
                    height = height - 500 * 0.03
                end
            end)
        else
            select:addAbility(FourCC('Arav'))
            select:setFlyHeight(height,9999)
            select:removeAbility(FourCC('Arav'))
            height = height + 500 * 0.03
            print(height)

        end        
    end)

    
end
