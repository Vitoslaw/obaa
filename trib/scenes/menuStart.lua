local objects = {}
local statics = {
	l1 = {
	
		keyboardControlBackground = static.new(nil,nil,nil,"quit"),
		newGameButton = static.new(screenWidth/2-49,screenHeight/2-8,"button","newGameButton",nil,"newGameButton")
	}
}

return objects, statics
