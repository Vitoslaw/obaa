function rmFolder(folder)
	files = love.filesystem.enumerate(folder)

	for k,v in pairs(files) do
		if love.filesystem.isFile(folder.."/v") then
			love.filesystem.remove(folder.."/v")
		elseif love.filesystem.isDirectory(folder.."/v") then
			rmFolder(folder.."/v")
		end
	
	end
	
	love.filesystem.remove(folder)
end