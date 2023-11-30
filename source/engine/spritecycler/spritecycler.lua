import "sprites"
import "chunks"

class("SpriteCycler").extends()

local generationConfig = { left = 1, right = 2}

function SpriteCycler:init(chunkLength, recycledSpriteIds, createSpriteCallback)
	self.data = {}
	self.chunksLoaded = {}
	self.spritesToRecycle = {}
	self.chunkLength = chunkLength
	self.recycledSpriteIds = recycledSpriteIds
	self.createSpriteCallback = createSpriteCallback
end

-- Level Data

-- Returns the chunk where the first sprite with id is found. Useful for getting the starting chunk of a level.
function SpriteCycler:getFirstInstanceChunk(id)
	for k, chunk in pairs(self.data) do
		for _, object in pairs(chunk[1]) do
			if object.id == id then
				return k
			end
		end
	end
end

function SpriteCycler:hasLoadedInitialLevel()
	return self.data ~= nil
end

function SpriteCycler:load(objects)
	
	-- Load chunks from level config
	
	local chunksData = getChunksDataForLevel(objects, self.chunkLength)
	
	-- Create Empty chunks if needed
	
	fillEmptyChunks(chunksData)
	
	-- Load item IDs for recycling sprites
	for _, v in pairs(self.recycledSpriteIds) do
		self.spritesToRecycle[v] = {}
	end
	
	self.data = chunksData
end

function SpriteCycler:preloadSprites(...)
	local spriteIdCountPairs = {...}
	for _, v in pairs(spriteIdCountPairs) do
		local id = v.id
		local count = v.count
		
		for i=1,count do
			createRecycledSprite(self, id)
		end
	end
end

-- Lifecycle

function SpriteCycler:loadInitialSprites(initialChunkX, initialChunkY, loadIndex)
	local chunksToLoad = chunksToGenerate(initialChunkX, generationConfig)
	
	-- load Sprites In Chunk If Needed
	
	local _, _ = loadSpritesInChunksIfNeeded(self, chunksToLoad, loadIndex)
	self.chunksLoaded = chunksToLoad
end

function SpriteCycler:update(drawOffsetX, drawOffsetY, loadIndex)
	-- Convert to grid coordinates
	local drawOffsetX, drawOffsetY = (-drawOffsetX / kGame.gridSize), (drawOffsetY / kGame.gridSize)
	
	--
	
	local currentChunk = math.ceil(drawOffsetX / self.chunkLength) 
	local chunksShouldLoad = chunksToGenerate(currentChunk, generationConfig)
	
	-- Get chunks to unload
	
	local chunksToLoad = {}
	for _, chunk in pairs(chunksShouldLoad) do
		if chunkExists(self, chunk, 1) and not table.contains(self.chunksLoaded, chunk) then
			table.insert(chunksToLoad, chunk)
		end
	end
	
	local chunksToUnload = {}
	for _, chunk in pairs(self.chunksLoaded) do
		if chunkExists(self, chunk, 1) and not table.contains(chunksShouldLoad, chunk) then
			table.insert(chunksToUnload, chunk)
		end
	end
	
	if (#chunksToLoad > 0) or (#chunksToUnload > 0) then
		-- Load and Unload
		
		local _ = unloadSpritesInChunksIfNeeded(self, chunksToUnload, loadIndex)
		local _, _ = loadSpritesInChunksIfNeeded(self, chunksToLoad, loadIndex)
	end
end

function SpriteCycler:unloadAll()
	local count = unloadSpritesInChunksIfNeeded(self, self.chunksLoaded, loadIndex)
	print("Unloaded ".. count.. " sprites from level.")
	self.chunksLoaded = {}
	
	self.data = {}
	self.chunksLoaded = {}
	self.spritesToRecycle = {}
end