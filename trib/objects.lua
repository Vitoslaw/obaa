object = {}
object.__index = object

static = {}
static.__index = static

pose = {}
pose.__index = pose

function pose.new(image,occupy,take,deal)
	return setmetatable({
		takeDamage = take,
		dealDamage = deal,
		occupy = occupy,
		image = image,
		duration = 0,
		begin = 0
		},pose)
end

function StaticProperties(physic, x, y, color, eventScheme, keybindScheme, AIScheme, graphicScheme, isObstacle, extra)
	
	if physic then
		xSpeed = 0
		ySpeed = 0
		mass = 0
		forces = physicModule
	else
		xSpeed = nil
		ySpeed = nil
		mass = nil
		forces = nil
	end
	
	if eventScheme then
		eventCheck = eventSchemes[eventScheme].check
	else
		events = nil
	end
	
	if keybindScheme then
		inputPressCheck = keybindSchemes[keybindScheme].onPress
		inputReleaseCheck = keybindSchemes[keybindScheme].onRelease
	else
		inputPressCheck = nil
		inputReleaseCheck = nil
	end
	
	if AIScheme then
		AICheck = AISchemes[AIScheme].check 
	else
		AICheck = nil
	end

	
	local tab = {
		x = x, y = y, color = color,
		xSpeed = xSpeed, ySpeed = ySpeed, mass = mass, forces = forces,
		events = eventSchemes[eventScheme], eventCheck = eventCheck,
		keybind = keybindSchemes[keybindScheme], inputPressCheck = inputPressCheck, inputReleaseCheck = inputReleaseCheck,
		AI = AISchemes[AIScheme], AICheck = AICheck,
		poses = graphicSchemes[graphicScheme], pose = {},
		material = {fire = 0, air = 0, earth = 0, water = 0, soul = 0},
		obstacle = isObstacle,
		extra = extra}
	
	return tab
end

function object.new(x, y, color, eventScheme, keybindScheme, AIScheme, graphicScheme, isObstacle, extra)
	return setmetatable(StaticProperties(true, x, y, color, eventScheme, keybindScheme, AIScheme, graphicScheme, isObstacle, extra),object)
end

function static.new(x, y, color, eventScheme, keybindScheme, AIScheme, graphicScheme, isObstacle, extra)
	return setmetatable(StaticProperties(false, x, y, color, eventScheme, keybindScheme, AIScheme, graphicScheme, isObstacle, extra),static)
end



function object:physics(elapsed)
	local n = 300	
	for i = 0, n do 
		self.x = self.x + self.xSpeed/n
		self.y = self.y + self.ySpeed/n

		UpdatePhysics(self,elapsed)
	end
end


