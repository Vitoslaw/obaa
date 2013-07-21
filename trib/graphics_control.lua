color = {}
color.__index = color

function color.new(r,g,b,a)
	return setmetatable({["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a},color)
end

white255 = color.new(255,255,255,255)
red255 = color.new(255,0,0,255)
darkGray255 = color.new(0xBF,0xBF,0xBF)

graphicSchemes = {}

function graphicSchemes:add(m)
	for k,v in pairs(m) do
		graphicSchemes[k] = v
	end
end


function LoadGraphics()
	graphicSchemes:add(dofile("/home/wagner/tribute/resources/sprites/GUI.lua"))
end
