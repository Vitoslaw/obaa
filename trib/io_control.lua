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
	sceneFiles = love.filesystem.enumerate("saves/"..s)
	dumb,sceneFileNames = ipairs(sceneFiles)
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
		objectName = objectFileNames[n]:gsub(".lua","")
		objectsName = love.filesystem.load("resources/objects/"..objectFileNames[n])()
	
		f = n
	else
		return true
	end
end

function LoadGraphics(n)
	if spriteFileNames[n] then
		if spriteFileNames[n]:find(".lua") then

		gs,i = love.filesystem.load("resources/sprites/"..spriteFileNames[n])()

			for name,pos in pairs(gs) do
				graphicSchemes[name] = pos
			end

			for name,img in pairs(i) do
				images[name] = img
			end
		end
		
		m = n
	else
		return true
	end
end

function SaveConfig()
	love.filesystem.write("configuration.lua","--in order to rebind keys replace the word in quotemarks with name of key of desire \r\nkeybind = {	\r\n\tblock ="..keybind..",	\r\n\tdodge = \"s\",	\r\n\twalkLeft = \"a\",	\r\n\twalkRight = \"d\",	\r\n\tcutUp = \"up\",	\r\n\tcutDown = \"down\",	\r\n\tcutSide = \"left\",	\r\n\tpush = \"right\",	\r\n\tjump = \"shift\"}\r\n\r\ngravityConstant = 10\r\n\r\nscreenWidth = 1280\r\nscreenHeight = 720\r\nisFullscreen = true\r\nisVsync = false\r\nfsaa = 3",all)
end
