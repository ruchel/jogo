require("ParachuteFalling")
require("util")

local Paraquedas = {}
Paraquedas.__index = Paraquedas


function newParaquedas(numParaquedas)
  local a = {}

  a.numParaquedas = numParaquedas
  a.initNumParaquedas = numParaquedas
  a.rParaqueda = 64
  a.Paraquedas = nil

  return setmetatable(a, Paraquedas)

end

function Paraquedas:initParaqueda(index, numParaqueda)
  self.Paraquedas[index] = newParachuteFalling(0.1, 0.0, math.random(0 + self.rParaqueda, 1366 - self.rParaqueda), 0.0, 600.0, 0.001, self.rParaqueda)
  self.Paraquedas[index].image = love.graphics.newImage("imgs/Paraqueda" .. numParaqueda .. ".png")
  self.Paraquedas[index].sound = love.audio.newSource("sound/explosion.wav", "static")
end

function Paraquedas:initAllParaquedas()
  self.Paraquedas = {}
  for index = 1, self.numParaquedas do
    self.initParaqueda(self, index, math.random(1, 5))
  end
end

function Paraquedas:updateParaquedas()
  local lose = false

  for index = 1, self.numParaquedas do
    self.Paraquedas[index]:update()
    if (self.Paraquedas[index]:isEnding()) then
      lose = true
    end
  end

  return lose
end

function Paraquedas:checkClickParaquedas(x, y)
  local points = 0

  for index = 1, self.numParaquedas do
    if (checkMousePosIn(x, y, self.Paraquedas[index]:getX(),
        self.Paraquedas[index]:getY(), self.rParaqueda) == true) then
      self.initParaqueda(self, index, math.random(1, 5))
      points = points + 1
      love.audio.play(self.Paraquedas[index].sound)
    end
  end
  return points
end

function Paraquedas:IncNumParaquedas()
  self.numParaquedas = self.numParaquedas + 1
  self.initParaqueda(self, self.numParaquedas, math.random(1, 5))
end

function Paraquedas:reinit()
  self.numParaquedas = self.initNumParaquedas
  self.initAllParaquedas(self)
end

function Paraquedas:drawParaquedas()
  for index = 1, self.numParaquedas do
    love.graphics.draw(self.Paraquedas[index].image, self.Paraquedas[index]:getX(),
      self.Paraquedas[index]:getY())
  end
  love.graphics.setColor(255, 255, 255, 255)
end
