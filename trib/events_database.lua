events = {		
		_quit = function()
			love.event.push("quit")
		end,
		
		
		_toScene = function(sce,save)
			cache.brek = true

			cache.previousScene = cache.activeScene
			
			if not save then 
				scenes[cache.activeScene] = cache.activeSceneData
			end
			
			cache.activeSceneData = scenes[sce]

			activeScene = {}
			activeScene = scenes[sce]
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
				self.color.a = 1
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
	animation = function(self)
		
	end,

	
	
	scrollButton = function(th)
		activeScene.objects.l1.toolTip = nil
		
		if ifHover(love.mouse.getX(),love.mouse.getY(),th) then
			activeScene.objects.l1.toolTip = TooltipNew(th.metaButton.text)
			
			if th.pose.begin + th.pose.duration < clock then
				switch(th.pose.name,{
				d = function() th:swapPose(th.poses.unroll1) end,
				u1 = function() th:swapPose(th.poses.unroll2) end,
				u2 = function() th:swapPose(th.poses.unroll3) end,
				u3 = function() th:swapPose(th.poses.unroll4) end,
				u4 = function() th:swapPose(th.poses.full1) end,
				f1 = function() th:swapPose(th.poses.full2) end,
				f2 = function() th:swapPose(th.poses.full3) end,
				f3 = function() th:swapPose(th.poses.full4) end,
				f4 = function() th:swapPose(th.poses.full5) end,
				f5 = function() th:swapPose(th.poses.full6) end,
				f6 = function() th:swapPose(th.poses.full7) end,
				f7 = function() th:swapPose(th.poses.full2) end,
			
				default = function() th:swapPose(th.poses.unroll1) end
				})()
			end
		else
			if th.pose.begin + th.pose.duration < clock then
				switch(th.pose.name,{
				d = function() th:swapPose(th.poses.unroll1) end,
				u2 = function() th:swapPose(th.poses.unroll1) end,
				u3 = function() th:swapPose(th.poses.unroll2) end,
				u4 = function() th:swapPose(th.poses.unroll3) end,
				f1 = function() th:swapPose(th.poses.unroll4) end,
				f2 = function() th:swapPose(th.poses.full3) end,
				f3 = function() th:swapPose(th.poses.full4) end,
				f4 = function() th:swapPose(th.poses.full5) end,
				f5 = function() th:swapPose(th.poses.full6) end,
				f6 = function() th:swapPose(th.poses.full1) end,
			
				default = function() th:swapPose(th.poses.unroll1) end
				})()
			end
		end
	end
}
