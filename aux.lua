Aux = {
	assets = {},

	load = function(self, name, path)
		self.assets[name] = love.audio.newSource(path, 'static')
	end,


	play = function(self, name)
		love.audio.setVolume(1)
		love.audio.play(self.assets[name])
	end,


	playMusic = function(self, name)
		love.audio.setVolume(0.8)
		love.audio.play(self.assets[name])
	end,

	stopAll = function(self)
		love.audio.stop()
	end
}