object = {}
object.__index = object


function PoseNew(tab)
	return {
		takeDamage = tab.take,
		dealDamage = tab.deal,
		occupy = tab.occupy,
		image = tab.image,
		text = tab.text,
		duration = tab.duration,
		begin = tab.begin
		}
end

function object.new(tab)
	tab.color = {r = 255, g = 255, b = 255,a = 255}
	return setmetatable(tab,object)
end



function object:physics(elapsed)
	local n = 300	
	for i = 0, n do 
		self.x = self.x + self.xSpeed*elapsed/n
		self.y = self.y + self.ySpeed*elapsed/n
	end
end
