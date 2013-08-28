function ifHover(x,y,a,b,c,d)
	if type(a) == "table" then
		if not b then b = 0 end
		if a.pose.occupy and type(y) == "number" then		
			if 	a.pose.occupy[1+b]+a.x < x and 
				a.pose.occupy[3+b]+a.x > x and 
				a.pose.occupy[2+b]+a.y < y and
				a.pose.occupy[4+b]+a.y > y then
				
				return true
			else
				if a.pose.occupy[b+5] then
					return ifHover(x,y,a,b+4)
				else
					return false
				end
			end
		end
	else
		if a < x and c > x and b < y and d > y then
			return true
		else
			return false
		end
	end
end
