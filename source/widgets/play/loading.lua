import "common/painters/background"

class("WidgetLoading").extends(Widget)

function WidgetLoading:init()
	self.painters = {}
	self.images = {}
	
	self.counter = 1
end

function WidgetLoading:_load()
	self.images.wheel = playdate.graphics.imagetable.new(kAssetsImages.wheel)
	self.images.text = playdate.graphics.imageWithText("LOADING...", 250, 25):scaledImage(2):invertedImage()
	
	self.painters.background = PainterBackground()
	
	self.painters.wheel = Painter(function(rect, state)
		self.images.wheel:getImage(state.count):invertedImage():draw(rect.x, rect.y)
	end)
	
	-- Loading timer
	
	self.loadingImageTimer = playdate.timer.new(100)
	self.loadingImageTimer.discardOnCompletion = false
	self.loadingImageTimer.repeats = true
	
	self.loadingImageTimer.timerEndedCallback = function(timer)
		self.counter -= 1
		
		if self.counter < 1 then
			self.counter = 12
		end
	end
end

function WidgetLoading:_draw(rect)
	self.painters.background:draw(rect)
	
	local wheelImageSize = self.images.wheel:getImage(1):getSize()
	self.painters.wheel:draw(Rect.make(rect.x + 25, Rect.bottom(rect) - wheelImageSize - 25, wheelImageSize, wheelImageSize), {count = self.counter})
	
	local _, textImageHeight = self.images.text:getSize()
	self.images.text:draw(rect.x + wheelImageSize + 25 + 15, Rect.bottom(rect) - textImageHeight - 25)
end

function WidgetLoading:_update()
	
end