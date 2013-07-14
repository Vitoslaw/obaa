physicModule = {
	gravity = force.new("gravity"),
	dragAir = force.new("dragAir"),
	pressure = force.new("pressure"),
	legsForceH = force.new(),
	legsForceV = force.new()
}

forceEquasions = {
	gravity = function(entity) 
		return gravityConstant * handler.mass, 1.5*math.pi 
	end,

	dragAir = function(handler)
		return 0.4 * (math.sqrt(handler.xSpeed^2 + handler.ySpeed^2))^3, math.pi + math.atan2(handler.ySpeed,handler.xSpeed)
	end,

	pressure = function(handler)
		local distance = 0
		local direction = 0
		
		--check all objects on scene
		for k,object in pairs(activeScene.objects) do
			--check if object react to preassure
			if object.obstacle == true then
				--
				for i = 1,#handler.pose.occupy,4 do	
				
					for j = 1,#object.pose.occupy,4 do
						local width = math.abs(object.pose.occupy[i] - object.pose.occupy[i+2])
						local height = math.abs(object.pose.occupy[i+1] - object.pose.occupy[i+3])
						
						if 	(math.abs(handler.pose.occupy[j] - object.pose.occupy[i]) < width 
							and 
							math.abs(handler.pose.occupy[j] - object.pose.occupy[i+2]) < width) 
							or 
							(math.abs(handler.pose.occupy[j+2] - object.pose.occupy[i]) < width 
							and 
							math.abs(handler.pose.occupy[j+2] - object.pose.occupy[i+2]) < width)
						then
							local dist = handler.pose.occupy[j+1] - object.pose.occupy[i+3]
							
							
								
						end
					end
				end
			end 
		end

		return gravityConstant * handler.mass / distance ^ 4, direction
	end
}
