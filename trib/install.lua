function InstallData()
	local con

	--:::unfinished:::if not love.filesystem.exists("configuration.lua") then
		con = io.open(love.filesystem.getSaveDirectory().."configuration.lua","w+")
		con:write(defaultConfig)
		con:close()
	--:::unfinished:::end
	
	--if not love.filesystem.exists("resources") then
		love.filesystem.mkdir("resources")
	--end
	
	--if not love.filesystem.exists("resources/sprites") then
		love.filesystem.mkdir("resources/sprites")
		require "graphics_database"
		for k,v in pairs(defaultGraphics) do
			con = io.open(love.filesystem.getSaveDirectory().."resources/sprites/"..k..".lua","w+")
			con:write(v)
			con:close()
		end
	--end
	
	--if not love.filesystem.exists("resources/objects") then
		love.filesystem.mkdir("resources/objects")

		require "objects_database"
		for k,v in pairs(objectsPresets) do
			con = io.open(love.filesystem.getSaveDirectory().."resources/objects/"..k..".lua","w+")
			con:write(v)
			con:close()
		end
	--end
	
	--if not love.filesystem.exists("resources/units.lua") then
		require "units_database"
		con = io.open(love.filesystem.getSaveDirectory().."resources/units.lua","w+")
		con:write(defaultUnits)
		con:close()
	--end

	SaveScenes("default")
end
