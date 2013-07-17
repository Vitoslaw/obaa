require "addons/switch"
require "addons/ifHover"

require "events_control"

require "scene"

require "physics"
require "physics_equasions"

require "objects"
require "graphics_control"

require "events_control"


function love.load()

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()

	clockOn = false
	clock = 0

	dofile("configuration.lua")
	dofile("install_info.lua")
	
	dofile("resources/units.lua")


	LoadGraphics()
	LoadKeybinds()
	LoadScenes()
	
end

function love.update(elapsed)
	if clockOn then clock = clock + elapsed end

	UpdateScene(elapsed)
end

function love.draw()
	love.graphics.setBackgroundColor(0xDC,0xCF,0xA5)

	DrawScene()
	
	
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
