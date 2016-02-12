Gfx = {}

local assets = {}

function Gfx.load(name, path)
	local asset = love.graphics.newImage(path)
	assets[name] = asset
end

function Gfx.loadSprite(name, path, offsetX, offsetY, tileW, tileH)
	local asset = love.graphics.newImage(path)
	asset:setFilter('nearest', 'nearest')
	assets[name] = {
		img = asset, 
		offsetX = offsetX, 
		offsetY = offsetY,
		tileW = tileW,
		tileH = tileH
	}
end

function Gfx.drawSprite(name, posX, posY, column, row, zoom, flipX, rot)
	-- print(name, posX, posY, row, column, zoom)
	
	if zoom == nil then zoom = 1 end
	if rot == nil then rot = 0 end

	local spriteAsset = assets[name]

	local tilesetW = spriteAsset.img:getWidth()
	local tilesetH = spriteAsset.img:getHeight()

	local offX = spriteAsset.offsetX + (column * spriteAsset.tileW)
	local offY = spriteAsset.offsetY + (row * spriteAsset.tileH)

	-- print(offX,  offY, spriteAsset.tileW, spriteAsset.tileH, tilesetW, tilesetH)
	local spriteQuad = love.graphics.newQuad(offX, offY, spriteAsset.tileW, spriteAsset.tileH, tilesetW, tilesetH)

	local scaleX, scaleY = zoom, zoom
	if flipX then 
		scaleX = scaleX * -1
		posX = posX + (zoom * spriteAsset.tileW)
	end

	love.graphics.draw(
		spriteAsset.img, -- texture
		spriteQuad, -- quad
		posX, -- x
		posY, -- y
		math.rad(rot), -- r
		scaleX, -- sx
		scaleY -- sy
	)

end

function Gfx.draw(name, posX, posY, zoom, flipX, rot)
	if zoom == nil then zoom = 1 end
	if rot == nil then rot = 0 end

	local asset = assets[name]

	asset:setFilter('nearest', 'nearest')
	
	local scaleX, scaleY = zoom, zoom

	
	love.graphics.draw(
		asset, -- texture
		posX, -- x
		posY, -- y
		math.rad(rot), -- r
		scaleX, -- sx
		scaleY -- sy
	)
	
end

function Gfx.drawAll(assetsTable)
	for i,asset in ipairs(assetsTable) do
		Gfx.draw(asset.img, asset.x, asset.y)
	end
end