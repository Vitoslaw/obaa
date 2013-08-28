color = {}
color.__index = color

function color.new(r,g,b,a)
	return setmetatable({["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or 0xff},color)
end

function ImageNew(data)
	if type(data) == "string" then
		if love.filesystem.isFile(data) then
			return love.graphics.newImage(data)
		end
	elseif data then
		return love.graphics.newImage(data)
	end
end

noMask = color.new(255,255,255,255)

transparent128 = color.new(255,255,255,128)
transparent64 = color.new(255,255,255,64)
transparent32 = color.new(255,255,255,32)
transparent0 = color.new(255,255,255,0)

black255 = color.new(0,0,0)

red255 = color.new(255,0,0,255)
darkRed255 = color.new(0xE6,0x2E,0x2E)

darkGray255 = color.new(0xBF,0xBF,0xBF)

creamy255 = color.new(0xe5,0xe5,0xc5)

graphicSchemes = {}
images = {}
