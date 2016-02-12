
Player = {
	img = 'player',
	pos = {x = 100, y = 392},
	size = {h = 25, w = 25},
	move = {
		dir = 1,
		acc = 10,
		vel = 0,
		maxVel = 1000,
		maxJump = 60
	},
	jumping = 0,
	fired = false,
	busy = false,
	busyCnt = 0,
	busyMaxCnt = 0.5,
	frame = {0, 0},
	reverse = function(self)
		self.move.dir = -1 * self.move.dir
		self.move.vel = self.move.acc
	end,
	run = function(self, dt)
		-- Movement

		if not self.busy then
			self.move.vel = math.max(self.move.acc, math.min(self.move.vel + self.move.acc, self.move.maxVel))
			
			-- Animation
			local runRow = 0
			local maxRun = 5

			-- print('jumping', jumping)
			if self.jumping == 0 then
				if runIdx == nil then runIdx = 0 
				else runIdx = runIdx + (20 * dt) end

				if runIdx > maxRun then runIdx = 0 end

				self.frame = {math.floor(runIdx), runRow}
			end
		end
	end,
	fire = function(self)
		-- print('fire')
		if not self.busy then
			self.frame = {1, 0}	
			self.fired = true
		end
	end,
	ouch = function(self)
		self.frame = {1, 1}
		self.busy = true
	end,
	nom = function(self)
		self.frame = {2, 1}
		self.busy = true
	end,
	stop = function(self, dt)
		-- print('stop')
		self.move.vel = 0;
		if self.jumping == 0 and not self.busy then
			self.frame = {0, 1}
		end

		self.fired = false
	end,
	jump = function(self, dt)
		-- print('jump')
		if self.jumping == 0 and not self.busy then 
			self.jumping = 1 
			self.frame = {3, 1}
		end
	end,
	updateJump = function(self, dt)
		if jumpDur == nil then jumpDur = 0 end
		
		if self.jumping ~= 0 then
			jumpDur = jumpDur + 1
			if jumpDur > self.move.maxJump then
				jumpDur = 0
				self.jumping = 0
			elseif jumpDur > ( self.move.maxJump / 2 ) then
				self.jumping = -1
			else
				self.jumping = 1
			end		
			
		end

	end,
	update = function(self, dt)
		if self.busy then
			-- print('busy', self.busyCnt)
			self.busyCnt = self.busyCnt + dt
			if self.busyCnt >= self.busyMaxCnt then
				self.busy = false
				self.busyCnt = 0
			end
		end

		self:updatePos(dt)
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