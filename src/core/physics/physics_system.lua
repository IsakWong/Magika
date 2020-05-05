local PhysicsState = require('core.physics.physics_state')

---@class PhysicsSystem
---@field instance PhysicsSystem
---@field tmpGroup Group
---@field dynamicGroup Unit[]
---@field staticGroup Unit[]

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

---@param unit Unit
function PhysicsSystem:registerUnit(unit)
    local UnitType = require('core.unit.unit_type')
    ---@type UnitType
    local unitType = UnitType:fromUd(unit:getTypeId())
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
        unit.collisioned = false
    end
    for i,unit in ipairs(phy.dynamicGroup) do
        phy:UnitLoopCallback(unit)
    end
end

function PhysicsSystem:UnitMove(unit)
    local x = unit:getX()
    local y = unit:getY()
  
    self.tmpGroup:enumEnemyUnits(unit:getOwner(),x,y,250)
    self.tmpGroup:forEach(function(o)
        local oX = o:getX()
        local oY = o:getY()
        local dx = oX -x 
        local dy = oY - y
        local dis = dx* dx + dy * dy 
        if dis < 250 then
            local rad = math.atan(dy,dx) + 3.14
            unit:setX( oX + 50 * math.cos(rad))
            unit:setY( oY + 50 * math.sin(rad))
        end    
    end)
    
end

function PhysicsSystem:Physical(unit)

end

function PhysicsSystem:swapForce(u1,u2)
    local tx = u1.physicsState.forecX
    local ty = u1.physicsState.forecY
    local tz = u1.physicsState.forecZ
    u1.physicsState.forecX = u2.physicsState.forecX
    u1.physicsState.forecY = u2.physicsState.forecY
    u1.physicsState.forecZ = u2.physicsState.forecZ
    u2.physicsState.forecX = tx
    u2.physicsState.forecY = ty
    u2.physicsState.forecZ = tz
end

function PhysicsSystem:moveUnit(unit)

end
---@param unit Unit
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
    
    self:UnitMove(unit)



    --- Physical
    self.tmpGroup:enumPhysicsUnit(x,y,phyState.radius + 100)
    self.tmpGroup:forEach(function(other)
        if unit.physicsState.colType == CollisionType.Block and other.physicsState.colType == CollisionType.Block then
            if other.collisioned == false then
                unit.collisioned = true
                self:swapForce(unit,other) 
            end            
        end
        if unit:isAlive() then
            unit.unitType.onBlockOther(unit,other)
            other.unitType.onBlockOther(other,unit)
        end
    end)


    --- Move
    if math.abs(phyState.forceX) > 0 or math.abs(phyState.forceY) > 0 then        
        local forecX = phyState.forceX
        local forecY = phyState.forceY
        local rad = math.atan(forecY,forecX)
        local dampX = phyState.dampX * 0.03 * math.cos(rad + 3.14)
        local dampY = phyState.dampY * 0.03 * math.sin(rad + 3.14)
        local speed = forecX * forecX  + forecY * forecY
        speed = math.sqrt(speed)
        if phyState.forceX ~= 0 then
            if phyState.forceX > 0 then
                phyState.forceX = phyState.forceX + dampX
                if phyState.forceX < 0 then
                    phyState.forceX = 0           
                end            
            else   
                phyState.forceX = phyState.forceX + dampX
                if phyState.forceX > 0 then
                    phyState.forceX = 0           
                end         
            end       
            local dX = speed * 0.03 * math.cos(rad)
            local newX = x + dX    
            unit:setX(newX)
        end
       
        if phyState.forceY ~= 0 then
            if phyState.forceY > 0 then
                phyState.forceY = phyState.forceY + dampY
                if phyState.forceY < 0 then
                    phyState.forceY = 0           
                end            
            else   
                phyState.forceY = phyState.forceY + dampY
                if phyState.forceY > 0 then
                    phyState.forceY = 0           
                end         
            end       
            local dY = speed * 0.03 * math.sin(rad)            
            local newY = y + dY
            unit:setY(newY)        
        end
    end
    
    

 
end

return PhysicsSystem