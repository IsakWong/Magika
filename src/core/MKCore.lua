local PhysicsSystem = require('core.physics.physics_system')
local AbilitySystem = require('core.ability.ability_system')
local UnitSystem = require('core.unit.unit_system')

---@class MKCore
---@field PhySys PhysicsSystem
---@field AbilitySys AbilitySystem

---@type MKCore
---
MKCore = {}

function MKCore:boot()
    self.PhySys = PhysicsSystem.new()
    self.PhySys:init()
    self.AbilitySys = AbilitySystem.new()
    self.AbilitySys:init()
    self.UnitSys = UnitSystem.new()
    self.UnitSys:init()
end
