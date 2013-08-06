objectsPresets = {
	["GUI"] = "function PictureNew(x,y,image)\r\n\tlocal pos = PoseNew({image = image})\r\n\treturn object.new({x = x, y = y, pose = pos})\r\nend\r\n\r\nfunction TextNew(x,y,text)\r\n\tlocal pos = PoseNew({[\"text\"] = text})\r\n\r\n\treturn object.new({x = x, y = y, pose = pos})\r\nend\r\n\r\nfunction NewBackgroundControl(event, keybind)\r\n\treturn {keybind = keybind, event = event}\r\nend"
}
