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
	fadeOut = function(start,inT,susT,outT)

		if not inT then
			local inT = 2
			local susT = 3
			local outT = 5
		end
		
		return function(self)
			if not self.pose.begin then self.pose.begin = start or clock end
			
			start = self.pose.begin
			if clock < start or clock > outT then
				self.color.a = 0
			elseif clock < inT then
				self.color.a = 255 * (clock - start)/(inT - start)
			elseif clock > susT then
				self.color.a = 255 * (outT - clock)/(outT - susT)
			end
		end
	end,
	
	fadeIn = function(start,finish)
	
	if not finish then finish = start + 0.5 end
	
	return function(self)
		if not self.pose.begin then self.pose.begin = start or clock end

		if clock > start then
			if clock < finish then
				self.color.a = 255 * (clock - start)/(finish - start)
			else
				self.color.a = 255
				self.event = nil
			end
		else 
			self.color.a = 0
		end
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
