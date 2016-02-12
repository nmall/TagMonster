require('gfx')
require('aux')
require('Player')
require('coldet')
require('gameboard')
require('projectiles')
require('enemies')
require('tags')

local keysPressed = 0

local splash = true
local exit = false
local confirm = false
local splashCnt = 0
local maxSplashCnt = 50

local gameboard = nil
local scaleFactor = 3
local bgScaleFactor = 4

local spriteSize = { w = 25, h = 25 }
local bgSize = { w = 2256, h = 144 }

function love.load(arg)
	-- init gamestate
	math.randomseed( os.time() )


	-- init font
	local font = love.graphics.newImageFont("assets/gfx/imagefont.png",
	    " abcdefghijklmnopqrstuvwxyz" ..
	    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
	    "123456789.,!?-+/():;%&`'*#=[]\"")
	font:setFilter('nearest', 'nearest')
	love.graphics.setFont(font)

	-- init menu
	Gfx.load('splash', 'assets/gfx/splash-screen.png')

	-- init gameboard
	Gameboard.bgSize.w = bgSize.w * bgScaleFactor
	Gameboard.bgSize.h = bgSize.h * bgScaleFactor
	Gameboard.size.padding = Gameboard.size.w / 3

	-- print('bg.w, bg.h', Gameboard.bgSize.w, Gameboard.bgSize.h)

	Gfx.load(Gameboard.bg[1].img, Gameboard.bg[1].path)
	Gfx.load(Gameboard.bg[2].img, Gameboard.bg[2].path)
	Gfx.load(Gameboard.bg[3].img, Gameboard.bg[3].path)
	Gfx.load(Gameboard.bg[4].img, Gameboard.bg[4].path)
	
	-- init entities
	-- Player
	Gfx.loadSprite(Player.img, 'assets/gfx/hero-sprite.png', 0, 0, spriteSize.w, spriteSize.h)
	Player.size.h = spriteSize.w * scaleFactor
	Player.size.w = spriteSize.h * scaleFactor

	-- Enemies
	Enemies.size.h = spriteSize.w * scaleFactor
	Enemies.size.w = spriteSize.h * scaleFactor
	Gfx.loadSprite(Enemies.img, 'assets/gfx/enemy-sprite.png', 0, 0, spriteSize.w, spriteSize.h)

	-- Projectiles
	Projectiles.size.h = 16
	Projectiles.size.w = 16
	Gfx.loadSprite(Projectiles.img, 'assets/gfx/projectile.png', 0, 0, Projectiles.size.h, Projectiles.size.w)

	-- Asset
	Gfx.load('image', 'assets/gfx/apple.png')

	-- Music
	Aux:load('mainMusic', 'assets/aux/music/main.wav')
	Aux:load('titleMusic', 'assets/aux/music/title.wav')

	-- SoundFX
	Aux:load('jump', 'assets/aux/sfx/jump.wav')
	Aux:load('enemyHit', 'assets/aux/sfx/enemy-hit-alt.wav')
	Aux:load('enemyDead', 'assets/aux/sfx/enemy-dead.wav')
	Aux:load('nom', 'assets/aux/sfx/happy-peace.wav')
	Aux:load('heroHit', 'assets/aux/sfx/hero-hit.wav')
	Aux:load('throw', 'assets/aux/sfx/hero-throw.wav')

	Aux:playMusic('titleMusic')
	-- print('Player h,w', Player.size.h, Player.size.w)

end	


function love.update(dt)

	if exit and confirm then
		love.event.push('quit')
		love.timer.sleep(5)
	end

	if keysPressed > 0 then
		--print('pressed')
		if love.keyboard.isDown('return') and splash and not exit then
			splash = false
			Aux:play("nom")
			love.timer.sleep(2)
			Aux:stopAll()
			Aux:playMusic('mainMusic')
		end

		if love.keyboard.isDown('escape') then
			-- exit
			Aux:play("heroHit")
			exit = true
		end

		if love.keyboard.isDown('y') then
			-- confrm
			if exit then 
				Aux:play("nom")
				confirm = true
			end
		end

		if love.keyboard.isDown('n') then
			-- confrm
			if exit then 
				Aux:play("heroHit")
				exit = false
			end
		end





		if splash or exit then return end
		

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
			-- Aux:play('jump')
		end

		if love.keyboard.isDown('a') then
			-- fire
			if not Player.fired then
				Player:fire()
				-- Aux:play('throw')
				local projX = Player.pos.x + (Player.size.w / 2)
				local projY = Player.pos.y + (Player.size.h / 3)
				
				Projectiles:add(projX, projY, Player.move.dir)
			end

		end
	else
		Player:stop(dt)
	end

	Player:update(dt)

	Projectiles:update(dt)

	Enemies:update(dt)

	-- Check enemy collision
	for i, enem in ipairs(Enemies.list) do
		for j, proj in ipairs(Projectiles.list) do
			local collide = Coldet.checkCollision(enem.x, enem.y, Enemies.size.w, Enemies.size.h, proj.x, proj.y, Projectiles.size.w, Projectiles.size.h)

			if collide then
				-- print("boom!")
				hitResult = Enemies:hit(i, 1, Player.move.dir)
				if hitResult == 0 then
					Gameboard:updateScore(1)
					Aux:play('enemyHit')
				elseif hitResult == 1 then
					Gameboard:updateScore(10)
					Aux:play('enemyDead')
				else
					destroyScore = Tags:getScore(enem.tag, -1)
					Gameboard:updateScore(destroyScore)
					if destroyScore > 0 then
						Player:nom()
						Aux:play('nom')
					else
						Player:ouch()
						Aux:play('heroHit')
					end
				end

				
				Projectiles:remove(j)
			end
		end

		local playerCollide = Coldet.checkCollision(enem.x, enem.y, Enemies.size.w, Enemies.size.h, Player.pos.x, Player.pos.y, Player.size.w, Player.size.h)
		if playerCollide then
			if enem.isAlive then
				-- print('ouch!')
				Player:ouch()
				Aux:play('heroHit')
				Enemies:remove(i)
			else
				-- print('nom!')
				nomScore = Tags:getScore(enem.tag, 1)

				if nomScore > 0 then
					Player:nom()
					Aux:play('nom')
				else
					Player:ouch()
					Aux:play('heroHit')
				end

				Gameboard:updateScore(nomScore)
				Enemies:remove(i)
			end

			
		end

	end


	-- Maybe add new enemy
	if Enemies.count < 1 then
		rand = math.random(100)

		if rand == 1 then
			Enemies:add(Tags:rand())
		end
	end

	-- Check player boundries / scroll
	if (Player.pos.x + Player.size.w) > (Gameboard.size.w - Gameboard.size.padding) then
		Player.pos.x = (Gameboard.size.w - Gameboard.size.padding) - Player.size.w
		Gameboard:scrollRight(Player.move.vel, dt)
		Enemies:scrollAllRight(Player.move.vel, dt)

	elseif Player.pos.x <= (0 + Gameboard.size.padding) then
		Player.pos.x = (0 + Gameboard.size.padding)
		Gameboard:scrollLeft(Player.move.vel, dt)
		Enemies:scrollAllLeft(Player.move.vel, dt)
	end

end


function love.draw()
	if exit then
		drawExit()
	elseif splash then 
		drawSplash()
	else
		drawGame()
	end
end

function drawExit()
	love.graphics.clear()
	love.graphics.setColor(127, 127, 147, 255)
	Gfx.draw('splash', 0, 0)

	local offsetX = 300

	love.graphics.setColor(255, 255, 255, 255)
	if confirm then
		love.graphics.print("Thanks for Playing!", offsetX, 200, nil, 3, 3)
		love.graphics.print("Score:  " .. Gameboard.score, offsetX + 20, 130, nil, 5, 5)
	else
		love.graphics.print("Really Quit? (y/n)", offsetX, 200, nil, 3, 3)
		love.graphics.print("Score:  " .. Gameboard.score, offsetX + 20, 130, nil, 5, 5)
	end

end

function drawSplash()
	love.graphics.clear()
	love.graphics.setColor(255, 255, 255, 255)

	Gfx.draw('splash', 0, 0)
	
	splashCnt = splashCnt + 1

	if splashCnt < maxSplashCnt and splashCnt > 0 then
		love.graphics.print('Press Enter to Begin', 250, 250, nil, 3, 3)
	elseif splashCnt > 0 then
		splashCnt = 0 - ( maxSplashCnt / 2 )
	end
end

function drawGame()
	love.graphics.clear()
	love.graphics.setColor(255, 255, 255, 255)

	-- print('x, y', Gameboard.bg[4].offset.x, Gameboard.bg[4].offset.y)

	-- Background
	Gfx.draw(Gameboard.bg[4].img, Gameboard.bg[4].offset.x, Gameboard.bg[4].offset.y, bgScaleFactor)
	Gfx.draw(Gameboard.bg[3].img, Gameboard.bg[3].offset.x, Gameboard.bg[3].offset.y, bgScaleFactor)
	Gfx.draw(Gameboard.bg[2].img, Gameboard.bg[2].offset.x, Gameboard.bg[2].offset.y, bgScaleFactor)

	-- Projectiles
	for i, proj in ipairs(Projectiles.list) do
		-- love.graphics.circle("fill", proj.x, proj.y, 8, 100)
		Gfx.drawSprite(Projectiles.img, proj.x, proj.y, 0, 0, 2)
	end

	-- Player
	Gfx.drawSprite(Player.img, Player.pos.x, Player.pos.y, Player.frame[1], Player.frame[2], scaleFactor, Player.move.dir < 0)

	-- Enemies
	for i, enem in ipairs(Enemies.list) do

		-- love.graphics.rectangle("fill", enem.x, enem.y, spriteSize.w * scaleFactor, spriteSize.w * scaleFactor)
		Gfx.drawSprite(Enemies.img, enem.x, enem.y, enem.frame[1], enem.frame[2], scaleFactor, enem.dir < 0)
		
		-- display tag
		if not enem.isAlive then
			Tags:print(enem.tag, enem.x, enem.y + 20)
		end

		if enem.x <= 0 then
			-- print('remove')
			Enemies:remove(i)
		end
	end

	-- Foreground
	Gfx.draw(Gameboard.bg[1].img, Gameboard.bg[1].offset.x, Gameboard.bg[1].offset.y, bgScaleFactor)
	
	-- Scoreboard
	love.graphics.print(Gameboard.score, 10, 0, nil, 5, 5)

	-- image
	Gfx.draw('image', 880, 20, 0.08)

	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle('line', 880, 20, 127 ,85)

	love.graphics.setColor(255, 255, 255, 255)

end

function love.keypressed(key)
	print(key)
	keysPressed = keysPressed + 1
end

function love.keyreleased(key)
	keysPressed = keysPressed - 1

	if key == 'a' then
		Player.firing = false
	end
end
