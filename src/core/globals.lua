require('lib.init')

---@class GlobalTriggers

---@type GlobalTriggers
_Triggers = {}

_Triggers.SpellEffectTrigger = Trigger:create()
_Triggers.AnyUnitEnterTrig = Trigger:create()
_Triggers.TaskAcceptTrigger = Trigger:create()
_Triggers.ChoseFaithTrigger = Trigger:create()
_Triggers.EnterRectTipTrigger = Trigger:create()

__MapRect = Rect:fromUd(GetEntireMapRect())

_Triggers.AnyUnitEnterTrig:registerEnterRect(__MapRect)

---@class GameUIManager
---@field GameUI Frame
---@field MinimapUI Frame
---@field WorldFrame Frame
---@field HeroButton Frame
---
---@type GameUIManager
_UI = {}
_UI.GameUI = Frame:getOrigin(OriginFrameType.GameUi,0)
_UI.MinimapUI = Frame:getOrigin(OriginFrameType.Minimap,0)
_UI.WorldFrame = Frame:getOrigin(OriginFrameType.WorldFrame,0)
_UI.HeroButton = Frame:getOrigin(OriginFrameType.HeroButton,0)

__UserPlayers = Force:create()
__UserPlayers:enumPlayers(function(player)
    return player:getController() == MapControl.User
end)