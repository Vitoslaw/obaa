function KeybindNew(press,pressM,release,releaseM)
	if not press then press = {} end
	if not pressM then pressM = {} end
	if not release then release = {} end
	if not releaseM then releaseM = {} end
	
	return {		
		press = press, release = release,
		pressMouse = pressM, releaseMouse = releaseM,
		onPress = function(self, key, x, y)
			if x then
				if self.keybind.pressMouse[key] then
					self.keybind.pressMouse[key](self, x, y)
				elseif self.keybind.pressMouse.any then
					self.keybind.pressMouse.any(self, x, y)
				end
			else
				if self.keybind.press[key] then
					self.keybind.press[key](self)
				elseif self.keybind.press.any then
					self.keybind.press.any(self)
				end
			end
		end,
		
		onRelease = function(self, key, x, y)
			if x then
				if self.keybind.releaseMouse[key] then
					self.keybind.releaseMouse[key](self, x, y)
				elseif self.keybind.releaseMouse.any then
					self.keybind.releaseMouse.any(self, x, y)
				end
			else
				if self.keybind.release[key] then
					self.keybind.release[key](self)
				elseif self.keybind.release.any then
					self.keybind.release.any(self)
				end
			end
		end
	}
end

function LoadKeybinds()
	keybindSchemes = {
		
	}
end
