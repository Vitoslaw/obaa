events = {		
		_quit = function()
			love.event.push("quit")
		end,
		
		
		_toScene = function(sce,save)
			cache.previousScene = cache.activeScene
			
			if save then 
				--scenes[cache.activeScene] = scenes.activeScene
			end

			scenes.activeScene.debug = scene.new()
			scenes.activeScene = scenes[sce]
			--scenes.activeScene:scaleObjects()
			clock = 0
			
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
			if clock < start then
				self.color.a = 0
			elseif clock < inT then
				self.color.a = 255 * (clock - start)/(inT - start)
			elseif clock > outT then
				self.color.a = 0
				self = nil
			elseif clock > susT then
				self.color.a = 255 * (outT - clock)/(outT - susT)
			else
				self.color.a = 255
			end
		end
	end,
	
	fadeIn = function(start,finish,func)
	
	if not finish then finish = start + 0.5 end
	
	return function(self)
		if not self.pose.begin then self.pose.begin = start or clock end

		if clock > start then
			if clock < finish then
				self.color.a = 255 * (clock - start)/(finish - start)
			else
				self.color.a = 255
				self.event = func
			end
		else 
			self.color.a = 0
		end
	end
	end
}

eventSchemes = {
	scrollButton = function(self)
		local th = self
	
		scenes.activeScene.objects.l1.toolTip = nil
		
		if ifHover(love.mouse.getX(),love.mouse.getY(),th) then
			scenes.activeScene.objects.l1.toolTip = TooltipNew(self.metaButton.text)
			
			if self.pose.begin + self.pose.duration < clock then
				switch(self.pose.name,{
				d = function() self:swapPose(self.poses.unroll1) end,
				u1 = function() self:swapPose(self.poses.unroll2) end,
				u2 = function() self:swapPose(self.poses.unroll3) end,
				u3 = function() self:swapPose(self.poses.unroll4) end,
				u4 = function() self:swapPose(self.poses.full1) end,
				f1 = function() self:swapPose(self.poses.full2) end,
				f2 = function() self:swapPose(self.poses.full3) end,
				f3 = function() self:swapPose(self.poses.full4) end,
				f4 = function() self:swapPose(self.poses.full5) end,
				f5 = function() self:swapPose(self.poses.full6) end,
				f6 = function() self:swapPose(self.poses.full7) end,
				f7 = function() self:swapPose(self.poses.full2) end,
			
				default = function() self:swapPose(self.poses.unroll1) end
				})()
			end
		else
			if self.pose.begin + self.pose.duration < clock then
				switch(self.pose.name,{
				d = function() self:swapPose(self.poses.unroll1) end,
				u2 = function() self:swapPose(self.poses.unroll1) end,
				u3 = function() self:swapPose(self.poses.unroll2) end,
				u4 = function() self:swapPose(self.poses.unroll3) end,
				f1 = function() self:swapPose(self.poses.unroll4) end,
				f2 = function() self:swapPose(self.poses.full3) end,
				f3 = function() self:swapPose(self.poses.full4) end,
				f4 = function() self:swapPose(self.poses.full5) end,
				f5 = function() self:swapPose(self.poses.full6) end,
				f6 = function() self:swapPose(self.poses.full1) end,
			
				default = function() self:swapPose(self.poses.unroll1) end
				})()
			end
		end
	end
}
