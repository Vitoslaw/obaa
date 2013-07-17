keybind = {}
keybind.__index = keybind

function keybind.new(name)
	return setmetatable({
		press = {}, release = {},
		pressMouse = {}, releaseMouse = {},
		onPress = function(self, key, x, y)
			if x then
				if keybindSchemes[name].pressMouse[key] then
					keybindSchemes[name].pressMouse[key](self, x, y)
				end
			else
				if keybindSchemes[name].press[key] then
					keybindSchemes[name].press[key](self)
				end
			end
		end,
		
		onRelease = function(self, key, x, y)
			if x then
				if keybindSchemes[name].releaseMouse[key] then
					keybindSchemes[name].releaseMouse[key](self, x, y)
				end
			else
				if keybindSchemes[name].release[key] then
					keybindSchemes[name].release[key](self)
				end
			end
		end
	},keybind)
end

function LoadKeybinds()
	keybindSchemes = {
		
		quit = keybind.new("quit"),
		toStartMenu = keybind.new("toStartMenu"),
		
		newGameButton = keybind.new("newGameButton"),
		arenaButton = keybind.new("arenaButton")
		
	}
	
	keybindSchemes.quit.press = {
		["escape"] = function() eventSchemes._quit() end
	}
	
	keybindSchemes.toStartMenu.press = {
		["escape"] = function() eventSchemes._toScene(startMenu) end
	}
	
	
	

	keybindSchemes.newGameButton.pressMouse = {
		["l"] = function(self, x, y) 
			local d,t = pairs(self.pose.occupy)
			if ifHover(
				x,y,
				self.x+t[1],
				self.y+t[2],
				self.x+t[3],
				self.y+t[4]) 
			then 
				eventSchemes._toScene(choseMode)
			end 
		end
	}
		
	keybindSchemes.arenaButton.pressMouse = {
		["l"] = function(self,x,y)
			local d,t = pairs(self.pose.occupy)
			if ifHover(x,y,
				self.x+t[1],
				self.y+t[2],
				self.x+t[3],
				self.y+t[4])
			then
				eventSchemes._toScene(arenaConf)
			end
		end
	}
end
