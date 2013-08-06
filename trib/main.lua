require "io_control"
require "install"

require "addons/switch"
require "addons/ifHover"

require "resolution_control"

require "default_configuration"

require "scene_control"

require "objects_control"

require "graphics_control"

require "events_control" 
require "AI_control"
require "input_control"


function love.load()
	love.graphics.setBackgroundColor(0x34,0x5b,0x82)
	love.graphics.setDefaultImageFilter("nearest","nearest")

	InstallData()

	if love.filesystem.exists("configuration.lua") then
		dofile(love.filesystem.getSaveDirectory().."configuration.lua")

		LoadResolution()
	end

	love.graphics.setNewFont("8bitlim.ttf",24)

	clockOn = true
	clock = 0

	cache = {}

	LoadGraphics()
	LoadKeybinds()
	LoadObjects()
	LoadScenes("default")
end

function love.update(elapsed)
	if clockOn then clock = clock + elapsed end

	UpdateScene(elapsed)
end

function love.draw()
	TranslateScreen()
	
	DrawScene()

	--[[###DEBUG CODE###

	love.graphics.print(love.graphics.getHeight()/360,0,0)

	--###DEBUG CODE###]]

	--[[###DEBUG CODE###

	local shift = 0

	for m,tab in pairs(spritesData) do
		--for k,v in pairs(tab.pose) do 
			love.graphics.print(tostring(m).." : "..tostring("resources/sprites/"..tab),0,shift)
			shift = shift + 20
		--end
	end
	
	--###DEBUG CODE###]]
end

function love.keypressed(key)
	OnKeyPressScene(key)
	DebugControl(key)
end

function love.keyreleased(key)
	OnKeyReleaseScene(key)
end

function love.mousepressed(x, y, key)
	OnMousePressScene(key, x, y)
end

function love.mousereleased(x, y, key)
	OnMouseReleaseScene(key, x, y)
end

function love.quit()
	--return true
end
