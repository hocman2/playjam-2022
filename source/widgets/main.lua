import "engine"
import "menu"

class("WidgetMain").extends(Widget)

function WidgetMain:init()	
	self:supply(Widget.kDeps.children)
	self:supply(Widget.kDeps.state)
	
	self.kStates = { menu = 1, play = 2 }
	self.state = self.kStates.menu
end

function WidgetMain:_load()
	self.children.menu = Widget.new(WidgetMenu)
	self.children.menu:load()
end

function WidgetMain:_draw(rect)
	if self:isLoaded() == false then 
		playdate.graphics.setColor(playdate.graphics.kColorBlack)
		playdate.graphics.fillRect(0, 0, 400, 240)
		playdate.graphics.setColor(playdate.graphics.kColorWhite)
		
		local loadingText = playdate.graphics.imageWithText("LOADING...", 120, 20):scaledImage(2):invertedImage()
		local loadingTextRect = Rect.size(loadingText:getSize())
		local displayRect = Rect.size(playdate.display.getSize())
		local centerRect = Rect.center(loadingTextRect, displayRect)
		loadingText:draw(centerRect.x, centerRect.y)
	end
	
	if (self:isLoaded() == true) and (self.state == self.kStates.menu) then
		self.children.menu:draw(rect)
	end
end

function WidgetMain:_update()
end

function WidgetMain:_input()
	
end