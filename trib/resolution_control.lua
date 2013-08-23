function TranslateScreen()
	screenHeight = love.graphics.getHeight()
	screenWidth = love.graphics.getWidth()

	local scale = screenHeight / 360
	love.graphics.scale(math.sqrt(scale))
	
	screenWidth = screenWidth / scale
	screenHeight = screenHeight / scale
end

function LoadResolution()
	local succes = love.graphics.checkMode(screenWidth,screenHeight,isFullscreen)

	if succes then
		love.graphics.setMode(screenWidth,screenHeight,isFullscreen,isVsync,fsaa)
	else
		love.graphics.setMode(640,360,false,false,0)
	end
end
