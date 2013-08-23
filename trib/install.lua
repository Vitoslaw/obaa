function InstallData()
	KissCurrentMod()
	
	loadstring(audioDatabase)()
	loadstring(graphicsDatabase)()
	loadstring(objectsDatabase)()
	loadstring(scenesDatabase)()


	--[[if not love.filesystem.exists("configuration.lua") then
		love.filesystem.write("configuration.lua",defaultConfig)
	end
	
	if not love.filesystem.exists("resources") then
		love.filesystem.mkdir("resources")
	end
	
	if not love.filesystem.exists("resources/sprites_data") then
		love.filesystem.mkdir("resources/sprites_data")
		
		require "graphics_database"
		for k,v in pairs(defaultGraphics) do
			love.filesystem.write("resources/sprites_data/"..k..".lua",v)
		end
	end
	
	if not love.filesystem.exists("resources/objects") then
		love.filesystem.mkdir("resources/objects")

		require "objects_database"
		for k,v in pairs(objectsPresets) do
			love.filesystem.write("resources/objects/"..k..".lua",v)
		end
	end
	
	if not love.filesystem.exists("resources/music") or not love.filesystem.exists("resources/sound") then
		require "audio_database"
		
		love.filesystem.write("resources/music.lua",defaultMusic)
		love.filesystem.write("resources/sound.lua",defaultSound)
	end
	
	if not love.filesystem.exists("resources/units.lua") then
		require "units_database"
		love.filesystem.write("resources/units.lua",unitPresets)
	end

	if not love.filesystem.exists("saves/default") then
		SaveScenes("default")
	end]]
end
