require('lib.init')
require('core.ui.ui_element')

---@class UILabel : Frame
---@field button  Frame
---@field buttonText Frame
UILabel = class('UILabel',UIElement)

LabelType = 
{
    Title = 'TitleTextTemplate',
    Content = 'ContentTextTemplate'
}

function UILabel:create(type,content,parent,context)
    local label = nil
    label = UIElement:create(UILabel,type,parent,0,context)
    label:setText(content)
    return label
end

return UILabel