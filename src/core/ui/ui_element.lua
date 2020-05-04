
---@class UIElement : Frame
---@field context  number
UIElement = class("UIElement",Frame)


function UIElement:constructor(ud)
    self.context = 0
end

---@generic T : UIElement
---@param type T
---@return T
function UIElement:create(type,name,parent,priority,context)
    local obj = type:fromUd(Native.BlzCreateFrame(name, getUd(parent), priority, context) )
    obj.context = context
    return obj
end

---@generic T : UIElement
---@param type T
---@return T
function UIElement:get(type,name)
    local obj = type:fromUd(Native.BlzGetFrameByName(name,self.context))
    obj.context = self.context
    return obj
end

return UIElement