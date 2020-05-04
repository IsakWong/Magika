local PhysicsState = require('core.physics.physics_state')

---@class PhysicsSystem
---@field instance PhysicsSystem
---@field tmpGroup Group
---@field dynamicGroup UnitBase[]
---@field staticGroup UnitBase[]

---@type PhysicsSystem
local PhysicsSystem = class('PhysicsSystem')

---@type PhysicsSystem
PhysicsSystem.instance = nil


function PhysicsSystem:constructor()
    PhysicsSystem.instance = self
    self.mainTimer = Timer:create()
    self.mainTimer:start(0.03,PhysicsSystem.MainLoop)
    self.dynamicGroup = {}
    self.staticGroup = {}
    self.tmpGroup = Group:create()
end

function PhysicsSystem:init()
  
end

function PhysicsSystem:check()
    -- body
end

---@param unit UnitBase
function PhysicsSystem:registerUnit(unit)
    local UnitBaseType = require('core.unit.unit_type')
    ---@type UnitBaseType
    local unitType = UnitBaseType:fromUd(unit:getTypeId())
    unit.physicsState = PhysicsState:new() 
    unit.physicsState.phyType = unitType.defaultPhysics.phyType
    unit.physicsState.dampX = unitType.defaultPhysics.dampX
    unit.physicsState.dampY = unitType.defaultPhysics.dampY
    unit.physicsState.dampZ = unitType.defaultPhysics.dampZ
    unit.physicsState.radius = unitType.defaultPhysics.radius
    if unit.physicsState.phyType == PhysicsType.Static then
        table.insert(self.staticGroup,unit)
    end
    if unit.physicsState.phyType == PhysicsType.Dynamic then
        table.insert(self.dynamicGroup,unit)
    end

    print(unit:getName() .. " 注册进物理系统")
 
end

function PhysicsSystem.MainLoop()
    local phy = MKCore.PhySys
    for i,unit in ipairs(phy.dynamicGroup) do
        phy:UnitLoopCallback(unit)
    end
end

---@param unit UnitBase
function PhysicsSystem:UnitLoopCallback(unit)
    if unit:isDead() then
        return
    end
    self.tmpGroup:clear()
    local phyState = unit.physicsState
    if phyState == nil then
        return 
    end
    
    local x = unit:getX()
    local y = unit:getY()
    local forecX = phyState.forceX
    local forecY = phyState.forceY
    local rad = math.atan(forecY,forecX)
    local speed = forecX * forecX  + forecY * forecY
    speed = math.sqrt(speed)
    local dX = speed * 0.03 * math.cos(rad)
    local dY = speed * 0.03 * math.sin(rad)
    local dampX = math.abs(phyState.dampX * 0.03 * math.cos(rad))
    local dampY = math.abs(phyState.dampY * 0.03 * math.sin(rad))
    local newX = x + dX
    local newY = y + dY
    self.tmpGroup:enumEnemyUnits(unit:getOwner(),newX,newY,phyState.radius)
    
    local isBlock = false
    self.tmpGroup:forEach(function(o)
        local other = UnitBase:fromUd(getUd(o))
        if unit:isAlive() then
            unit.unitType.onBlockOther(unit,other)
            other.unitType.onBlockOther(other,unit)
        end
        if unit.physicsState.colType == CollisionType.Block and other.physicsState.colType == CollisionType.Block then
            isBlock = true
            print(isBlock)
        end
    end)
    
    if not isBlock then
        unit:setX(newX)
        unit:setY(newY) 
    end

    if phyState.forceX > 0 then
        phyState.forceX = phyState.forceX - dampX
        if phyState.forceX < 0 then
            phyState.forceX = 0
        end
    end
    
    if phyState.forceX < 0 then
        phyState.forceX = phyState.forceX + dampX
        if phyState.forceX > 0 then
            phyState.forceX = 0
        end
    end
   
    if phyState.forceY > 0 then
        phyState.forceY= phyState.forceY - dampY
        if phyState.forceY < 0 then
            phyState.forceY = 0
        end
    end
    
    if phyState.forceY < 0 then
        phyState.forceY = phyState.forceY + dampY
        if phyState.forceY > 0 then
            phyState.forceY = 0
        end
    end
end

return PhysicsSystem