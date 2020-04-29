--require('utils')
--require('object')
--require('ability/ability_base')
--require('ui/ui_manager')
--require('player')

require('core.init')
local UnitBase = require('core.hero.hero_base')
require('biz.ability.ability1')
require('biz.ability.ability2')
require('biz.hero')

local PhysicsSystem = require("core.physics")


function EnumUnitInMap()
    local _existsUnitGroup = Group:create()
    _existsUnitGroup:enumUnitsInRect(__MapRect,
    function() 
        return true 
    end)
    local _units = _existsUnitGroup:getUnits()
    for i = 1,#_units do
        local unit = _units[i]
        onUnitEnterMap(unit)        
    end
end

-- function UnitBase:onEnterMap()
            
--     if self:getOwner():getController() ~= MapControl.User then
--         return
--     end
    
--     if self.firstEnter == false then
--         return
--     end

--     self.firstEnter = true
-- end

_Triggers.AnyUnitEnterTrig:addAction(function()
    PhysicsSystem.instance.unitGroup:addUnit(Event:getEnteringUnit())
end)


function onMapInit()
    print("Init")
    PhysicsSystem:new():init()
    UnitBase:createUnit(_Wizzard,Player:get(0))
    print(Native.BlzLoadTOCFile([[war3mapimported\UI\ui.toc]]))    
end


onMapInit()