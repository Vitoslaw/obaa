defaultScenes = {
	["boot"] = "local sce = scene.new({})\r\n\r\nsce.objects = {\r\n\tl1 = {\r\n\t\tbackgroundControl = NewBackgroundControl(function() love.graphics.setBackgroundColor(0x34,0x5b,0x82) events._toScene(\"logo1\") end)\r\n}}\r\n\r\nreturn sce",
	["logo1"] = "local sce = scene.new({l1 = true, l2 = true})\r\n\r\nsce.objects = {\r\n\tl1 = {\r\n\t\tlogo = PictureNew(260,120,images.logoRCP,\"fadeOut\"),\r\n\t\tskip = NewBackgroundControl(\r\n\t\t\tfunction() if events._wait(5) then love.graphics.setBackgroundColor(0xff,0xff,0xff) events._toScene(\"logo2\") end end,\r\n\t\t\tKeybindNew({any = function() love.graphics.setBackgroundColor(0xff,0xff,0xff) events._toScene(\"logo2\") end},{any = function() love.graphics.setBackgroundColor(0xff,0xff,0xff) events._toScene(\"intro\") end}))\r\n}}\r\n\r\nreturn sce",
	["logo2"] = "local sce = scene.new({l1 = true})\r\n\r\nsce.objects = {\r\n\tl1 = {\r\n\t\tlogo = PictureNew(133,120,images.logoLove,\"fadeOut\"),\r\n\t\ttext = TextNew(),\r\n\t\tskip = NewBackgroundControl(\r\n\t\t\tfunction() if events._wait(5) then love.graphics.setBackgroundColor(0,0,0) events._toScene(\"intro\") end end,\r\n\t\t\tKeybindNew({any = function() love.graphics.setBackgroundColor(0,0,0) events._toScene(\"intro\") end},{any = function() love.graphics.setBackgroundColor(0,0,0) events._toScene(\"intro\") end}))\r\n\t}\r\n}\r\n\r\nreturn sce",
	["intro"] = "local sce = scene.new({l1 = true})\r\n\r\nsce.objects = {\r\n\tl1 = {\r\n\t\t}}\r\n\r\nreturn sce",
	["choseUser"] = "local sce = scene.new(true)\r\n\r\sce.objects = {}\r\n\r\nreturn sce",
	["mainMenu"] = "local sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	["prepareArena"] = "local sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	["arena"] = "local sce = scene.new(false)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	["arenaScore"] = "local sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	["settings"] = "local sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	
	
	["quit"] = "sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	
	["debug"] = "function DebugControl(key)\r\n\tif love.keyboard.isDown(\"alt\") then\r\n\t\tif key == \"h\" then\r\n\t\t\ttoScene(\"debugHub\")\r\n\t\tend\r\n\tend\r\nend\r\n\r\ndebugHub = scene.new()\r\n\r\ndebugHub.objects = {}"
}
