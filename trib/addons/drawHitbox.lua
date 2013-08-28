function drawHitbox(x,y,box,n)
	if not n then n = 0 end

	love.graphics.rectangle("line",x+box[n+1],y+box[n+2],box[n+3]-box[n+1],box[n+4]-box[n+2])

	if box[n+5] then
		drawHitbox(box,n+5)
	else
		return
	end
end
