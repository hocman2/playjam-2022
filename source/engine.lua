import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "CoreLibs/animation"
import "CoreLibs/animator"
import "CoreLibs/easing"

import "engine/lib"
import "extensions"
import "params"

-- Libraries

geometry = playdate.geometry
gfx = playdate.graphics
timer = playdate.timer
sprite = playdate.sprite
sound = playdate.sound

-- Shortcuts

easingFunctions = playdate.easingFunctions

collisionTypes = {
	slide = gfx.sprite.kCollisionTypeSlide,
	overlap = gfx.sprite.kCollisionTypeOverlap,
	freeze = gfx.sprite.kCollisionTypeFreeze,
	bounce = gfx.sprite.kCollisionTypeBounce,
}

buttons = {
	isLeftButtonPressed = function() return playdate.buttonIsPressed(playdate.kButtonLeft) end,
	isRightButtonPressed = function() return playdate.buttonIsPressed(playdate.kButtonRight) end,
	isDownButtonPressed = function() return playdate.buttonIsPressed(playdate.kButtonDown) end,
	isUpButtonPressed = function() return playdate.buttonIsPressed(playdate.kButtonUp) end,
	isAButtonPressed = function() return playdate.buttonIsPressed(playdate.kButtonA) end,
	isBButtonPressed = function() return playdate.buttonIsPressed(playdate.kButtonB) end,
	isLeftButtonJustPressed = function() return playdate.buttonJustPressed(playdate.kButtonLeft) end,
	isRightButtonJustPressed = function() return playdate.buttonJustPressed(playdate.kButtonRight) end,
	isDownButtonJustPressed = function() return playdate.buttonJustPressed(playdate.kButtonDown) end,
	isUpButtonJustPressed = function() return playdate.buttonJustPressed(playdate.kButtonUp) end,
	isAButtonPressed = function() return playdate.buttonJustPressed(playdate.kButtonA) end,
	isBButtonPressed = function() return playdate.buttonJustPressed(playdate.kButtonB) end,
	left = playdate.kButtonLeft,
	right = playdate.kButtonRight,
	down = playdate.kButtonDown,
	up = playdate.kButtonUp,
	a = playdate.kButtonA,
	b = playdate.kButtonB
}

textAlignment = {
	center = playdate.kTextAlignmentCenter,
	left = playdate.kTextAlignmentLeft,
	right = playdate.kTextAlignmentRight
}

-- Custom Types

spriteTypes = {
	coin = "Coin",
	wheel = "Wheel",
	floor = "Floor"
}

sceneTypes = {
	gameOver = "GameOverScene",
	gameScene = "GameScene"
}
