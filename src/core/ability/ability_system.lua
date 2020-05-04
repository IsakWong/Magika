local AbilityType = require("core.ability.ability_type")

---@class AbilitySystem
---@field abilityTypes AbilityType[]
---@field spellEffectTrigger Trigger
---@field spellCastTrigger Trigger
---@type AbilitySystem
local AbilitySystem = class("AbilitySystem")

function AbilitySystem:constructor()
    self.spellEffectTrigger = Trigger:create()
    self.spellCastTrigger = Trigger:create()
    self.abilityTypes = {}

end

function AbilitySystem:init()
    
    self.spellEffectTrigger:addCondition(function()
        for k,v in pairs(self.abilityTypes) do
            if Event:getSpellAbilityId() == v:getUd() then
                return true
            end
        end
    self.spellCastTrigger:addCondition(function()
        for k,v in pairs(self.abilityTypes) do
            if Event:getSpellAbilityId() == v:getUd() then
                return true
            end
        end
    end)    
    end)    
    self.spellEffectTrigger:addAction(function()
        self:dispatchEvent(Event:getSpellAbilityId(),UnitEvent.SpellEffect)
    end)
    self.spellCastTrigger:addAction(function()
        self:dispatchEvent(Event:getSpellAbilityId(),UnitEvent.SpellChannel)
    end)
end

function AbilitySystem:registerAbility(typeName)
    local obj = AbilityType:create(typeName)
    self.abilityTypes[typeName] = obj
    return obj
end

function AbilitySystem:registerUnit(unit)
    self.spellEffectTrigger:registerUnitEvent(unit,UnitEvent.SpellEffect)
    self.spellCastTrigger:registerUnitEvent(unit,UnitEvent.SpellChannel)
end

function AbilitySystem:dispatchEvent(id,event)
    local name = ToStr(id)
    
    local abilityType = self.abilityTypes[name]
    if abilityType == nil then
        return
    end
    if(event == UnitEvent.SpellEffect) then
        print("SpellEffect"..name)
        abilityType:spellEffect(id)
        return
    end
    if(event == UnitEvent.SpellChannel) then
        
        print("SpellCast"..name)
        abilityType:spellCast(id)
        return
    end
    
end

return AbilitySystem