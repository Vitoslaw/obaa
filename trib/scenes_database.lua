defaultScenes = {
	["bootScene"] = "bootScene = scene.new({})\r\n\r\nbootScene.objects = {\r\n\tl1 = {backgroundControl = NewBackgroundControl(function() events._toScene(\"logoScene\") end)\r\n}}\r\n\r\nactiveScene = bootScene\r\ncache.activeScene = \"bootScene\"",
	["logoScene"] = "logoScene = scene.new({l1 = true})\r\n\r\nlogoScene.objects = {\r\n\tl1 = {\r\n\t\tlogo = PictureNew(260,120,images.logoRCP)\r\n}}",
	["introScene"] = "introScene = scene.new(true)\r\n\r\nintroScene.objects = {}\r\nintroScene.statics = {}",
	["choseUser"] = "choseUser = scene.new(true)\r\n\r\nchoseUser.objects = {}\r\nchoseUser.statics = {}",
	["mainMenu"] = "mainMenu = scene.new(true)\r\n\r\nmainMenu.objects = {}\r\nmainMenu.statics = {}",
	["prepareArenaScene"] = "prepareArenaScene = scene.new(true)\r\n\r\nprepareArenaScene.objects = {}\r\nprepareArenaScene.statics = {}",
	["arenaScene"] = "arenaScene = scene.new(false)\r\n\r\narenaScene.objects = {}\r\narenaScene.statics = {}",
	["arenaScoreScene"] = "arenaScoreScene = scene.new(true)\r\n\r\narenaScoreScene.objects = {}\r\narenaScoreScene.statics = {}",
	["settingsScene"] = "settingsScene = scene.new(true)\r\n\r\nsettingsScene.objects = {}\r\nsettingsScene.statics = {}",
	
	
	["quitScene"] = "quitScene = scene.new(true)\r\n\r\nquitScene.objects = {}\r\nquitScene.statics = {}",
	
	["debug"] = "function DebugControl(key)\r\n\tif love.keyboard.isDown(\"alt\") then\r\n\t\tif key == \"h\" then\r\n\t\t\tactiveScene = debugHub\r\n\t\tend\r\n\tend\r\nend\r\n\r\ndebugHub = scene.new()\r\n\r\ndebugHub.objects = {}\r\ndebugHub.statics = {}"
}
