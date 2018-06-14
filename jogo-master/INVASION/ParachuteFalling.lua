local ParachuteFalling = {}
ParachuteFalling.__index = ParachuteFalling--queda de p�ra-quedas

function newParachuteFalling(g, vInit, xInit, yInit, yFloor, timeInterval, length)

--g = gravidade
--vInit = velocidade inicial
--xInit = posi��o x inicial
--yInit = posi��o y inicial
--Floor = posi��o y ch�o
--timeInterval = tempo de intervalo de cada intera��o


  local a = {}

-- variaveis
  a.g = g
  a.vInit = vInit
  a.xInit = xInit
  a.yInit = yInit
  a.v = vInit
  a.x = xInit
  a.y = yInit
  a.yFloor = yFloor
  a.timeInterval = timeInterval
  a.length = length
  a.time = 0
  a.ending = false
-- variaveis

  return setmetatable(a, ParachuteFalling)

end

function ParachuteFalling:update()
  self.time = self.time + self.timeInterval

  if (self.y < self.yFloor - self.length) then
    self.v = self.v + self.g * self.time
    self.y = self.y + self.v
    if (self.y > self.yFloor - self.length) then
        self.y = self.yFloor - self.length
    end
  else
    self.ending = true
  end

end

function ParachuteFalling:reInit()
  self.v = self.vInit
  self.x = self.xInit
  self.y = self.yInit
  self.time = 0
end

function ParachuteFalling:getX()
  return self.x
end

function ParachuteFalling:getY()
  return self.y
end

function ParachuteFalling:isEnding()
  return self.ending
end
