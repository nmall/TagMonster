Aux = {
	assets = {},

	load = function(self, name, path)
		self.assets[name] = love.audio.newSource(path, 'static')
	end,


	play = function(self, name)
		vol = love.audio.getVolume()
		love.audio.setVolume(1)
		love.audio.play(self.assets[name])
		love.audio.setVolume(vol)
	end,


	playMusic = function(self, name)
		love.audio.setVolume(0.2)
		love.audio.play(self.assets[name])
	end,

	stopAll = function(self)
		love.audio.stop()
	end
}