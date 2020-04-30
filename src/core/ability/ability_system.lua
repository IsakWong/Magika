local AbilityType = require("core.ability.ability_type")

---@class AbilitySystem
---@field abilityTypes AbilityType[]
---@field spellEffectTrigger Trigger
---@type AbilitySystem
local AbilitySystem = {}

function AbilitySystem:init()
    self.spellEffectTrigger:addCondition(function()
        for k,v in pairs(self.abilityTypes) do
            if Event:getSpellAbilityId() == v:getUd() then
                return true
            end
        end
    end)    
    self.spellEffectTrigger:addAction(function()
        self:dispatchEvent(Event:getSpellAbilityId(),UnitEvent.SpellEffect)
    end)
end

function AbilitySystem:registerAbility(typeName)
    local obj = AbilityType:create(typeName)
    self.abilityTypes[typeName] = obj
end

function AbilitySystem:registerUnit(unit)
    self.spellEffectTrigger:registerUnitEvent(unit,UnitEvent.SpellEffect)
end

function AbilityType:dispatchEvent(id,event)
    local name = ToStr(id)
    local abilityType = self.abilityTypes[name]
    if abilityType == nil then
        return
    end
    if(event == UnitEvent.SpellEffect) then
        abilityType:spellEffect(id)
        return
    end
    
end