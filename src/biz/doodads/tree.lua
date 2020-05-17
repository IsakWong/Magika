local tree1 = MKCore.UnitSys:registerUnitType('e003')

tree1.defaultPhysics.phyType = PhysicsType.Static
tree1.canSelect = false
tree1.defaultPhysics.radius = 75
tree1.onBlockOther = function(unit,other)

end

tree1.onOverlapOther = function(unit,other)

end



local rock = MKCore.UnitSys:registerUnitType('e007')

rock.defaultPhysics.phyType = PhysicsType.Dynamic
rock.defaultPhysics.dampX = 200
rock.defaultPhysics.dampY = 200
rock.canSelect = false
rock.defaultPhysics.radius = 50
rock.onBlockOther = function(unit,other)

end

rock.onOverlapOther = function(unit,other)

end


