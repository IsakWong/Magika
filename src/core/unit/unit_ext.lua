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
function Group:enumPhysicsUnit(x,y,radius)
    self:enumUnitsInRange(x,y,radius,function (u)      
        if u.physicsState == nil then
            return false
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

function math.smoothDamp(current, target, currentVelocity, smoothTime, maxSpeed, deltaTime)
    smoothTime = math.max(0.0001, smoothTime);
    local num1 = 2 / smoothTime;
    local num2 = num1 * deltaTime;
    local num3 = (1.0 / (1.0 + num2 + 0.479999989271164 * num2 * num2 + 0.234999999403954 * num2 * num2 * num2));
    local num4 = current - target;
    local num5 = target;
    local max = maxSpeed * smoothTime;
    local num6 = math.clamp(num4, -max, max);
    target = current - num6;
    local num7 = (currentVelocity + num1 * num6) * deltaTime;
    currentVelocity = (currentVelocity - num1 * num7) * num3;
    local num8 = target + (num6 + num7) * num3;
    if ( (num5 -  current > 0.0) ==( num8 > num5)) then
    
        num8 = num5;
        currentVelocity = (num8 - num5) / deltaTime;
    end
    
    return num8
end

function Group:isIn(widget)
    for i = 0 , self:getSize() - 1 do
        if widget == self:unitAt(i) then
            return true
        end
    end
    return false
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