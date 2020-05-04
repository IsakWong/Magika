---@class UnitBase : Unit
---@field physicsState PhysicsState
---@field unitType UnitBaseType
---@field owner Player
---
---
---@type UnitBase
UnitBase = class('UnitBase',Unit)


function UnitBase:addForce(x,y,z)
    self.physicsState.forceX = self.physicsState.forceX + x
    self.physicsState.forceY = self.physicsState.forceY + y
end
