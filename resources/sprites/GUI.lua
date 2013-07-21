local dir = "/resources/sprites/GUI/"

local gs = {
	storyMode = {
		default = pose.new("STORY MODE",{0,0,99,32})
	},
	arenaButton = {
		default = pose.new(love.graphics.newImage(dir.."ar_but.png"),{0,0,62,16}),
		highlighted = pose.new(love.graphics.newImage(dir.."ar_but_hl.png"),{0,0,62,16})
	}
}

return gs
