---@class Unit : Widget
---@field physicsState PhysicsState
---@field unitType UnitType
---@field owner Player
---
---


function Unit:addForce(x,y,z)
    self.physicsState.forceX = self.physicsState.forceX + x
    self.physicsState.forceY = self.physicsState.forceY + y
end
