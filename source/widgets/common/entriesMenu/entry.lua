import "utils/value"

class("WidgetEntriesMenuEntry").extends(Widget)

function WidgetEntriesMenuEntry:init(config)
	self.config = config
	
	self:supply(Widget.kDeps.state)
	self:setStateInitial({ unselected = 1, selected = 2 }, 1)
	
	self.images = {}
	self.painters = {}
end

function WidgetEntriesMenuEntry:_load()
	self.images.title = playdate.graphics.imageWithText(self.config.text, 200, 70):scaledImage(2)
	self.painters.circle = Painter(function(rect)
		playdate.graphics.drawCircleInRect(rect.x, rect.y, rect.w, rect.h)
		
		playdate.graphics.setDitherPattern(0.5, playdate.graphics.image.kDitherTypeDiagonalLine)
		playdate.graphics.fillCircleInRect(rect.x, rect.y, rect.w, rect.h)
	end)
end

function WidgetEntriesMenuEntry:_draw(rect)
	local insetRect = Rect.inset(rect, 28, 8, 5)
	
	self.images.title:draw(insetRect.x, insetRect.y)
	
	if self.state == self.kStates.selected then
		self.painters.circle:draw(Rect.with(Rect.inset(rect, 5, 5), { w = 15 }))
	end
end

function WidgetEntriesMenuEntry:_update()
	
end

function WidgetEntriesMenuEntry:setState(state)
	for k, v in pairs(state) do
		if self.state[k] ~= v then
			self:changeState(self.state, state)
			
			self.state[k] = v
		end
	end
end

function WidgetEntriesMenuEntry:changeState(stateFrom, stateTo)
	
end