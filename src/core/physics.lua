require("lib.init")

---@class PhysicsSystem
---@field instance PhysicsSystem

---@type PhysicsSystem
local PhysicsSystem = class('PhysicsSystem')

---@type PhysicsSystem
PhysicsSystem.instance = nil

function PhysicsSystem:init()
    PhysicsSystem.instance = self
    self.mainTimer = Timer:create()
    self.mainTimer:start(0.03,PhysicsSystem.MainLoop)
    self.unitGroup = Group:create()
end

function PhysicsSystem.MainLoop()
    local ins = PhysicsSystem.instance    
    ins.unitGroup:forEach(PhysicsSystem.UnitLoopCallback)
end

---@param unit Unit
function PhysicsSystem.UnitLoopCallback(unit)
    if unit.force == nil then
        return
    end
    
    local force = unit.force
    local x = unit:getX()
    local y = unit:getY()
    local forecX = force.x
    local forecY = force.y
    local ang = math.atan(forecY,forecX)
    local speed = forecX * forecX  + forecY * forecY
    speed = math.sqrt(speed)
    local dX = speed * 0.03 * math.cos(ang)
    local dY = speed * 0.03 * math.sin(ang)
    local damp = 600
    if force.x ~= 0 then
        unit:setX(x + dX)
    end

    if force.y ~= 0 then
        unit:setY(y + dY) 
    end
    
    if force.x > 0 then
        force.x = force.x - 0.03 * damp
        if force.x < 0 then
            force.x = 0
        end
    end
    
    if force.x < 0 then
        force.x = force.x + 0.03 * damp
        if force.x > 0 then
            force.x = 0
        end
    end
   
    if force.y > 0 then
        force.y= force.y - 0.03 * damp
        if force.y < 0 then
            force.y = 0
        end
    end
    
    if force.y < 0 then
        force.y = force.y + 0.03 * damp
        if force.y > 0 then
            force.y = 0
        end
    end
end

return PhysicsSystem