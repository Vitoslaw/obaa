function SaveScenes(save)
	if love.filesystem.exists("saves/"..save) and save ~= "default" then
		love.filesystem.remove("saves/"..save)
		love.filesystem.mkdir("saves/"..save)

		for k,v in pairs(scenes) do
			love.filesystem.write("saves/"..save.."/"..k..".lua",v)
		end
	else
		require "scenes_database"

		cache.succes = love.filesystem.remove("saves/"..save)
		love.filesystem.mkdir("saves/"..save)

		for k,v in pairs(defaultScenes) do
			love.filesystem.write("saves/"..save.."/"..k..".lua",v)
		end
	end
end

function LoadScenes(save)
	sceneFiles = love.filesystem.enumerate("saves/"..save)
	scenes = {}
	
	for k, v in pairs(sceneFiles) do
		sceneName = v:gsub(".lua","")
		scenes[sceneName] = love.filesystem.load("saves/"..save.."/"..v)()
	end
end

function LoadObjects()
	objectFiles = love.filesystem.enumerate("resources/objects")
	
	for k, v in pairs(objectFiles) do
		objectName = v:gsub(".lua","")
		objectsName = love.filesystem.load("resources/objects/"..v)()
	end
end

function LoadGraphics()
	spritesData = love.filesystem.enumerate("resources/sprites")
	
	for dumb,fileName in pairs(spritesData) do
		if fileName:find(".lua") then
		
		gs,i = love.filesystem.load("resources/sprites/"..fileName)()
		
			for name,pos in pairs(gs) do
				graphicSchemes[name] = pos
			end
			
			for name,img in pairs(i) do
				images[name] = img
			end
		end
	end
end

function SaveConfig()
	love.filesystem.write("configuration.lua","--in order to rebind keys replace the word in quotemarks with name of key of desire \r\nkeybind = {	\r\n\tblock ="..keybind..",	\r\n\tdodge = \"s\",	\r\n\twalkLeft = \"a\",	\r\n\twalkRight = \"d\",	\r\n\tcutUp = \"up\",	\r\n\tcutDown = \"down\",	\r\n\tcutSide = \"left\",	\r\n\tpush = \"right\",	\r\n\tjump = \"shift\"}\r\n\r\ngravityConstant = 10\r\n\r\nscreenWidth = 1280\r\nscreenHeight = 720\r\nisFullscreen = true\r\nisVsync = false\r\nfsaa = 3",all)
end
