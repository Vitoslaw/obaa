eventSchemes = {
		_fall = function(self)
			switch(self.pose.name,{
				fall1 = function(self) self.pose = self.poses.fall2 end,
				fall2 = function(self) self.pose = self.poses.fall3 end
			})()
		end,
		
		_quit = function()
			love.event.push("quit")
		end,
		
		
		_toScene = function(entity)
			loadstring("activeScene = "..entity.extra.screen)()
			activeScene.cache = scene
		end
}

eventSchemes.generic = {
	check = function(self)
		if math.abs(1.5 * math.pi - math.atan2(self.ySpeed,self.xSpeed)) < 0.5 * math.pi then
			eventSchemes.generic.fall(self)
		end
	end,
	
	fall = eventSchemes._fall 
}

eventSchemes.button = {
	check = function(self)
		if self.pose.image then
			local f,t = pairs(self.pose.occupy)
			if ifHover(love.mouse.getX(),love.mouse.getY(),self.x+t[1],self.y+t[2],self.x+t[3],self.y+t[4]) then
				self.color = red255
			else
				self.color = white255
			end
		else
			if self.poses then
				self.pose = self.poses.default
			end
		end
	end
}

eventSchemes.boot = {
	check = function(self)
		eventSchemes._toScene(self)
	end
}
