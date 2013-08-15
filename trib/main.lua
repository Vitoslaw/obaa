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

require "events_database" 
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
	n = 0
	
	InitiateLoadScenes("default")
	
	objectFiles = love.filesystem.enumerate("resources/objects")
	dumb,objectFileNames = ipairs(objectFiles)	
	
	spritesData = love.filesystem.enumerate("resources/sprites")
	dumb,spriteFileNames = ipairs(spritesData)
	
	dir = "resources/sprites/GUI/"
	
	local pos1 = {}
	pos1.image = ImageNew(dir.."RCP_logo.png")
	local pos2 = {}
	pos2.image = ImageNew(dir.."love_logo.png")
	local pos3 = {}
	pos3.text = "Made with"
	pos3.alignment = "center"
	
	
	scenes.loadingMaster.objects = {l1 = {
		backgrounColor = object.new({event = function() if clock < 5 then love.graphics.setBackgroundColor(0x34,0x5b,0x82) elseif clock < 10 then scenes.activeScene.objects.l1.loadingInfo.color = black255 love.graphics.setBackgroundColor(0xff,0xff,0xff) else love.graphics.setBackgroundColor(0,0,0) end end}),

		logo1 = object.new({x = 260, y = 120, pose = pos1, event = effects.fadeOut(0,2,3,5)}),
		logo2 = object.new({x = 133, y = 120, pose = pos2, event = effects.fadeOut(5,7,8,10)}),
		text = object.new({x = 0, y = 100, color = black255, pose = pos3, event = effects.fadeOut(5,7,8,10)}),

		loadingInfo = object.new({x = 0, y = 340, pose = {},
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
							cache.loadingState = nil
							if clock > 10 then love.graphics.setNewFont("8bitlim.ttf",24) events._toScene("boot") end
						end
					end
				end

				if cache.loadingState then
					self.pose.text = "Loading "..cache.loadingState
				else
					self.pose.text = nil
				end

			end})
	}}
	
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
	for m,n in pairs(scenes.activeScene.objects.l1.logo1) do
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
