Enemies = {
	img = {
		'enemy1',
		'enemy2',
	},	
	list = {},
	size = 0,
	move = {
		maxVel = 200
	},	
	size = {
		h = 25,
		w = 25
	},
	maxHealth = 7,
	maxBusyCnt = 0.5,

	add = function(self, tagText)
		enemy = {
			isAlive = true,
			health = self.maxHealth,
			frame = {0, 0},
			walkIdx = 0,
			busy = false,
			busyCnt = 0,
			x = 1000, 
			y = 392,
			-- vel = self.move.maxVel,
			vel = math.random(self.move.maxVel),
			img = self.img[math.random(table.getn(self.img))],
			dir = -1,
			tag = tagText
		}

		table.insert(self.list, enemy)
	end,

	hit = function(self, i, dmg, dir)
		-- print('hit!')
		enem = self.list[i]

		if enem.isAlive then
			enem.health = enem.health - dmg
			enem.x = enem.x + (dir * 20)

			if enem.health <= 0 then
				enem.isAlive = false
				enem.frame = {1, 1}
				return 1
			else
				enem.busy = true
				enem.frame = {0, 1}
				return 0
			end
		else
			self:remove(i)
			return 2
		end
		
	end,

	remove = function(self, int)
		table.remove(self.list, int)
	end,

	update = function(self, dt)
		self.count = table.getn(self.list)
		for i, enem in ipairs(self.list) do

			if enem.busy then
				enem.busyCnt = enem.busyCnt + dt

				if enem.busyCnt >= self.maxBusyCnt then
					enem.busyCnt = 0
					enem.busy = false
				end
			end
			if enem.isAlive and not enem.busy then
				enem.x = enem.x + (enem.dir * enem.vel * dt)
				-- enem.vel = math.random(self.move.maxVel)
				enem.walkIdx = enem.walkIdx + (enem.vel / 8 * dt)

				if enem.walkIdx > 5 then
					enem.walkIdx = 0
				end

				enem.frame = {math.floor(enem.walkIdx), 0}

			else
				-- print('im dead')
				
			end
		end
	end,

	scrollAllRight = function(self, ammount, dt)	
		for i, enem in ipairs(self.list) do
			enem.x = enem.x - (0.75 * ammount * dt)
		end
	end, 

	scrollAllLeft = function(self, ammount, dt)	
		for i, enem in ipairs(self.list) do
			enem.x = enem.x + (0.75 * ammount * dt)
		end
	end
}