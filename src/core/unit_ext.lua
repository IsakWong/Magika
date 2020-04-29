require('lib.init')
local PhysicsSystem = require('core.physics')

function Group:enumEnemyUnits(player,x,y,radius)
    self:enumUnitsInRange(x,y,radius,function (u)
        if u:isEnemy(player) == false then
            return false;
        end
        --幻象
        if u:isType(UnitType.Structure) then
            return false
        end        
        if u:isDead() then 
            return false
        end
        return true
    end)
    return self
end

function Group:isIn(widget)
    for i = 0 , self:getSize() - 1 do
        if widget == self:unitAt(i) then
            return true
        end
    end
    return false
end

function Unit:addForce(x,y,z)
    if self.force == nil then
        self.force = {}
    end
    if PhysicsSystem.instance.unitGroup:isIn(self) then
        
    else
        PhysicsSystem.instance.unitGroup:addUnit(self)
    end
    self.force.x = x
    self.force.y = y
    self.force.z = z
end

function Group:forEachOnce(callback)
    if self.done == nil then
        self.done = Group:create()
    end
    for i = 0 , self:getSize() - 1 do
        local enum = self:unitAt(i)
        if self.done:isIn(enum) then
            return
        else
            self.done:addUnit(enum)
            callback(enum)
        end
    end
end

function Unit:damageUnitSimple(enemy,val)
    self:damageTarget(enemy, val,false, false, AttackType.Hero, DamageType.Magic, WeaponType.Whoknows)
end