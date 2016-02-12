require('gfx')
require('aux')
require('Player')
require('coldet')
require('gameboard')
require('projectiles')

local keysPressed = 0

local gameboard = nil
local scaleFactor = 3
local bgScaleFactor = 4

local spriteSize = { w = 25, h = 25 }
local bgSize = { w = 2000, h = 144 }

-- local projectiles = {}

function love.load(arg)
	-- init gamestate
	math.randomseed( os.time() )

	-- init menu

	-- init gameboard
	-- love.graphics.setBackgroundColor(96, 225, 187)
	
	Gameboard.bgSize.w = bgSize.w * bgScaleFactor
	Gameboard.bgSize.h = bgSize.h * bgScaleFactor
	Gameboard.size.padding = Gameboard.size.w / 4

	-- print('bg.w, bg.h', Gameboard.bgSize.w, Gameboard.bgSize.h)

	Gfx.load(Gameboard.bg[1].img, Gameboard.bg[1].path)
	Gfx.load(Gameboard.bg[2].img, Gameboard.bg[2].path)
	Gfx.load(Gameboard.bg[3].img, Gameboard.bg[3].path)
	Gfx.load(Gameboard.bg[4].img, Gameboard.bg[4].path)
	
	-- init entities
	Gfx.loadSprite(Player.img, 'assets/gfx/hero-sprite.png', 0, 0, spriteSize.w, spriteSize.h)



	Player.size.h = spriteSize.w * scaleFactor
	Player.size.w = spriteSize.h * scaleFactor

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
			-- Player.pos.y = Player.pos.y - (2 * scaleFactor)
		end

		if love.keyboard.isDown('down') then		
			-- debug
			-- Player.pos.y = Player.pos.y + (2 * scaleFactor)
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

		if love.keyboard.isDown('a') then
			-- fire
			
			if not Player.fired then
				Player:fire()
				
				local projX = Player.pos.x + (Player.size.w / 2)
				local projY = Player.pos.y + (Player.size.h / 2)
				
				Projectiles:add(projX, projY, Player.move.dir)
			end

		end
	else
		Player:stop(dt)
	end

	Player:updatePos(dt)

	Projectiles:update(dt)

	if (Player.pos.x + Player.size.w) > (Gameboard.size.w - Gameboard.size.padding) then
		Player.pos.x = (Gameboard.size.w - Gameboard.size.padding) - Player.size.w
		Gameboard:scrollRight(Player.move.vel, dt)

	elseif Player.pos.x <= (0 + Gameboard.size.padding) then
		Player.pos.x = (0 + Gameboard.size.padding)
		Gameboard:scrollLeft(Player.move.vel, dt)
	end

end


function love.draw(dt)
	-- print('x, y', Gameboard.bg[4].offset.x, Gameboard.bg[4].offset.y)

	Gfx.draw(Gameboard.bg[4].img, Gameboard.bg[4].offset.x, Gameboard.bg[4].offset.y, bgScaleFactor)
	Gfx.draw(Gameboard.bg[3].img, Gameboard.bg[3].offset.x, Gameboard.bg[3].offset.y, bgScaleFactor)
	Gfx.draw(Gameboard.bg[2].img, Gameboard.bg[2].offset.x, Gameboard.bg[2].offset.y, bgScaleFactor)

	for i, proj in ipairs(Projectiles.list) do
		love.graphics.circle("fill", proj.x, proj.y, 10, 100)
	end

	Gfx.drawSprite(Player.img, Player.pos.x, Player.pos.y, Player.frame[1], Player.frame[2], scaleFactor, Player.move.dir < 0)

	Gfx.draw(Gameboard.bg[1].img, Gameboard.bg[1].offset.x, Gameboard.bg[1].offset.y, bgScaleFactor)

	
	

end

function love.keypressed(key)
	keysPressed = keysPressed + 1
	-- print(keysPressed)
end

function love.keyreleased(key)
	keysPressed = keysPressed - 1
	-- print(keysPressed)
end
