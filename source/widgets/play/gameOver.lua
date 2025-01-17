import "widgets/common/entriesMenu"

local gfx <const> = playdate.graphics

class("WidgetGameOver").extends(Widget)

function WidgetGameOver:init(config)
	self.config = config
	
	self.painters = {}
	self.images = {}
	
	self:createSprite(kZIndex.overlay)
	
	self.signals = {}

end

function WidgetGameOver:_load()
	gfx.setColor(gfx.kColorBlack)
	self.images.gameOverText = gfx.imageWithText("GAME OVER", 100, 70):scaledImage(3)
	self.images.gameOverReason = gfx.imageWithText(self.config.reason, 150, 70)
	
	self.painters.background = Painter(function(rect)
		gfx.setColor(gfx.kColorBlack)
		gfx.fillRect(rect.x, rect.y, rect.w, rect.h)
	end)
	
	self.painters.content = Painter(function(rect)
		gfx.setColor(gfx.kColorWhite)
		gfx.fillRoundRect(rect.x, rect.y, rect.w, rect.h, 8)
		
		gfx.setColor(gfx.kColorBlack)
		local gameOverTextSizeW, gameOverTextSizeH = self.images.gameOverText:getSize()
		local gameOverTextCenterRect = Rect.center(Rect.size(gameOverTextSizeW, gameOverTextSizeH), rect)
		self.images.gameOverText:draw(gameOverTextCenterRect.x, rect.y + 12)
		
		local gameOverReasonSizeW, gameOverReasonSizeH = self.images.gameOverReason:getSize()
		local gameOverReasonCenterRect = Rect.center(Rect.size(gameOverReasonSizeW, gameOverReasonSizeH), rect)
		gfx.setColor(gfx.kColorBlack)
		self.images.gameOverReason:draw(gameOverReasonCenterRect.x, rect.y + 47)
	end)
	
	self.children.entriesMenu = Widget.new(WidgetEntriesMenu, {
		entries = {
			"CHECKPOINT",
			"RESTART LEVEL",
			"LEVEL SELECT"
		},
		scale = 2
	})
	self.children.entriesMenu:load()
	
	self.children.entriesMenu.signals.entrySelected = function(entry)
		if entry == 1 then
			self.signals.restartCheckpoint()
		elseif entry == 2 then
			self.signals.restartLevel()
		elseif entry == 3 then
			self.signals.returnToMenu()
		end
	end
end

function WidgetGameOver:_draw(rect)
	self.painters.background:draw(rect)
	
	local insetRect = Rect.inset(rect, 30, 30)
	self.painters.content:draw(insetRect)
	
	self.children.entriesMenu:draw(Rect.inset(insetRect, 10, 60, nil, 15))
end

function WidgetGameOver:_update()
	
end

function WidgetGameOver:_unload()
	self.sprite:remove()
	
	self.images = nil
	self.painters = nil
	
	for _, child in pairs(self.children) do child:unload() end
	self.children = nil
end