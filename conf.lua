-- Configuration
function love.conf(t)
	t.title = "TagMonster"
	t.version = "0.10.0"
	t.window.width = 800
	t.window.height = 600

	-- For Windows debugging
	t.console = true

	-- Ouput to SublimeText console
	io.stdout:setvbuf("no")
end