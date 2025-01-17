import "assets"
import "constant"
import "engine"
import "sprites/lib"
import "config"
import "widgets"
import "utils/fonts"

local topLevelWidget

-- Globals table -- Use sparingly!
g = {
	showCrankIndicator = false
}

function initialize()
	setCurrentFontDefault(kAssetsFonts.twinbee)
	playdate.graphics.setFontTracking(1)
	
	topLevelWidget = Widget.new(WidgetMain)
	
	playdate.timer.performAfterDelay(1, function()
		topLevelWidget:load()
	end)
	
	playdate.setMinimumGCTime(2)
end

function playdate.update()
	math.randomseed(playdate.getSecondsSinceEpoch())
	topLevelWidget:update()
	playdate.graphics.sprite.update()
	playdate.timer.updateTimers()
	playdate.frameTimer.updateTimers()
	playdate.graphics.animation.blinker.updateAll()
	
	if g.showCrankIndicator ~= false then
		if playdate.ui.crankIndicator.bubbleX == nil then
			playdate.ui.crankIndicator:start()
		end
		
		playdate.ui.crankIndicator:update()
		
		g.showCrankIndicator = false
	end
end

-- Start game

initialize()
