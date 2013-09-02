function SaveScenes(save)
	if love.filesystem.exists("saves/"..save) and save ~= "default" then
		rmFolder("saves/"..save)
		love.filesystem.mkdir("saves/"..save)

		for k,v in pairs(scenes) do
			love.filesystem.write("saves/"..save.."/"..k..".lua",v)
		end
	else
		require "scenes_database"

		rmFolder("saves/"..save)
		love.filesystem.mkdir("saves/"..save)

		for k,v in pairs(defaultScenes) do
			love.filesystem.write("saves/"..save.."/"..k..".lua",v)
		end
	end
end

function InitiateLoadScenes(s)
	save = s
	sceneFileNames = love.filesystem.enumerate("saves/"..s)
end

function LoadScenes(n)
	if sceneFileNames[n] then
		sceneName = sceneFileNames[n]:gsub(".lua","")
		scenes[sceneName] = love.filesystem.load("saves/"..save.."/"..sceneFileNames[n])()
	else
		return true
	end
end

function LoadObjects(n)
	if objectFileNames[n] then
		love.filesystem.load("resources/objects/"..objectFileNames[n])()
	
		fLoad = n
	else
		return true
	end
end

function LoadGraphics(n)
	if spriteFileNames[n] then
		if spriteFileNames[n]:find(".lua") then

		local gs,i = love.filesystem.load("resources/sprites_data/"..spriteFileNames[n])()

			for name,pos in pairs(gs) do
				graphicSchemes[name] = pos
			end

			for name,img in pairs(i) do
				images[name] = img
			end
		end
		
		mLoad = n
	else
		return true
	end
end

function LoadAudio()
	love.filesystem.load("resources/music.lua")()
	love.filesystem.load("resources/sound.lua")()
end

function SaveConfig()
	love.filesystem.write("configuration.lua","--in order to rebind keys replace the word in quotemarks with name of key of desire \r\nkeybind = {	\r\n\tblock ="..keybind..",	\r\n\tdodge = \"s\",	\r\n\twalkLeft = \"a\",	\r\n\twalkRight = \"d\",	\r\n\tcutUp = \"up\",	\r\n\tcutDown = \"down\",	\r\n\tcutSide = \"left\",	\r\n\tpush = \"right\",	\r\n\tjump = \"shift\"}\r\n\r\ngravityConstant = 10\r\n\r\nscreenWidth = 1280\r\nscreenHeight = 720\r\nisFullscreen = true\r\nisVsync = false\r\nfsaa = 3",all)
end

function KissCurrentMod()
	if not kissed then
	
	kissed = true
	
	InitiateLoadScenes("default")

	local content = {}

	for k,v in ipairs(sceneFileNames) do
		local name = string.gsub(v,".lua","")
		content[k] = love.filesystem.read("saves/default/"..v)
		content[k] = string.purify(content[k])
		content[k] = name.." = \""..content[k].."\""
	end
	
	scenesDatabase = "defaultScenes = {"
	for k,v in pairs(content) do
		if k == #content then
			scenesDatabase = scenesDatabase.."\r\n\t"..v.."\r\n}"
		else
			scenesDatabase = scenesDatabase.."\r\n\t"..v..","
		end
	end

	love.filesystem.write("scenes_database.lua-",scenesDatabase)
	
	
	
	content = {}
	
	for k,v in ipairs(objectFileNames) do
		local name = string.gsub(v,".lua","")
		content[k] = love.filesystem.read("resources/objects/"..v)
		content[k] = string.purify(content[k])
		content[k] = name.." = \""..content[k].."\""
	end
	
	objectsDatabase = "objectsPresets = {"
	for k,v in pairs(content) do
		if k == #content then
			objectsDatabase = objectsDatabase.."\r\n\t"..v.."\r\n}"
		else
			objectsDatabase = objectsDatabase.."\r\n\t"..v..","
		end
	end

	love.filesystem.write("objects_database.lua-",objectsDatabase)
	
	
	
	content = {}
	
	for k,v in ipairs(spriteFileNames) do
		local name = string.gsub(v,".lua","")
		content[k] = love.filesystem.read("resources/sprites_data/"..v)
		content[k] = string.purify(content[k])
		content[k] = name.." = \""..content[k].."\""
	end
	
	graphicsDatabase = "defaultGraphics = {"
	for k,v in pairs(content) do
		if k == #content then
			graphicsDatabase = graphicsDatabase.."\r\n\t"..v.."\r\n}"
		else
			graphicsDatabase = graphicsDatabase.."\r\n\t"..v..","
		end
	end
	
	love.filesystem.write("graphics_database.lua-",graphicsDatabase)
	
	
	
	content = {}
	
	content[1] = "DefaultMusic = \""..love.filesystem.read("resources/music.lua"):purify().."\""
	content[2] = "DefaultSound = \""..love.filesystem.read("resources/sound.lua"):purify().."\""
	
	audioDatabase = content[1].."\r\n\r\n"..content[2]
	
	love.filesystem.write("audio_database.lua-",audioDatabase)
	
	end
end