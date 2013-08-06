function TranslateScreen()
	local scale = love.graphics.getHeight()/360
	love.graphics.scale(scale)
end

function LoadResolution()
	local succes = love.graphics.checkMode(screenWidth,screenHeight,isFullscreen)

	if succes then
		love.graphics.setMode(screenWidth,screenHeight,isFullscreen,isVsync,fsaa)
	else
		love.graphics.setMode(640,360,false,false,0)
	end
end
