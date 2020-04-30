---@class PhysicsState
---@field phyType PhysicsType
---@field colType CollisionType
---@type PhysicsState
local PhysicsState = Class("PhysicsState")

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