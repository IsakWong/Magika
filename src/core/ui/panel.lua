require('core.ui.ui_element')

---@class UIPanel : UIElement
UIPanel = class('UIPanel',UIElement)

HorionzontalAlignment = {
    Left = 0.0,
    Center = 0.5,
    Right = 1.0
}

VerticalAlignment = {
    Top = 0.0,
    Center = -0.5,
    Bottom = -1.0
}


function UIPanel:constructor(ud)
    self.children = {}
    self.hAlign = HorionzontalAlignment.Center
    self.vAlign = VerticalAlignment.Center
    self.hPadding = 0.0
    self.vPadding = 0.0
    self.vGap = 0.005
end

---@param child Frame
function UIPanel:addChild(child)
    table.insert(self.children,child)
    child:setParent(self)
end

function UIPanel:size()
    local width = 0.0
    local height = 0.0
    self.maxChildWidth = 0.0
    self.maxChildHeight = 0.0
    for i = 1,#self.children do
        local child = self.children[i]
        width = width + child:getWidth()
        height = height + child:getHeight()
        if child:getWidth() > self.maxChildWidth then
            self.maxChildWidth = child:getWidth()
        end
        if child:getHeight() > self.maxChildHeight then
            self.maxChildHeight = child:getHeight()
        end
    end
    self.contentWidth = width
    self.contentHeight = height
end

function UIPanel:layout()
    self:size()
    local offsetX = 0.0
    local offsetY = 0.0
    offsetX = self.hPadding + (self:getWidth() - self.maxChildWidth) * self.hAlign
    offsetY = self.vPadding + (self:getHeight() - self.contentHeight - (#self.children - 1) * self.vGap ) * self.vAlign
    for i = 1,#self.children do
        local child = self.children[i]
        child:setPoint(FramePointType.Topleft,self,FramePointType.Topleft,offsetX,offsetY)
        offsetY = offsetY - child:getHeight()
    end
end

return UIPanel