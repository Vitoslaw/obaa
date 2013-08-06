events = {		
		_quit = function()
			love.event.push("quit")
		end,
		
		
		_toScene = function(sce,save)
			cache.previousScene = cache.activeScene

			if save then 
				scenes[cache.activeScene] = scenes.activeScene
			end
			
			scenes.activeScene = scenes[sce]

			cache.activeScene = sce
		end
}

effects = {
	fadeOut = function(self)
		if not self.pose.begin then self.pose.begin = clock end
		
		bg = self.pose.begin
		
		if clock - bg < 2 then
			self.color.a = (clock - bg) * 120
		elseif clock - bg > 3 then
			self.color.a = (bg - clock + 3) * 120
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
