import "levelSelect/entry"
import "levelSelect/preview"

class("LevelSelect").extends(Widget)

function LevelSelect:init()
	self:supply(Widget.kDeps.state)
	self:supply(Widget.kDeps.children)
	
	self:setStateInitial({1, 2, 3, 4}, 1)
	
	self.painters = {}
	self.images = {}
	
	self.samples = {}
	
	self.hidden = false
end

function LevelSelect:_load()
	self.samples.select = playdate.sound.sampleplayer.new(kAssetsSounds.menuSelect)
	self.samples.selectFail = playdate.sound.sampleplayer.new(kAssetsSounds.menuSelectFail)
	
	self.entries = {
		Widget.new(LevelSelectEntry, { text = "MOUNTAIN" }),
		Widget.new(LevelSelectEntry, { text = "SPACE" }),
		Widget.new(LevelSelectEntry, { text = "CITY" }),
		Widget.new(LevelSelectEntry, { text = "SETTINGS", showOutline = false })
	}
	
	self.children.entry1 = self.entries[1]
	self.children.entry2 = self.entries[2]
	self.children.entry3 = self.entries[3]
	self.children.entry4 = self.entries[4]
	self.children.preview = Widget.new(LevelSelectPreview)
	
	self.images.screw1 = playdate.graphics.image.new(kAssetsImages.screw)
	self.images.screw2 = playdate.graphics.image.new(kAssetsImages.screw):rotatedImage(45)
	self.images.screw3 = playdate.graphics.image.new(kAssetsImages.screw):rotatedImage(90)
	
	self.painters.background = Painter(function(rect)
		playdate.graphics.setColor(playdate.graphics.kColorWhite)
		playdate.graphics.fillRect(rect.x, rect.y, rect.w, rect.h)
	end)
	
	local painterCardOutline = Painter(function(rect)
		playdate.graphics.setColor(playdate.graphics.kColorBlack)
		playdate.graphics.setDitherPattern(0.7, playdate.graphics.image.kDitherTypeDiagonalLine)
		playdate.graphics.fillRoundRect(rect.x, rect.y, rect.w, rect.h, 8)
		
		local rectInset = Rect.inset(rect, 10, 14)
		
		playdate.graphics.setColor(playdate.graphics.kColorBlack)
		playdate.graphics.setDitherPattern(0.3, playdate.graphics.image.kDitherTypeDiagonalLine)
		playdate.graphics.setLineWidth(3)
		playdate.graphics.drawRoundRect(rectInset.x - 4, rectInset.y - 1, rectInset.w, rectInset.h, 6)
		
		playdate.graphics.setColor(playdate.graphics.kColorWhite)
		playdate.graphics.fillRoundRect(rectInset.x - 3, rectInset.y, rectInset.w, rectInset.h, 6)
		
		local size = self.images.screw1:getSize()
		self.images.screw2:draw(rect.x + 4, rect.y + 4)
		self.images.screw3:draw(rect.x + rect.w - size - 4, rect.y + 4)
		self.images.screw1:draw(rect.x + 4, rect.y + rect.h - size - 4)
		self.images.screw2:draw(rect.x + rect.w - size - 4, rect.y + rect.h - size - 4)
	end)
	
	self.painters.card = Painter(function(rect)
		-- Painter background
		
		playdate.graphics.setColor(playdate.graphics.kColorBlack)
		playdate.graphics.setDitherPattern(0.1, playdate.graphics.image.kDitherTypeDiagonalLine)
		playdate.graphics.fillRoundRect(rect.x, rect.y, rect.w, rect.h, 8)
		
		playdate.graphics.setColor(playdate.graphics.kColorWhite)
		playdate.graphics.fillRoundRect(rect.x, rect.y, rect.w, rect.h, 8)
		
		painterCardOutline:draw(rect)
	end)
	
	for _, child in pairs(self.children) do
		child:load()
	end
end

function LevelSelect:_draw(rect)
	local width = 220
	
	self.painters.card:draw(Rect.offset(Rect.with(rect, { w = width }), -self.animators.card:currentValue(), 0))
	
	for i, entry in ipairs(self.entries) do
 		entry:draw(Rect.make(rect.x - 5 - self.animators.card:currentValue(), rect.y + i * 45 - 25, width, 40))
	end
	
	self.children.preview:draw(Rect.with(rect, { x = width, w = rect.w - width }))
end

function LevelSelect:_update()
	if self.animators == nil then
		self.animators = {}
		self.animators.card = playdate.graphics.animator.new(800, 240, 0, playdate.easingFunctions.outExpo, 1500)
	end
	
	-- TODO: Add Crank
	local scrollUp = playdate.buttonJustPressed(playdate.kButtonUp)
	local scrollDown = playdate.buttonJustPressed(playdate.kButtonDown)
	
	if scrollUp then
		if self.state > 1 then
			self:setState(self.state - 1)
			
			self.samples.select:play()
		else
			self.samples.selectFail:play()
			self.animators.card = playdate.graphics.animator.new(50, 5, 0, playdate.easingFunctions.outExpo)
		end
	end
	
	if scrollDown then
		if self.state < #self.entries then
			self:setState(self.state + 1)
			
			self.samples.select:play()
		else
			self.samples.selectFail:play()
			self.animators.card = playdate.graphics.animator.new(50, 5, 0, playdate.easingFunctions.outExpo)
		end
	end
	
	for i, entry in ipairs(self.entries) do
		if i == self.state then
			entry:setState({ selected = true })
		elseif entry.state.selected == true then
			entry:setState({ selected = false })
		end
	end
end

function LevelSelect:changeState(_, stateTo)
	
end