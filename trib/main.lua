require "io_control"
require "install"

require "addons/switch"
require "addons/rmFolder"
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
	cache = {}

	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setDefaultImageFilter("nearest","nearest")

	InstallData()

	if love.filesystem.exists("configuration.lua") then
		local chunk = love.filesystem.load("configuration.lua")
		chunk()

		LoadResolution()
	end

	clockOn = true
	clock = 0

	scenes = {}

	scenes.loadingMaster = scene.new({l1 = true})
--	pos.image = love.graphics.newImage("resources/sprites/GUI/loading_anim.png")
	n = 0
	
	InitiateLoadScenes("default")
	
	objectFiles = love.filesystem.enumerate("resources/objects")
	dumb,objectFileNames = ipairs(objectFiles)	
	
	spritesData = love.filesystem.enumerate("resources/sprites")
	dumb,spriteFileNames = ipairs(spritesData)
	
	
	LoadKeybinds()
	
	scenes.loadingMaster.objects = {l1 = {animatedimage = object.new({x = 0, y = 340, pose ={},
	event = function(self)
		n = n + 1 
		if spriteFileNames[n] then
			cache.loadingState = "resources/sprites/"..spriteFileNames[n]
		elseif objectFileNames[n-m] then 
			cache.loadingState = "resources/objects/"..objectFileNames[n-m]
		elseif sceneFileNames[n-f] then
			cache.loadingState = "saves/default/"..sceneFileNames[n-f]
		end
		
		if LoadGraphics(n) then
			if LoadObjects(n-m) then
				if LoadScenes(n-f) then
					--love.graphics.setNewFont("8bitlim.ttf",24)
					events._toScene("boot")
				end 
			end 
		end 
		
		self.pose.text = "Loading "..cache.loadingState
		
		end})}}
	
	scenes.activeScene = scenes.loadingMaster
	cache.activeScene = "loadingMaster"
end

function love.update(elapsed)
	if clockOn then clock = clock + elapsed end

	UpdateScene(elapsed)
end

function love.draw()
	TranslateScreen()
	
	DrawScene()

	love.graphics.setColor(0xff,0xff,0xff,0xff)
	--[[###DEBUG CODE###

	love.graphics.print(tostring(cache.wait),0,0)

	--###DEBUG CODE###]]

	--[[###DEBUG CODE###

	local shift = 0
	--if cache.debug then
	for m,n in pairs(scenes.activeScene.objects.l1.logo) do
		--for k,v in pairs(n) do 
			love.graphics.print(tostring(m).." : "..tostring(n),0,shift)
			shift = shift + 20
		--end
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
