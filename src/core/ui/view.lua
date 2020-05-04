require('core.ui.ui_element')

---@class UIView : UIElement
UIView = class('UIView',UIElement)
UIView.viewNum = 0

function UIView:constructor(ud)
    UIView.viewNum = UIView.viewNum + 1
end

function UIView:onInit()
    
end

return UIView