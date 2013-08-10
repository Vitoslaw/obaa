events = {		
		_quit = function()
			love.event.push("quit")
		end,
		
		
		_toScene = function(sce,save)
			clock = 0
			
			cache.previousScene = cache.activeScene

			if save then 
				scenes[cache.activeScene] = scenes.activeScene
			end
			
			scenes.activeScene = scenes[sce]

			cache.activeScene = sce
		end,
		
		_wait = function(period)
			if not cache.wait then cache.wait = clock end
			
			if clock - cache.wait > period then
				cache.wait = nil
				return true
			else
				return false
			end
		end
}

effects = {
	fadeOut = function(self)
		if not self.pose.begin then self.pose.begin = clock end
		
		bg = self.pose.begin
		
		if clock - bg < 2 then
			self.color.a = (clock - bg) * 126
		elseif clock - bg > 3 and clock - bg < 5 then
			self.color.a = (bg - clock + 3) * 126
		elseif clock - bg > 5 then
			self.color.a = 0
		end
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
