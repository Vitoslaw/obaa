function TranslateScreen()
	screenHeight = love.graphics.getHeight()
	screenWidth = love.graphics.getWidth()

	cursorX = love.mouse.getX()
	cursorY = love.mouse.getY()

	screenRatio = screenWidth/screenHeight
	
	if screenRatio > 16/9 then
		scale = screenHeight / 360
		xLetter = (love.graphics.getWidth() - screenHeight*16/9)/2
		yLetter = 0
		
		screenHeight = screenHeight / scale
		screenWidth = screenHeight * 16/9
	else
		scale = screenWidth / 640
		yLetter = (love.graphics.getHeight() - screenWidth*9/16)/2
		xLetter = 0
		
		screenWidth = screenWidth / scale
		screenHeight = screenWidth * 9/16 
	end
end

function LoadResolution()
	local succes = love.graphics.checkMode(screenWidth,screenHeight,isFullscreen)

	if succes then
		love.graphics.setMode(screenWidth,screenHeight, isFullscreen, isVsync)
	else
		love.graphics.setMode(640, 360,false,false)
	end
end
