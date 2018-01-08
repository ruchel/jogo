require("Paraquedas")
-----------------------variaveis----------------------------------
local lose = false
local nextLevel = 10
local points = 0
local Paraquedas = nil
local music = nil
local fundo = nil
local actveStartMenu = true
-----------------------variaveis----------------------------------

function love.load()

-------------------mira ou ponteiro do mouse----------------------
imgs = love.graphics.newImage( "imgs/Mira.png" )
love.mouse.setVisible( false )
-------------------mira ou ponteiro do mouse----------------------


love.window.setTitle("Sure Shot")--TIRO CERTO
math.randomseed(os.time())
Paraquedas = newParaquedas(3, 30)
Paraquedas:initAllParaquedas()



----------------------imagem de fundo-----------------------------
fundo = love.graphics.newImage( "imgs/Background01.png" )

	planoDeFundo = {
		x = 0,
		y = 0,
		y2 = 0 - fundo:getHeight(),
		vel = 30
	}
----------------------imagem de fundo-----------------------------



-----------------------tela inicial-------------------------------
abretela = false
TelaInicial = love.graphics.newImage( "imgs/Menu.png" )

-----------------------tela inicial-------------------------------



-----------------------audios do jogo-----------------------------
music = love.audio.newSource("sound/blast_off.mp3", "stream")
music:setLooping(true)
love.audio.play(music)
-----------------------audios do jogo-----------------------------




------------------------------gameover-----------------------------
fimdejogo = love.graphics.newImage( "imgs/gameover.png" )
------------------------------gameover-----------------------------

end

function love.update()
  lose = Paraquedas:updateParaquedas()

end



---------------------------botão de play---------------------------
PLAY = love.graphics.newImage( "imgs/play.png")

---------------------------botão de play---------------------------



---------------------função de pontuação---------------------------

function love.mousepressed(x, y, button, istouch)
  points = points + Paraquedas:checkClickParaquedas(x, y)

  if (points >= nextLevel) then
    Paraquedas:IncNumParaquedas()
    nextLevel = nextLevel + 10
  end
  if (lose == true) then --lose = perder
    Paraquedas:reinit()
    lose = false
    points = 0
    nextLevel = 10
  end
  if button == 1 and x >= 600 and x < 600 + PLAY:getWidth() and button == 1 and y >= 280 and y < 280 + PLAY:getHeight() then
	actveStartMenu = false
	end
end
---------------------função de pontuação---------------------------


function love.draw()
	love.graphics.draw( TelaInicial, planoDeFundo.x, planoDeFundo.y )
	love.graphics.draw( PLAY, 600, 280 )
	love.graphics.draw( imgs, love.mouse.getX(), love.mouse.getY() )

	if ( actveStartMenu == true) then
		else
		  love.graphics.draw( fundo, planoDeFundo.x, planoDeFundo.y )
			love.graphics.draw( imgs, love.mouse.getX(), love.mouse.getY() )

		if (lose == false) then
			Paraquedas:drawParaquedas()
		  else
			love.graphics.draw( fimdejogo , 350, 300 )
		end
		  love.graphics.setColor(0, 0, 0, 255)
		  love.graphics.print("PONTOS: " .. points, 20, 20)
		  love.graphics.setColor(255, 255, 255, 255)
	end
end
