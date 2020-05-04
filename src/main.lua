--require('utils')
--require('object')
--require('ability/ability_base')
--require('ui/ui_manager')
--require('player')
require('lib.init')
require('core.MKCore')

print("booting...")
MKCore:boot()
print("boot finish...")

require('biz.hero.hero')
require('biz.ability.ability1')
require('biz.ability.ability2')
require('biz.ability.ability3')
require('biz.ability.ability4')

-- function UnitBase:onEnterMap()
            
--     if self:getOwner():getController() ~= MapControl.User then
--         return
--     end
    
--     if self.firstEnter == false then
--         return
--     end

--     self.firstEnter = true
-- end

local main  = MKCore.UnitSys:createUnit(MainHero,Player:get(0),Native.GetRectCenterX(gg_rct_RebornRect),Native.GetRectCenterY(gg_rct_RebornRect),0)

print(Native.BlzLoadTOCFile([[war3mapimported\UI\ui.toc]]))    


Timer:create():start(2,function()
    ---@type UnitBase
    local unit =  UnitBase:fromUd(udg_enemy)    
    --unit:issuePointOrder(Order.curse,main:getX(),main:getY())
end)