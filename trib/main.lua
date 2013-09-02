--[[

TO-DO :

fix letterBox(weird occupy boxes);
prepareArena(according to GIMP schematic);
saving system;


]]

function love.load()

require "io_control"
require "install"

require "addons/switch"
require "addons/rmFolder"
require "addons/ifHover"
require "addons/drawHitbox"
require "addons/extended_string"

require "resolution_control"

require "default_configuration"

require "scene_control"

require "objects_control"

require "graphics_control"

require "events_database" 
require "AI_control"
require "input_control"

	love.filesystem.load("debug.lua")()

--namespace
	cache = {}
	scenes = {}

--declarations
	clockOn = true
	clock = 0
	
	nLoad = 0

--graphics set-up
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setDefaultImageFilter("nearest","linear")

	local chunk = love.filesystem.load("configuration.lua")
	chunk()

	LoadResolution()
	TranslateScreen()

	fancyFont = love.graphics.newImageFont("resources/font/Imagefont.png"," abcdefghijklmnopqrstuvwxyz".."ABCDEFGHIJKLMNOPQRSTUVWXYZ0".."123456789.,!?-+/():;%&`'*#=[]\"")
	standardFont = love.graphics.newFont(14 + math.floor(7 * (scale - 1)))
	
	activeFont = standardFont

--loading scene
	InitiateLoadScenes("default")
	objectFileNames = love.filesystem.enumerate("resources/objects")
	spriteFileNames = love.filesystem.enumerate("resources/sprites_data")
	
	
--development (chose one)
	ExtractMode() --use files from userfolder
	--InstallData()
--/development
	
	dir = "resources/sprites/GUI/"
	
	LoadAudio()
	--love.audio.play(CdE)
	
	love.audio.setVolume(0.5)
	
	scenes.loadingMaster = scene.new({l1 = false})
	scenes.loadingMaster.objects = {l1 = {
		backgrounColor = object.new({event = function() if clock < 5 then love.graphics.setBackgroundColor(0x34,0x5b,0x82) elseif clock < 10 then activeScene.objects.l1.loadingInfo.color = black255 love.graphics.setBackgroundColor(0xff,0xff,0xff) else love.graphics.setBackgroundColor(0,0,0) end end}),

		logo1 = object.new({x = 260, y = 120, pose = PoseNew({image = ImageNew(dir.."RCP_logo.png")}), event = effects.fadeOut(0,2,3,5)}),
		logo2 = object.new({x = 133, y = 120, pose = PoseNew({image = ImageNew(dir.."love_logo.png")}), event = effects.fadeOut(5,7,8,10)}),
		text = object.new({x = 0, y = 100, color = black255, pose = PoseNew({text = "Made with",alignment = "center"}), event = effects.fadeOut(5,7,8,10)}),

		loadingInfo = object.new({x = 0, y = 340, pose = PoseNew({}),
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
							if clock > 10 then activeFont = fancyFont events._toScene("boot") end
						end
					end
				end

				if cache.loadingState then
					self.pose.text = "Loading "..cache.loadingState
				else
					self.pose.text = nil
				end

			end}),
			
		keyboardControl = object.new({
			keybind = KeybindNew(
				{any = function() if not cache.loadingState and clock > 1 then activeFont = fancyFont events._toScene("boot") end end},
				{any = function() if not cache.loadingState and clock > 1 then activeFont = fancyFont events._toScene("boot") end end}
			)
		})
	}}
	
	activeScene = scenes.loadingMaster
	cache.activeScene = "loadingMaster"

--fps limiter
	step = 1 / FPSLimit or 1 / 60
	timePast = love.timer.getMicroTime()
end

function love.update(elapsed)
	timePast = timePast + step

	TranslateScreen()
	
	if clockOn then clock = clock + elapsed end

	UpdateScene(elapsed)
end

function love.draw()
	DrawScene()

	love.graphics.setColor(0,0,0,0xff)
	
	love.graphics.rectangle("fill", 0, 0, 640 * scale, yLetter)
	love.graphics.rectangle("fill", 0, 0, xLetter, 360 * scale)
	love.graphics.rectangle("fill", 640 * scale, love.graphics.getHeight(), -640 * scale, -yLetter)
	love.graphics.rectangle("fill", love.graphics.getWidth(), 360 * scale, -xLetter, -360 * scale)

	love.graphics.setColor(0xff,0xff,0xff,0xff)

	DebugScreen()
	
	local timeNow = love.timer.getMicroTime()
	if timePast <= timeNow then
		timePast = timeNow
		return
	end
	love.timer.sleep(timePast - timeNow)
end

function love.keypressed(key, uni)
	OnKeyPressScene(key, uni)
	DebugControl(key, uni)
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
