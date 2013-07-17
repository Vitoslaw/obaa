scene = {}
scene.__index = scene

function scene.new()
	return setmetatable({objects = {}, statics = {}},scene)
end


function LoadScenes()
	startMenu = scene.new()
	choseMode = scene.new()
	arenaConf = scene.new()
	arena = scene.new()

	startMenu.objects, startMenu.statics = dofile(installLocation.."/scenes/menuStart.lua")
	choseMode.objects, choseMode.statics = dofile(installLocation.."/scenes/menuChose.lua")
	arenaConf.objects, arenaConf.statics = dofile(installLocation.."/scenes/menuArena.lua")

	activeScene = startMenu
end


function scene:update(elapsed)
	for dumb,tab in pairs(self) do
		for m,layer in pairs(tab) do
			for k,v in pairs(layer) do
				if v.AICheck then
					v:AICheck(elapsed)
				end
				
				if v.eventCheck then
					v:eventCheck(elapsed)
				end
				
				if v.physics then
					v:physics(elapsed)
				end
			end
		end
	end
end

function scene:onKeyPress(key)
	for dumb,tab in pairs(self) do
		for m,layer in pairs(tab) do
			for k,v	in pairs(layer) do
				if v.inputPressCheck then
					v:inputPressCheck(key)
				end
			end
		end
	end
end

function scene:onKeyRelease(key)
	for dumb,tab in pairs(self) do 
		for m,layer in pairs(tab) do
			for k,v	in pairs(layer) do
				if v.inputReleaseCheck then
					v:inputReleaseCheck(key)
				end
			end
		end
	end
end

function scene:onMousePress(key, x, y)
	for dumb,tab in pairs(self) do
		for m,layer in pairs(tab) do
			for k,v	in pairs(layer) do
				if v.inputPressCheck then
					v:inputPressCheck(key, x, y)
				end
			end
		end
	end
end

function scene:onMouseRelease(key, x, y)
	for dumb,tab in pairs(self) do
		for m,layer in pairs(tab) do
			for k,v	in pairs(layer) do
				if v.inputReleaseCheck then
					v:inputReleaseCheck(key, x, y)
				end
			end
		end
	end
end

function scene:draw()
	for dumb,tab in pairs(self) do
		for m,layer in pairs(tab) do
			for k,v	in pairs(layer) do
				if v.color then
					love.graphics.setColor(v.color.r,v.color.g,v.color.b,v.color.a)
				else
					love.graphics.setColor(0xff,0xff,0xff,0xff)
				end
				
				if v.pose.image then
					love.graphics.draw(v.pose.image,v.x,v.y)
				end
			end
		end
	end
end





function UpdateScene(elapsed)
	activeScene:update(elapsed)
end

function DrawScene()
	activeScene:draw()
end

function OnKeyPressScene(key)
	activeScene:onKeyPress(key)
end

function OnKeyReleaseScene(key)
	activeScene:onKeyRelease(key)
end

function OnMousePressScene(key, x, y)
	activeScene:onMousePress(key, x, y)
end

function OnMouseReleaseScene(key, x, y)
	activeScene:onMouseRelease(key, x, y)
end
