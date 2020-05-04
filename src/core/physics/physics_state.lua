---@class PhysicsState
---@field phyType PhysicsType
---@field colType CollisionType
---@field forceX number
---@field forceY number
---@field forceZ number
---@field dampX number
---@field dampY number
---@field dampZ number
---@field radius number
---@type PhysicsState
local PhysicsState = class("PhysicsState")


function PhysicsState:constructor()
    self.phyType = PhysicsType.None
    self.colType = CollisionType.Block
    self.forceX = 0
    self.forceY = 0
    self.forceZ = 0
    self.dampX = 0
    self.dampY = 0
    self.dampZ = 0
    self.radius = 50
end
---@class PhysicsType
---@type PhysicsType
PhysicsType = {}
PhysicsType.None = 0 -- 无物理效果
PhysicsType.Static = 1 -- 静态无位移
PhysicsType.Dynamic = 2 -- 动态物理效果

---@class CollisionType
---@type CollisionType
CollisionType = {}
CollisionType.None = 0 -- 无碰撞
CollisionType.Block = 1 -- 阻挡
CollisionType.Overlap = 2 -- 穿透

return PhysicsState