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

function StaticProperties(physic, x, y, col, eventScheme, keybindScheme, AIScheme, graphicScheme, isObstacle, extra)
	
	if physic then
		xSpeed = 0
		ySpeed = 0
		mass = 0
		forces = physicModule
	end
	
	if eventScheme then
		eventCheck = eventSchemes[eventScheme].check
	end
	
	if keybindScheme then
		inputPressCheck = keybindSchemes[keybindScheme].onPress
		inputReleaseCheck = keybindSchemes[keybindScheme].onRelease
	end
	
	if AIScheme then
		AICheck = AISchemes[AIScheme].check
	end


	if graphicScheme then
		po = graphicSchemes[graphicScheme].default
	else
		po = {}
	end
	
	local tab = {
		x = x, y = y, color = col,
		xSpeed = xSpeed, ySpeed = ySpeed, mass = mass, forces = forces,
		events = eventSchemes[eventScheme], eventCheck = eventCheck,
		keybind = keybindSchemes[keybindScheme], inputPressCheck = inputPressCheck, inputReleaseCheck = inputReleaseCheck,
		AI = AISchemes[AIScheme], AICheck = AICheck,
		poses = graphicSchemes[graphicScheme], pose = po,
		material = {fire = 0, air = 0, earth = 0, water = 0, soul = 0},
		obstacle = isObstacle,
		extra = extra}
	
	return tab
end

function object.new(x, y, col, eventScheme, keybindScheme, AIScheme, graphicScheme, isObstacle, extra)
	return setmetatable(StaticProperties(true, x, y, col, eventScheme, keybindScheme, AIScheme, graphicScheme, isObstacle, extra),object)
end

function static.new(x, y, col, eventScheme, keybindScheme, AIScheme, graphicScheme, isObstacle, extra)
	return setmetatable(StaticProperties(false, x, y, col, eventScheme, keybindScheme, AIScheme, graphicScheme, isObstacle, extra),static)
end



function object:physics(elapsed)
	local n = 300	
	for i = 0, n do 
		self.x = self.x + self.xSpeed/n
		self.y = self.y + self.ySpeed/n

		UpdatePhysics(self,elapsed)
	end
end
