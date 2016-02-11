require('gfx')
require('aux')
require('Player')
require('coldet')


local keysPressed = 0

function love.load(arg)
	-- init gamestate

	-- init menu

	-- init gameboard

	-- init entities

	

	Gfx.loadSprite(Player.img, 'assets/gfx/hero.png', 0, 0, 16, 16)

end	


function love.update(dt)
	if keysPressed > 0 then
		--print('pressed')
		if love.keyboard.isDown('escape') then
			-- exit
			love.event.push('quit')
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
		Player.move.vel = Player.move.acc
		Player:stop(dt)
	end

	Player:updatePos(dt)
end


function love.draw(dt)
	Gfx.drawSprite(Player.img, Player.pos.x, Player.pos.y, Player.frame[1], Player.frame[2], 3, Player.move.dir < 0)

end

function love.keypressed(key)
	keysPressed = keysPressed + 1
	-- print(keysPressed)
end

function love.keyreleased(key)
	keysPressed = keysPressed - 1
	-- print(keysPressed)
end
