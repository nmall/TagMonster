Gameboard = {
	score = 0,
	size = {
		w = love.graphics.getWidth(),
		h = love.graphics.getHeight(),
		padding = 0
	},
	bgSize = {
		w = 100,
		h = 100
	},
	bg = {
		{
			img = 'env1',
			path = 'assets/gfx/env1.png',
			scrollSpeed = 1,
			offset = {
				x = 0,
				y = 0
			}
		},
		{
			img = 'env2',
			path = 'assets/gfx/env2.png',
			scrollSpeed = 0.75,
			offset = {
				x = 0,
				y = 0
			}
		},
		{
			img = 'env3',
			path = 'assets/gfx/env3.png',
			scrollSpeed = 0.25,
			offset = {
				x = 0,
				y = 0
			}
		},
		{
			img = 'env4',
			path = 'assets/gfx/env4.png',
			scrollSpeed = 0.1,
			offset = {
				x = 0,
				y = 0
			}
		}
	},
	updateScore = function(self, amount)
		self.score = math.max(0, self.score + amount)
	end,
	scrollRight = function(self, amount, dt)	
		for i, bg in ipairs(self.bg) do
			bg.offset.x = bg.offset.x - (bg.scrollSpeed * amount * dt)

			if self.bgSize.w + bg.offset.x <= self.size.w then
				-- print('right too far')
				bg.offset.x = 0
			end

			-- print('scrollRight', bg.offset.x) 
		end
	end, 

	scrollLeft = function(self, amount, dt)	
		for i, bg in ipairs(self.bg) do
			bg.offset.x = bg.offset.x + (bg.scrollSpeed * amount * dt)

			if bg.offset.x + self.size.padding >= 0 then
				-- print('left too far', bg.offset.x + self.size.padding)
				bg.offset.x = 0 - self.bgSize.w + self.size.padding + self.size.w
			end

			-- print('scrollLeft', bg.offset.x)

		end
	end,
}