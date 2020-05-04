local PhysicsSystem = require('core.physics.physics_system')
local AbilitySystem = require('core.ability.ability_system')
local UnitSystem = require('core.unit.unit_system')

require('core.unit.unit_base')
require('core.unit.unit_ext')

---@class MKCore
---@field UserPlayers Force
---@field MapRect Rect
---@field PhySys PhysicsSystem
---@field AbilitySys AbilitySystem
---

---@type MKCore
---
MKCore = {}
_G.MKCore = MKCore

function MKCore:boot()
    self.MapRect = Rect:fromUd(GetEntireMapRect())
    self.UserPlayers = Force:create()
    self.UserPlayers:enumPlayers(function(player)
        return player:getController() == MapControl.User
    end)
    self.UnitSys = UnitSystem:new()
    self.AbilitySys = AbilitySystem:new()
    self.PhySys = PhysicsSystem:new()
    require('biz.doodads.tree')
    require('biz.hero.hero')
    self.UnitSys:init()
    self.AbilitySys:init()    
    self.PhySys:init()
end
