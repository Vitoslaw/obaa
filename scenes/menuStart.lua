local objects = {}
local statics = {
	l1 = {
	
		keyboardControlBackground = static.new(nil,nil,nil,nil,"quit"),
		storyMode = static.new(screenWidth/2,screenHeight/2,darkGray255,nil,nil,nil,"storyMode")
	}
}

return objects, statics
