local function map(n, start1, stop1, start2, stop2)
  return (n - start1) / (stop1 - start1) * (stop2 - start2) + start2
end

local STAR_SPEED = 500
local STAR_COUNT = 200
local STAR_COLOR = { 1, 1, 1 }

local Width, Height

---@class Star
---@field x number
---@field y number
---@field z number
---@field pz number
local Star = {
  x = 0,
  y = 0,
  z = 0,
  pz = 0,
}

---@return Star
function Star:new(o)
  o = o or {}
  setmetatable(o, { __index = self })
  o.x = love.math.random(-Width, Width)
  o.y = love.math.random(-Height, Height)
  o.z = love.math.random(Width)
  o.pz = o.z
  return o
end

---@param dt number
function Star:update(dt)
  self.z = self.z - (STAR_SPEED * dt)
  if self.z < 1 then
    self.x = love.math.random(-Width, Width)
    self.y = love.math.random(-Height, Height)
    self.z = love.math.random(Width)
    self.pz = self.z
  end
end

function Star:show()
  local sx = map(self.x / self.z, -1, 1, -Width / 2, Width / 2) + Width / 2
  local sy = map(self.y / self.z, -1, 1, -Height / 2, Height / 2) + Height / 2
  local r = map(self.z, 0, Width, 4, 0)
  love.graphics.setColor(STAR_COLOR)
  love.graphics.circle("fill", sx, sy, r)

  local px = map(self.x / self.pz, -1, 1, -Width / 2, Width / 2) + Width / 2
  local py = map(self.y / self.pz, -1, 1, -Height / 2, Height / 2) + Height / 2

  self.pz = self.z
  love.graphics.line(px, py, sx, sy)
end

---@type Star[]
local stars = {}

function love.load()
  Width, Height = love.graphics.getDimensions()
  love.graphics.setBackgroundColor(0, 0, 0)
  for i = 1, STAR_COUNT do
    stars[i] = Star:new()
  end
end

function love.update(dt)
  for i = 1, STAR_COUNT do
    stars[i]:update(dt)
  end
end

function love.draw()
  for i = 1, STAR_COUNT do
    stars[i]:show()
  end
end
