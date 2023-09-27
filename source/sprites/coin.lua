import "engine"

class('Coin').extends(Sprite)

function Coin.new() 
	return Coin()
end

function Coin:init()
	Coin.super.init(self)
	
	local image = gfx.image.new(kImages.coin)
	self:setImage(image)
	self:setCenter(0, 0)
	self.type = spriteTypes.coin
	
	self.hasBeenGrabbed = false
	
	self:setCollideRect(0, 0, self:getSize())
end

function Coin:loadConfig(config)
	Coin.super.loadConfig(self, config)
	
	if config.isPicked == nil then
		config.isPicked = false
		
		print("WARNING: [Coin:loadConfig] - no config value for 'isPicked'! Setting default value...")
	end
	
	self.hasBeenGrabbed = config.isPicked
	self:updateVisible(not self.hasBeenGrabbed)
end

function Coin:updateConfig(config)
	config.isPicked = self.hasBeenGrabbed
end

function Coin:reset()
	self.hasBeenGrabbed = false
	
	self:updateVisible(not self.hasBeenGrabbed)
end

function Coin:isGrabbed()
	self.hasBeenGrabbed = true
	self:updateVisible(not self.hasBeenGrabbed)
end

function Coin:updateVisible(isVisible)
	self:setVisible(isVisible)
end