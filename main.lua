---@param n number
---@param start1 number
---@param stop1 number
---@param start2 number
---@param stop2 number
---@return number
local function map(n, start1, stop1, start2, stop2)
  return (n - start1) / (stop1 - start1) * (stop2 - start2) + start2
end

---@class Star
---@field x number
---@field y number
---@field z number
Star = {
  x = 0,
  y = 0,
  z = 0,
  pz = 0,
}

---@return Star
function Star:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.x = love.math.random(-Width, Width)
  self.y = love.math.random(-Height, Height)
  self.z = love.math.random(Width)
  self.pz = self.z
  return o
end

---@param dt number
function Star:update(dt)
  self.z = self.z - (500 * dt)
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
  love.graphics.circle("fill", sx, sy, r)

  local px = map(self.x / self.pz, -1, 1, -Width / 2, Width / 2) + Width / 2
  local py = map(self.y / self.pz, -1, 1, -Height / 2, Height / 2) + Height / 2

  self.pz = self.z
  love.graphics.line(px, py, sx, sy)
end

---@type Star[]
local stars = {}
local star_count = 200

function love.load()
  Width, Height = love.graphics.getDimensions()
  for i = 1, star_count do
    stars[i] = Star:new()
  end
end

function love.update(dt)
  for i = 1, star_count do
    stars[i]:update(dt)
  end
end

function love.draw()
  love.graphics.clear(0, 0, 0, 255)
  for i = 1, star_count do
    stars[i]:show()
  end
end
