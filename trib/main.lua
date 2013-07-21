require "io_control"
require "install"

require "addons/switch"
require "addons/ifHover"

require "default_configuration"

require "scene_control"

require "physics"
require "physics_equasions"

require "objects"
require "graphics_control"

require "events_control"
require "AI_control"
require "input_control"


function love.load()

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	
	clockOn = false
	clock = 0


	InstallData()

	LoadGraphics()
	LoadKeybinds()
	LoadScenes("default")
	
	dofile(love.filesystem.getSaveDirectory().."units.lua")
end

function love.update(elapsed)
	if clockOn then clock = clock + elapsed end

	UpdateScene(elapsed)
end

function love.draw()
	love.graphics.setBackgroundColor(0xDC,0xCF,0xA5)

	DrawScene()
	
	--[[###DEBUG CODE###
	
	love.graphics.print(dataFolder,0,0)
	
	--###DEBUG CODE###]]
	
	--[[###DEBUG CODE###
		
	local shift = 0
	for m,tab in pairs(choseMode.statics.l1.arenaButton.pose) do
		--for k,v in pairs(tab) do 
			love.graphics.print(tostring(m).." : "..tostring(tab),0,shift)
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
