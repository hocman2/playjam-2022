import "engine"
import "constant"

local gfx <const> = playdate.graphics

class('Platform').extends(gfx.sprite)

local platformImage

function Platform.new() 
	return Platform()
end

function Platform:init()
	if platformImage == nil then
		platformImage = gfx.image.new(kAssetsImages.platform)
	end
	
	Platform.super.init(self, platformImage)
	self.type = kSpriteTypes.platform
	
	self:setCollideRect(0, 0, self:getSize())
	self:setCenter(0, 0)
	
	self:setOpaque(true)
	
	self:setUpdatesEnabled(false)
	self:setGroupMask(kCollisionGroups.static)
end
