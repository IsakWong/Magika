require("core.init")
local AbilityType = require("core.ability.ability_type")


---@type AbilityType
local abilityType2 = AbilityType:create('A002')


abilityType2.onSpellEffect = function()
    local x = Event:getTriggerUnit():getX()
    local y = Event:getTriggerUnit():getY()
    local player = Event:getTriggerUnit():getOwner()
    local targetX = Event:getSpellTargetX()
    local targetY = Event:getSpellTargetY()

    local angle = AbilityType:getSpellLocationAngle()
    for i = 0,4 do
        local unit = Unit:create(Event:getTriggerPlayer(),ToID('e001'),targetX,targetY,0)
        unit:setFlyHeight(250 * i,9999)
        unit:setLife(2)
    end

    Effect:addSpecial('Objects\\Spawnmodels\\Human\\HCancelDeath\\HCancelDeath.mdl',targetX,targetY)
end
