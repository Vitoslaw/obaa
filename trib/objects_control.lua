object = {}
object.__index = object


function PoseNew(tab)
	if tab.occupy then
		for k,v in ipairs(tab.occupy) do
				if k%2 == 1 then
					tab.occupy[k] = v * scale + xLetter /scale
				else
					tab.occupy[k] = v * scale + yLetter / scale
				end
		end
	end
	
	return {
		name = tab.n,
		font = tab.font,
		scale = tab.s or 1,
		rotate = tab.r or 0,
	
		takeDamage = tab.take,
		dealDamage = tab.deal,
		occupy = tab.occupy,
		
		quad = tab.quad,
		image = tab.image,
		
		text = tab.text,
		alignment = tab.alignment or "left",
		limit = tab.limit or 640,
		xAlignment = tab.xAli,
		
		duration = tab.duration or 0.1,
		begin = tab.begin
		}
end

function QuadNew(w,h,image,...)
	local tab = {}
	
	for i,row in pairs(arg) do
		for  do	
		
		end
	end
	
	return tab
end

function object.new(tab)
	if not tab.color then
		tab.color = {r = 255, g = 255, b = 255,a = 255}
	end
	
	if not tab.poses then
		tab.poses = {}
	end
	
	if not tab.pose then
		tab.pose = tab.poses.default or {}
	end
	
	if tab.x then
		tab.x = tab.x * scale
		tab.y = tab.y * scale
	end
	
	return setmetatable(tab,object)
end


function object:swapPose(pose)
	self.pose = pose
	self.pose.begin = clock
end

function object:scale()
	for name,pose in pairs(self.poses) do
		if pose.occupy then
			for k,v in ipairs(pose.occupy) do
				if k%2 == 1 then
					self.poses[name].occupy[k] = v * scale + xLetter /scale
				else
					self.poses[name].occupy[k] = v * scale + yLetter / scale
				end
			end
		end
	end
	
	if self.pose.occupy then
		for k,v in pairs(self.pose.occupy) do
			if k%2 == 1 then
				self.pose.occupy[k] = v * scale + xLetter / scale
			else
				self.pose.occupy[k] = v * scale + yLetter / scale
			end
		end
	end
end

function object:backscale()
	for name,pose in pairs(self.poses) do
		if pose.occupy then
			for k,v in ipairs(pose.occupy) do
				if k%2 == 1 then
					self.poses[name].occupy[k] = (v - (xLetter /scale)) / scale
				else
					self.poses[name].occupy[k] = (v - (yLetter / scale)) / scale
				end
			end
		end
	end
	
	if self.pose.occupy then
		for k,v in pairs(self.pose.occupy) do
			if k%2 == 1 then
				self.pose.occupy[k] = (v - (xLetter /scale)) / scale
			else
				self.pose.occupy[k] = (v - (yLetter / scale)) / scale
			end
		end
	end
end


function object:physics(elapsed)
	local n = 300	
	for i = 0, n do 
		self.x = self.x + self.xSpeed*elapsed/n
		self.y = self.y + self.ySpeed*elapsed/n
	end
end
