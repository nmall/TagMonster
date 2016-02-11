
Player = {
	img = 'player',
	pos = {x = 100, y = 100},
	move = {
		dir = 1,
		acc = 10,
		vel = 0,
		maxVel = 1000
	},
	jumping = 0,
	frame = {0, 0},
	reverse = function(self)
		self.move.dir = -1 * self.move.dir
		self.move.vel = self.move.acc
	end,
	run = function(self, dt)
		-- Movement
		self.move.vel = math.max(self.move.acc, math.min(self.move.vel + self.move.acc, self.move.maxVel))
		
		-- Animation
		local runRow = 0
		local maxRun = 5

		-- print('jumping', jumping)
		if self.jumping == 0 then
			if runIdx == nil then runIdx = 0 
			else runIdx = runIdx + (5 * dt) end

			if runIdx > maxRun then runIdx = 0 end

			self.frame = {math.floor(runIdx), runRow}
		end
	end,
	stop = function(self, dt)
		self.move.vel = 0;
		if self.jumping == 0 then
			self.frame = {0, 1}
		end
	end,
	jump = function(self, dt)
		-- print('jump')
		if self.jumping == 0 then 
			self.jumping = 1 
			self.frame = {3, 1}
		end
	end,
	updateJump = function(self, dt)
		local maxJump = 32
		if jumpDur == nil then jumpDur = 0 end
		
		if self.jumping ~= 0 then
			jumpDur = jumpDur + 1
			if jumpDur > maxJump then
				jumpDur = 0
				self.jumping = 0
			elseif jumpDur > ( maxJump / 2 ) then
				self.jumping = -1
			else
				self.jumping = 1
			end		
			
		end

	end,
	updatePos = function(self, dt)
		self.pos.x = self.pos.x + (self.move.dir * self.move.vel * dt)
		
		self:updateJump(dt)
		if self.jumping ~= 0 then
			self.pos.y = self.pos.y - (self.jumping * 4)
		end
		-- print('\t',self.pos.x, self.pos.y)	
	end
} 