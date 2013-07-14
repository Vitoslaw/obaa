force = {}
force.__index = force

function force.new(equasion)	
	if equasion and forceEquasions then 
		local equasion = forceEquasions[equasion]
	end	

	return setmetatable({
		magnitude = 0, direction = 0,
		equasion = equasion
		},force)
end

function force:set(magnitude,direction)
	force.magnitude = magnitude
	force.direction = direction
end

function force:update(handler,elapsed)
	if self.equasion then
		self:set(self.equasion(handler,elapseds))
	end
end

function UpdatePhysics(handler, elapsed)
	for k,v in pairs(handler.forces) do
		v:update(handler, elapsed)
	end
	
	local xAcceleration = 0
	local yAcceleration = 0
	
	for k,v in pairs(handler.forces) do
		xAcceleration = xAcceleration + v.magnitude * math.cos(v.direction) / self.weight
		yAcceleration = yAcceleration + v.magnitude * math.sin(v.direction) / self.weight
	end

	local accelerationMagnitude = math.sqrt(xAcceleration^2+yAcceleration^2)
	local accelerationDirection = math.atan2(xAcceleration,yAcceleration)



	local speedDirection = math.atan2(handler.ySpeed,handler.xSpeed)
	local speedMagnitude = math.sin(speedDirection) * handler.ySpeed

	local accelerationPerpendicular = accelerationMagnitude * math.sin(accelerationDirection - speedDirection)
	local accelerationParallel = accelerationMagnitude * math.cos(accelerationDirection - speedDirection)
		
	local speedMagnitude = speedMagnitude + accelerationParallel * elapsed
	
	if speedMagnitude ~= 0 then 
		speedDirection = speedDirection + accelerationPerpendicular * elapsed / speedMagnitude
	else
		speedDirection = 0
	end
	
	handler.xSpeed = math.floor(speedMagnitude * math.sin(speedDirection))
	handler.ySpeed = math.floor(speedMagnitude * math.cos(speedDirection))
end
