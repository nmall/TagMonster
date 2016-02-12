Enemies = {
	-- img = 'player',
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

	add = function(self, tagText)
		enemy = {
			isAlive = true,
			health = self.maxHealth,
			x = 1000, 
			y = 392,
			vel = self.move.maxVel,
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
				return 1
			else
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
			if enem.isAlive then
				enem.x = enem.x + (enem.dir * enem.vel * dt)
				enem.vel = math.random(self.move.maxVel)
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