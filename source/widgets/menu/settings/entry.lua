local gfx <const> = playdate.graphics
class("WidgetMenuSettingsEntry").extends(Widget)

-- Special chars: ◁ ◀ ▶ ▷

function WidgetMenuSettingsEntry:init(config)
	self.config = config
	
	self:supply(Widget.deps.keyValueState)
	self:supply(Widget.deps.input)
	self:supply(Widget.deps.samples)
	
	local isSelected = config.isSelected == true and 1 or 2
	local value = config.value ~= nil and config.value or (config.options ~= nil) and config.options[1] or nil
	
	self:setStateInitial(
		{
			isSelected = { selected = 1, unselected = 2 },
			value = config.options
		},
		{ 
			isSelected = isSelected,
			value = value
		}
	)
	
	self.painters = {}
	self.signals = {}
end

function WidgetMenuSettingsEntry:_load()
	self.painters.title = Painter(function(frame, state)
		if state.isSelected == true then
			local rectInset = Rect.inset(frame, 1, 1)
			gfx.setColor(gfx.kColorBlack)
			gfx.setLineWidth(2)
			gfx.drawRoundRect(rectInset.x, rectInset.y, rectInset.w, rectInset.h, 6)
		end
		
		local font = gfx.font.new(kAssetsFonts.twinbee2x)
		local fontHeight = font:getHeight()
		gfx.setFont(font)
		gfx.drawText(self.config.title, frame.x + 8, frame.y + (frame.h - fontHeight) / 2)
		gfx.setFont(gfx.font.new(kAssetsFonts.twinbee))
	end)
	
	if self.config.type == WidgetMenuSettings.type.options then
		self.painters.value = Painter(function(frame, state)
			local font = gfx.font.new(kAssetsFonts.twinbee2x)
			local fontHeight = font:getHeight()
			gfx.setFont(font)
			gfx.drawTextAligned("◁ "..state.value.." ▷", frame.x + frame.w - 8, frame.y + (frame.h - fontHeight) / 2, kTextAlignment.right)
			gfx.setFont(gfx.font.new(kAssetsFonts.twinbee))
		end)
	end
	
	self:loadSample(kAssetsSounds.menuSelect)
	self:loadSample(kAssetsSounds.menuSelectFail)
	self:loadSample(kAssetsSounds.menuAccept)
end

function WidgetMenuSettingsEntry:_draw(frame, rect)
	self.painters.title:draw(frame, { isSelected = self.state.isSelected == self.kStates.isSelected.selected })
	
	if self.config.type == WidgetMenuSettings.type.options then
		self.painters.value:draw(frame, { value = self.state.value })
	end
end

function WidgetMenuSettingsEntry:_update()
	
end

function WidgetMenuSettingsEntry:_handleInput(input)
	if self.config.type == WidgetMenuSettings.type.button then
		if input.pressed & playdate.kButtonA ~= 0 then
			self.signals.onChanged()
		end
	end
	
	if self.config.type == WidgetMenuSettings.type.options then
		if input.pressed & playdate.kButtonLeft ~= 0 then
			local index = table.indexOfElement(self.config.options, self.state.value)
			if index > 1 then
				self:setState(self.kStateKeys.value, self.kStates.value[index - 1])
				self.signals.onChanged(self.kStates.value[index - 1])
				
				gfx.sprite.addDirtyRect(0, 0, 400, 240)
				
				self:playSample(kAssetsSounds.menuSelect)
			else
				self:playSample(kAssetsSounds.menuSelectFail)
			end
		elseif input.pressed & playdate.kButtonRight ~= 0 then
			local index = table.indexOfElement(self.config.options, self.state.value)
			if index < #self.config.options then
				self:setState(self.kStateKeys.value, self.kStates.value[index + 1])
				self.signals.onChanged(self.kStates.value[index + 1])
				
				gfx.sprite.addDirtyRect(0, 0, 400, 240)
				
				self:playSample(kAssetsSounds.menuSelect)
			else
				self:playSample(kAssetsSounds.menuSelectFail)
			end
		end
	end
end

function WidgetMenuSettingsEntry:_unload()
	self.samples = nil
	self.painters = nil
end