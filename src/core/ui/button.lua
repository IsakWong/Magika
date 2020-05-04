require('core.ui.ui_element')

---@class UIButton : UIElement
UIButton = class('UIButton',UIElement)

---create
---@param content string
---@param callback function
---@return UIButton
function UIButton:create(content,parent,callback,context)
    local button = UIElement:create(UIButton,"ScriptDialogButton",parent,0,context)
    local text = Frame:getByName("ScriptDialogButtonText",context)
    button.buttonText = text
    button.trigger = buttonTrigger
    button:setText(content)
    button:registerClick(callback)
    return button
end

function UIButton:registerClick(callback)
    if callback == nil then 
        return
    end
    self.buttonTrigger = Trigger:create()
    self.buttonTrigger:registerFrameEvent(self,FrameEventType.ControlClick)
    self.buttonTrigger:addAction(callback)
end

return UIButton