graphicSchemes = {}

function graphicSchemes:add(m)
	for k,v in pairs(m) do
		graphicSchemes[k] = v
	end
end


function LoadGraphics()
	graphicSchemes:add(dofile(installLocation.."/resources/sprites/GUI.lua"))
end
