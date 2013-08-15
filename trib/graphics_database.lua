defaultGraphics = {
	["GUI"] = "dir = \"resources/sprites/GUI/\"\r\n\r\nlocal missingPic = love.image.newImageData(10,10)\r\nmissingPic:mapPixel(function(x,y) if x == 1 or y == 1 then return 0,0,0,0xff end end)\r\n\r\nlocal gs = {}\r\n\r\nlocal i = {\r\n\tmissingPicture = love.graphics.newImage(missingPic)\r\n}\r\n\r\nreturn gs,i"
}
