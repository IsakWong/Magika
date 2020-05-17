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

---@param unit2 Unit
function Unit:radBetweenUnits(unit2)
    local x1 = self:getX()
    local y1 = self:getY()
    local x2 = unit2:getX()
    local y2 = unit2:getY()
    local deltaX = x2 - x1;
    local deltaY = y2 - y1;
    return math.atan(deltaY,deltaX)
end

---@param unit2 Unit
function Unit:radBetweenPoint(x2,y2)
    local x1 = self:getX()
    local y1 = self:getY()
    local deltaX = x2 - x1;
    local deltaY = y2 - y1;
    return math.atan(deltaY,deltaX)
end
