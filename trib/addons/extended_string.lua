function string:purify()
	self = string.gsub(self,[["]],[[\"]])
	self = string.gsub(self,[[

]],[[\r\n]])
	self = string.gsub(self,[[	]],[[\t]])
	self = string.gsub(self,"%c","")
	
	return self
end

function string:checkTable(b)
	--local e, probe
	
	e = self:find(".%..",b or 1)
	if e then
		if e < self:len() then
			probe = string.sub(self,1,e)
			
			if loadstring("probe = "..probe) then
				loadstring("probe = "..probe)()
			
				if probe then
					return self:checkTable(e + 2)
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	else
		probe = self
		
		if loadstring("probe = "..probe) then
			loadstring("probe = "..probe)()
			
			if probe then
				return true
			else
				return false
			end
		end
	end	
end