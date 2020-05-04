
---@class UIManager
---@field views UIPanel[]
UIManager = class("UIManager")
UIManager.views = {}


UIDef =
{
    MainView = "MainView",
    SelectHeroView = "HeroSelectView",
}
---@return UIPanel
function UIManager:showView(type,name)
    local view = UIManager.views[name]
    if view == nil then
        view = UIElement:create(type,name,_UI.GameUI,0,UIView.viewNum)
        view:setSize(0,0)
        view:onInit()
        UIManager.views[name] = view
    end
    view:setVisible(true)
    return view
end

function UIManager:sendMessage(viewName,message,data)
    local view = UIManager.views[viewName]
    if view ~= nil then
        local func = view[message]
        if type(func) == 'function' then
            func(view,data)
        end
    end
end

---@generic T : UIElement
---@param type T
---@return T
function UIManager:getView(type,name)
    return type:fromUd(UIManager.views[name]:getUd())
end

function UIManager:hideView(name)
    local panel = UIManager.views[name]
    if panel ~= nil then
        panel:setVisible(false)
    end
end



function UIManager:registerClickEvent(callback)
    local buttonTrigger = Trigger:create()
    buttonTrigger:registerFrameEvent(self,FrameEventType.ControlClick)
    buttonTrigger:addAction(callback)
end