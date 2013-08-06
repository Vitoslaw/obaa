events = {		
		_quit = function()
			love.event.push("quit")
		end,
		
		
		_toScene = function(sce)
			cache.previousScene = cache.activeScene

			scenes[cache.activeScene] = activeScene
			
			local chunk = loadstring("activeScene = "..sce)
			chunk()

			cache.activeScene = sce
		end
}

eventSchemes = {
	button = function(self)
			if self.pose.occupy then
				local f,t = pairs(self.pose.occupy)
				if ifHover(love.mouse.getX(),love.mouse.getY(),self.x+t[1],self.y+t[2],self.x+t[3],self.y+t[4]) then
					self.color = red255
				else
					self.pose = self.poses.default
				end
			else
				if self.poses then
					self.pose = self.poses.default
				end
			end
		end
}
