Enemies = {
	-- img = 'player',
	list = {},
	move = {
		maxVel = 500
	},	
	size = {h = 25, w = 25},

	add = function(self)
		enemy = {
			x = 1000, 
			y = 392,
			vel = self.move.maxVel,
			dir = -1
		}

		table.insert(self.list, enemy)
	end,

	remove = function(self, int)
		table.remove(self.list, int)
	end,

	update = function(self, dt)
		for i, enem in ipairs(self.list) do
			enem.x = enem.x + (enem.dir * enem.vel * dt)
			-- enem.dist = enem.dist + (self.move.vel * dt)

			-- if(enem.dist >= self.maxDist) then
			-- 	table.remove(self.list, i)
			-- end

			enem.vel = math.random(500)
		end
	end
}