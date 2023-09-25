import "extensions"
import "chunks"

function spritePositionData(object)
	return {
		id = object.id,
		position = {
			x = object.position.x,
			y = object.position.y,
		},
		config = object.config,
		isActive = false,
		sprite = nil
	}
end

function loadSpritesInChunksIfNeeded(self, chunksToLoad)
	local count = 0
	
	for _, chunk in pairs(chunksToLoad) do
		if chunkExists(self, chunk, 1) and not table.contains(self.chunksLoaded, chunk) then
			-- Load chunk
			local chunkData = self.data[chunk][1]
			
			for _, object in pairs(chunkData) do
				object.sprite = self.createSpriteCallback(object.id, object.position, object.config, nil)
				
				count += 1
			end
			
			table.insert(self.chunksLoaded, chunk)
		end
	end
	
	return count
end

function unloadSpritesInChunksIfNeeded(self, chunksToUnload)
	local count = 0
	
	for _, chunk in pairs(chunksToUnload) do
		if chunkExists(self, chunk, 1) and table.contains(self.chunksLoaded, chunk) then
			local chunkData = self.data[chunk][1]
			
			for _, object in pairs(chunkData) do
				if object.sprite ~= nil then
					object.sprite:remove()
					object.sprite = nil
					
					count += 1
				end
			end
			
			table.removevalue(self.chunksLoaded, chunk)
		end
	end
	
	return count
end
