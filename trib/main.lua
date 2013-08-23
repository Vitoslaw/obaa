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
	scenes = {}

	clockOn = true
	clock = 0
	
	nLoad = 0
	
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setDefaultImageFilter("nearest","linear")
	
	InitiateLoadScenes("default")
	objectFileNames = love.filesystem.enumerate("resources/objects")
	spriteFileNames = love.filesystem.enumerate("resources/sprites_data")
	
	InstallData()

	if love.filesystem.exists("configuration.lua") then
		local chunk = love.filesystem.load("configuration.lua")
		chunk()

		LoadResolution()
	end
	
	dir = "resources/sprites/GUI/"
	
	local pos1 = {}
	pos1.image = ImageNew(dir.."RCP_logo.png")
	local pos2 = {}
	pos2.image = ImageNew(dir.."love_logo.png")
	local pos3 = {}
	pos3.text = "Made with"
	pos3.alignment = "center"
	
	LoadAudio()
	--love.audio.play(CdE)
	
	love.audio.setVolume(0.5)
	
	scenes.loadingMaster = scene.new({l1 = true})
	scenes.loadingMaster.objects = {l1 = {
		backgrounColor = object.new({event = function() if clock < 5 then love.graphics.setBackgroundColor(0x34,0x5b,0x82) elseif clock < 10 then scenes.activeScene.objects.l1.loadingInfo.color = black255 love.graphics.setBackgroundColor(0xff,0xff,0xff) else love.graphics.setBackgroundColor(0,0,0) end end}),

		logo1 = object.new({x = 260, y = 120, pose = pos1, event = effects.fadeOut(0,2,3,5)}),
		logo2 = object.new({x = 133, y = 120, pose = pos2, event = effects.fadeOut(5,7,8,10)}),
		text = object.new({x = 0, y = 100, color = black255, pose = pos3, event = effects.fadeOut(5,7,8,10)}),

		loadingInfo = object.new({x = 0, y = 340, pose = {},
			event = function(self)
				nLoad = nLoad + 1
				if spriteFileNames[nLoad] then
					cache.loadingState = "resources/sprites/"..spriteFileNames[nLoad]
				elseif objectFileNames[nLoad-mLoad] then
					cache.loadingState = "resources/objects/"..objectFileNames[nLoad-mLoad]
				elseif sceneFileNames[nLoad-fLoad] then
					cache.loadingState = "saves/default/"..sceneFileNames[nLoad-fLoad]
				end

				if LoadGraphics(nLoad) then
					if LoadObjects(nLoad-mLoad) then
						if LoadScenes(nLoad-fLoad) then
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
	
	step = 1 / FPSLimit or 1 / 60
	timePast = love.timer.getMicroTime()
end

function love.update(elapsed)
	timePast = timePast + step

	if clockOn then clock = clock + elapsed end

	UpdateScene(elapsed)
end

function love.draw()
	TranslateScreen()
	
	DrawScene()

	love.graphics.setColor(0xff,0xff,0xff,0xff)
	
	if showFPS then
		love.graphics.print(love.timer.getFPS(),0,0)
	end
	
	--[[###DEBUG CODE###

	love.graphics.print(love.timer.getFPS(),0,0)

	--###DEBUG CODE###]]

	--[[###DEBUG CODE###

	local shift = 0
	--if cache.debug then
	for m,n in pairs(objectFileNames) do
		--for k,v in pairs(n) do 
			love.graphics.print(tostring(m).." : "..tostring(n),0,shift)
			shift = shift + 20
		--end
	--end
	end
	--###DEBUG CODE###]]
	
	local timeNow = love.timer.getMicroTime()
	if timePast <= timeNow then
		timePast = timeNow
		return
	end
	love.timer.sleep(timePast - timeNow)
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
