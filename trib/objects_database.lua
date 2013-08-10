objectsPresets = {
	["GUI"] = "function PictureNew(x,y,image,effect)\r\n\tlocal pos = PoseNew({image = image})\r\n\treturn object.new({x = x, y = y, pose = pos, event = effects[effect]})\r\nend\r\n\r\nfunction TextNew(x,y,text,effect)\r\n\tlocal pos = PoseNew({[\"text\"] = text})\r\n\r\n\treturn object.new({x = x, y = y, pose = pos, event = effects[effect]})\r\nend\r\n\r\nfunction NewBackgroundControl(event, keybind)\r\n\treturn object.new({keybind = keybind, event = event})\r\nend\r\n\r\nfunction NewDialogControl(text,color,delay)\r\n\treturn object.new({})\r\nend"
}
