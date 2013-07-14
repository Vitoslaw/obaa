messageBox = {}
messageBox.__index = messageBox

button = {}
button.__index = button

function button.new(text, eventScheme, keybindScheme)
	return setmetatable({
		events = eventSchemes[eventScheme], eventCheck = eventSchemes[eventScheme].check,
		keybind = keybindSchemes[keybindScheme], inputPressCheck = keybindSchemes[keybindScheme].onPress, inputReleaseCheck = keybindSchemes[keybindScheme].onRelease
		highlighted = false
		},button)
end

function messageBox.new(text)
	return setmetatable({buttons = {}, text = text},messageBox)
end

function messageBox:blueprint()
	love.graphics.setColor(0xD0,0x3B,0x56)
	love.graphics.rectangle("fill", screenWidth/2 - 200, screenHeight/2 - 150, 400, 300)
	love.graphics.setColor(0,0,0)
	
	--[[IN PROGRESS]]
	
end
