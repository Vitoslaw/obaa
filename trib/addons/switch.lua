function switch(match, cases)
	if cases[match] then
		return cases[match]
	elseif cases.default then
		return cases.default
	else
		return function() end
	end
end


