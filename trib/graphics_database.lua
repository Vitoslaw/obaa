defaultGraphics = {
	GUI = "dir = \"resources/sprites/GUI/\"\r\n\r\nlocal whiteMask = love.image.newImageData(640,360)\r\nwhiteMask:mapPixel(function() return 0xff,0xff,0xff,0xff end)\r\n\r\nlocal gs = {\r\n\t\r\n}\r\n\r\nlocal i = {\r\n\twhiteMask = love.graphics.newImage(whiteMask),\r\n\tswordMenu = love.graphics.newImage(dir..\"main_menu_sword.png\")\r\n}\r\n\r\nreturn gs,i"
}