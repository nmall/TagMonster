Projectiles = {
	list = {},
	maxDist = 300,
	move = {
		vel = 1000
	},
	size = {
		w = 10,
		h = 10
	},

	add = function(self, projX, projY, projDir)
		projectile = {
			x = projX,
			y = projY,
			dist = 0,
			dir = projDir
		}

		table.insert(self.list, projectile)
	end,
	remove = function(self, i)
		table.remove(self.list, i)
	end,

	update = function(self, dt)
		for i, proj in ipairs(self.list) do
			proj.x = proj.x + (proj.dir * self.move.vel * dt)

			proj.dist = proj.dist + (self.move.vel * dt)

			if(proj.dist >= self.maxDist) then
				table.remove(self.list, i)
			end
		end
	end
}