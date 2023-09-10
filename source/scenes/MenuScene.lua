import "engine"
import "services/sprite/text"
import "level/levels"
import "level/theme"
import "menu/menu"
import "scenes"

class('MenuScene').extends(Scene)

local menu = nil

options = {
	{
		title = "PLAY",
		callback = function() startGame(1) end
	},
	{
		title = "SELECT LEVEL",
		menu = {
			{
				title = "1 COUNTRY",
				callback = function() startGame(1) end
			},
			{
				title = "2 SPACE",
				callback = function() startGame(2) end
			},
			{
				title = "3 CITY",
				callback = function() startGame(3) end
			},
		}
	},
	{
		title = "CUSTOM LEVELS"
	}
}

--------------------
-- Lifecycle Methods

function MenuScene:init()
	Scene.init(self)
end

function MenuScene:load()
	Scene.load(self)
	
	-- Draw Menu Background
	
	self:setCenter(0, 0)
	self:setImage(makeBackgroundImage())
	
	-- Create Menu Sprite
	
	menu = Menu(options)
	
	-- TODO: Load custom levels file names
end

function MenuScene:present()
	Scene.present(self)
	
	-- Print SpriteMenu Options
	
	menu:activate()
	menu:add()
end

function MenuScene:update() 
	Scene.update(self)
end

function MenuScene:dismiss()
	Scene.dismiss(self)
	
	menu:remove()
end

function MenuScene:destroy()
	Scene.destroy(self)
end

function startGame(level)
	loadAllScenes()
	
	print("Starting game with level: ".. level)
	
	currentTheme = level

	sceneManager:switchScene(scenes.game, function () end)
end

function makeBackgroundImage()	
	local image = gfx.image.new(400, 240)
	
	gfx.pushContext(image)
	
	-- Print Title Texts
	
	local titleTexts = {"WHEEL", "RUNNER"}
	local titleImages = table.imap(titleTexts, function (i) return createTextImage(titleTexts[i]):scaledImage(5) end)
	
	local startPoint = { x = 170, y = 136 }
	local endPoint = { x = 93, y = 189 }
	for i, image in ipairs(titleImages) do
		if i == 1 then
			image:draw(startPoint.x, startPoint.y)
		else
			image:draw(endPoint.x, endPoint.y)
		end
	end
	
	-- Wheel image
	
	local imageWheel = gfx.image.new("images/menu_wheel"):scaledImage(2)
	imageWheel:draw(5, 25)
	
	gfx.popContext()
	
	return image
end