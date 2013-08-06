defaultScenes = {
	["boot"] = "local sce = scene.new({})\r\n\r\nsce.objects = {\r\n\tl1 = {\r\n\t\tbackgroundControl = NewBackgroundControl(function() events._toScene(\"logo\") end)\r\n}}\r\n\r\nreturn sce",
	["logo"] = "local sce = scene.new({l1 = true})\r\n\r\nsce.objects = {\r\n\tl1 = {\r\n\t\tlogo = PictureNew(260,120,images.logoRCP,fadeOut),\r\n\t\tskip = NewBackgroundControl(\r\n\t\t\tnil,\r\n\t\t\tKeybindNew({any = function() events._toScene(\"intro\") end},{any = function() events._toScene(\"intro\") end}))}}\r\n\r\nreturn sce",
	["intro"] = "local sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	["choseUser"] = "local sce = scene.new(true)\r\n\r\sce.objects = {}\r\n\r\nreturn sce",
	["mainMenu"] = "local sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	["prepareArena"] = "local sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	["arena"] = "local sce = scene.new(false)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	["arenaScore"] = "local sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	["settings"] = "local sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	
	
	["quit"] = "sce = scene.new(true)\r\n\r\nsce.objects = {}\r\n\r\nreturn sce",
	
	["debug"] = "function DebugControl(key)\r\n\tif love.keyboard.isDown(\"alt\") then\r\n\t\tif key == \"h\" then\r\n\t\t\ttoScene(\"debugHub\")\r\n\t\tend\r\n\tend\r\nend\r\n\r\ndebugHub = scene.new()\r\n\r\ndebugHub.objects = {}"
}
