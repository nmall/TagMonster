Gfx = {}

local assets = {}

function Gfx.load(name, path)
	local asset = love.graphics.newImage(path)
	assets[name] = asset
end

function Gfx.draw(name, x, y)
	local asset = assets[name]
	if asset then
		love.graphics.draw(asset, x, y)
	end
end

function Gfx.drawAll(assetsTable)
	for i,asset in ipairs(assetsTable) do
		Gfx.draw(asset.img, asset.x, asset.y)
	end
end