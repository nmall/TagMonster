require('gfx')
require('aux')
require('Player')
require('coldet')

local keysPressed = 0

local gameboard = nil
local scaleFactor = 3
local bgScaleFactor = 4

local spriteSize = 25

function love.load(arg)
	-- init gamestate
	math.randomseed( os.time() )

	-- init menu

	-- init gameboard
	-- love.graphics.setBackgroundColor(96, 225, 187)
	gameboard = {
		bg = {
				{
					img = 'env1',
					path = 'assets/gfx/env1.png',
					offset = {
						x = 0,
						y = 0
					}
				},
				{
					img = 'env2',
					path = 'assets/gfx/env2.png',
					offset = {
						x = 0,
						y = 0
					}
				},
				{
					img = 'env3',
					path = 'assets/gfx/env3.png',
					offset = {
						x = 0,
						y = 0
					}
				},
				{
					img = 'env4',
					path = 'assets/gfx/env4.png',
					offset = {
						x = 0,
						y = 0
					}
				}
			}
	}

	Gfx.load(gameboard.bg[1].img, gameboard.bg[1].path)
	Gfx.load(gameboard.bg[2].img, gameboard.bg[2].path)
	Gfx.load(gameboard.bg[3].img, gameboard.bg[3].path)
	Gfx.load(gameboard.bg[4].img, gameboard.bg[4].path)
	
	-- init entities
	Gfx.loadSprite(Player.img, 'assets/gfx/hero-sprite.png', 0, 0, spriteSize, spriteSize)


	Player.size.h = spriteSize * scaleFactor
	Player.size.w = spriteSize * scaleFactor

	

	-- print('Player h,w', Player.size.h, Player.size.w)

end	


function love.update(dt)
	if keysPressed > 0 then
		--print('pressed')
		if love.keyboard.isDown('escape') then
			-- exit
			love.event.push('quit')
		end

		if love.keyboard.isDown('up') then		
			-- debug
			Player.pos.y = Player.pos.y - (2 * scaleFactor)
		end

		if love.keyboard.isDown('down') then		
			-- debug
			Player.pos.y = Player.pos.y + (2 * scaleFactor)
		end

		if love.keyboard.isDown('left') then
			-- move left
			if Player.move.dir == 1 then Player:reverse() end
			Player:run(dt)
		end

		if love.keyboard.isDown('right') then
			-- move right
			if Player.move.dir == -1 then Player:reverse() end
			Player:run(dt)
		end

		if love.keyboard.isDown('space') then
			-- jump
			Player:jump(dt)
		end

		if love.keyboard.isDown('ctrl', 'lctrl', 'rctrl') then
			-- fire
		end
	else
		--print('release')
		Player:stop(dt)
	end

	Player:updatePos(dt)
end


function love.draw(dt)
	Gfx.draw(gameboard.bg[4].img, gameboard.bg[4].offset.x, gameboard.bg[4].offset.y, bgScaleFactor)
	Gfx.draw(gameboard.bg[3].img, gameboard.bg[3].offset.x, gameboard.bg[3].offset.y, bgScaleFactor)
	Gfx.draw(gameboard.bg[2].img, gameboard.bg[2].offset.x, gameboard.bg[2].offset.y, bgScaleFactor)

	Gfx.drawSprite(Player.img, Player.pos.x, Player.pos.y, Player.frame[1], Player.frame[2], scaleFactor, Player.move.dir < 0)

	Gfx.draw(gameboard.bg[1].img, gameboard.bg[1].offset.x, gameboard.bg[1].offset.y, bgScaleFactor)

	

end

function love.keypressed(key)
	keysPressed = keysPressed + 1
	-- print(keysPressed)
end

function love.keyreleased(key)
	keysPressed = keysPressed - 1
	-- print(keysPressed)
end
