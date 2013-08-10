function InstallData()

	--:::unfinished:::if not love.filesystem.exists("configuration.lua") then
		love.filesystem.write("configuration.lua",defaultConfig)
	--:::unfinished:::end
	
	--if not love.filesystem.exists("resources") then
		love.filesystem.mkdir("resources")
	--end
	
	--if not love.filesystem.exists("resources/sprites") then
		love.filesystem.mkdir("resources/sprites")
		require "graphics_database"
		for k,v in pairs(defaultGraphics) do
			love.filesystem.write("resources/sprites/"..k..".lua",v)
		end
	--end
	
	--if not love.filesystem.exists("resources/objects") then
		love.filesystem.mkdir("resources/objects")

		require "objects_database"
		for k,v in pairs(objectsPresets) do
			love.filesystem.write("resources/objects/"..k..".lua",v)
		end
	--end
	
	--if not love.filesystem.exists("resources/units.lua") then
		require "units_database"
		love.filesystem.write("resources/units.lua",unitPresets)
	--end

	SaveScenes("default")
end
