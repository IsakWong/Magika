local tree1 = MKCore.UnitSys:registerUnitType('e003')

tree1.defaultPhysics.phyType = PhysicsType.Static
tree1.canSelect = false
tree1.defaultPhysics.radius = 100
tree1.onBlockOther = function(unit,other)

end

tree1.onOverlapOther = function(unit,other)

end



local rock = MKCore.UnitSys:registerUnitType('e007')

rock.defaultPhysics.phyType = PhysicsType.Dynamic
rock.canSelect = false
rock.defaultPhysics.radius = 75
rock.onBlockOther = function(unit,other)

end

rock.onOverlapOther = function(unit,other)

end


