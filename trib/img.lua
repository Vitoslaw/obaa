graphicSchemes = {}

function graphicSchemes:add(m)
	for k,v in pairs(m) do
		graphicSchemes[k] = v
	end
end

graphicSchemes:add(dofile("trib/resources/sprites/GUI.lua"))
