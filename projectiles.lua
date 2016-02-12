Projectiles = {
	list = {},
	move = {
		vel = 2000
	},

	add = function(self, projX, projY, projDir)
		projectile = {
			x = projX,
			y = projY,
			dir = projDir
		}

		table.insert(self.list, projectile)
	end,

	update = function(self, dt)
		for i, proj in ipairs(self.list) do
			proj.x = proj.x + (proj.dir * self.move.vel * dt)
		end
	end
}